%ELE515 ÖDEV3 Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU2
%SORU2 Bölüm 2.1
%SORU2-a)
%Sistemin durum uzayı gösterimi ve transfer fonksiyonu hesaplanmıştır.
%R1 = 2, R2 = 1, C1 = 1, L1 = 2 değerleri kullanılmaktadır. 

%SORU2-b)
R1 = 2;%R1 parametresi.
R2 = 1;%R2 parametresi.
C1 = 1;%C1 parametresi.
L1 = 2;%L1 parametresi.
Am = [-1/(C1*R1+C1*R2) -R1/(C1*R1+C1*R2);R1/(L1*R1+R2*L1) -R1];
Bm = [1/(C1*R1+C1*R2);R2/(R1*L1+R2*L1)];
Cm = [-R2/(R1+R2) -(R1*R2)/(R1+R2)];
Dm = R2/(R1+R2);
G = ss(Am,Bm,Cm,Dm);%Durum uzayı gösteriminin G'ye kaydedilmesi.
Gtf=tf(G);%G durum uzayının transfer fonksiyonu Gtf. Elle elde edilmiş sonuç ile tutarlıdır.
impulse(G);%Birim dürtü cevabının çizdirilmesi.
grid;
figure;
step(G);%Birim basamak cevabının çizdirilmesi.
grid;
figure;
pzmap(G);%Kutup ve sıfırlarının çizdirilmesi.
grid;
figure;
bode(G);%Bode grafiğinin çizdirilmesi. Frekans Cevabı.
grid;

%SORU2-c)
%sisotool(G);%sisotool ile istenilen değerlerde pid kontrolcü 
%tasarlanmaya çalışılmıştır ve export edilmiştir. Tasarlanan kontrolcü
%165.95*(1/s) şeklindedir PID kontrolcü değildir. İstenilen kısıtlamalar için PID kontrolcü bu
%sistem için tasarlanamaz.
s=tf('s');
C_SORU2_PID=165.95*(1/s);
disp(pid(C_SORU2_PID));%Tasarlanmış olan kontrolcünün katsayıları komut ekranında gösterilmektedir. D terimi için filtre de kullanılmıştır.
GclSORU2PID = feedback(G*C_SORU2_PID,1);%GclSORU1PID Kapalı çevrim sisteminin oluşturulması.
figure;
step(GclSORU2PID);%GclSORU2PID Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
legend('PID kontrolcü tasarımı başarısız.');
grid;
% figure;
% impulse(GclSORU2PID);%GclSORU1LQI Kapalı çevrim sisteminin birim dürtü cevabının çizdirilmesi.
% grid;
% n = length(GclSORU2PID.A); % Durum vektörü sayısı
% initial(GclSORU2PID,ones(n,1)); % İlk durum cevabını çizdir

%SORU2-d)
%Kısıtlamalar altında LQI kontrolcü tasarlanmaya çalışılmıştır. Tasarlanan kontrolcü
%için Q=1000 girilmektedir. İstenilen kısıtlamalar için LQI kontrolcü bu
%sistem için tasarlanamaz.
s=tf('s');
Q=1000*eye(3);%Regülasyonun hızlanması için "Q" arttırılmalı.(2 sistem durumu + 1 integralci durumu)
R=100;%Az enerji harcanması için "R" arttırılmalı.  
K=lqi(G,Q,R);%Kazanç matrisinin oluşturulması.
K1=K(1:2);%Sistem durumlarının (Vc1, iL1) kazancı.
K2=K(3);%İntegralci durumunun kazancı. (1/s Integrator)
G1=ss(Am-Bm*K1,-Bm*K2,Cm-Dm*K1,-Dm*K2);%G1 sisteminin oluşturulması.
Gi=1/s;%Integrator bloğununun Gi değişkenine tanımlanması.
GclSORU2LQI=feedback(G1*Gi,1);%GclSORU1LQI kapalı çevrim sisteminin oluşturulması.
figure;
step(GclSORU2LQI);%GclSORU1LQI Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
legend('LQI kontrolcü tasarımı başarısız.');
grid;
% figure;
% impulse(GclSORU2LQI);%GclSORU1LQI Kapalı çevrim sisteminin birim dürtü cevabının çizdirilmesi.
% grid;
% n = length(GclSORU2LQI.A); % Durum vektörü sayısı
% initial(GclSORU2LQI,ones(n,1)); % İlk durum cevabını çizdir

%SORU2-g)
%Sistem için durum gözleyicisi tasarlanmaktadır.
L=place(G.A,G.B,[-2 -2.1]);%Durum geri beslemesi kazancı oluşturulması.%u=-Kx için Sistem kazancı L'yi bul.
Gest=estim(G,L',1,1);%estim ile Gest gözleyicisinin oluşturulması.
T=10;%Örnekleme periyodu.
t=linspace(0,4*T,1000);%Zaman ekseni.
u=5*square(2*pi*1/T*t);%Giriş sinyali kare dalga.
x0=[1;1];%x0 başlangıç değeri.
[y,t,x]=lsim(G,u,t,x0);%kare dalga giriş.
xe0=[0;0];%xe0 başlangıç değeri.
[ye,te,xe]=lsim(Gest,[u(:) y(:)],t,xe0);%Gest durumlarının gözlemlenmesi.
figure;
subplot(4,1,1);
plot(t,x,t,xe,'linewidth',2);%Tüm durumlar sistem + gözleyici
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylim([-20 20]);%y ekseni için limit tanımlanması.
grid;
legend('VC1','iL1');%Eğrilerin isimlendirilmesi.
title('Tüm durumlar');%İlgili başlığın grafiğe eklenmesi.
subplot(4,1,2);
plot(t,u,'linewidth',2);%Giriş sinyalinin grafiğe eklenmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
legend('u');%eğrinin isimlendirilmesi.
grid;
Gc=ss(Am-Bm*L,zeros(size(Bm)),Cm-Dm*L,zeros(size(Dm)));%Kapalı çevrim Gc oluşturulması.
n=length(Gc.A);
[y,t,x]=initial(Gc,ones(n,1));%Gc için ilk değer tepkisi.
subplot(4,1,3);
plot(t,x,'linewidth',2);%Durumların ilk değer tepksinin çizdirilmesi.
title('Tüm Durumlar');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('x(t)');%y ekseninin isimlendirilmesi.
legend('VC1','iL1');%eğrinin isimlendirilmesi.
grid;
subplot(4,1,4);
plot(t,-L.*x,'linewidth',2);%u=-L*x'in çizdirilmesi.
legend('u=-K*x');%eğrinin isimlendirilmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('u(t)');%y ekseninin isimlendirilmesi.
grid;

%SORU2-m)
%Kalman filtresi modele ve ölçümlere eşit güvenen filtre.
Q_kalman=1;%Process gürültüsü (modelleme sıkıntıları)
R_kalman=1;%Ölçüm gürültüsü (ölçüm sıkıntıları)
T=10;%Örnekleme periyodu.
t=linspace(0,4*T,1000);%zaman ekseninin oluşturulması.
u=5*square(2*pi*1/T*t);%kare dalga giriş sinyalinin oluşturulması.
x0=[1;1];
[y,t,x]=lsim(G,u,t,x0);%G sisteminin kare dalga tepkisinin bulunması.
sysTum=ss(Am,[Bm Bm],Cm,[Dm Dm]);%Gürültülerin durum uzayı gösterimine eklenmesi için tümleşik sistemin oluşturulması. 
Kest1=kalman(sysTum,Q_kalman,R_kalman);
figure;
lsim(Kest1,[u(:) y(:)],t);%Gürültüsüz kalman filtresi test (Kare dalga giriş) 
a=0.1;%standart sapma=0.1
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%Giriş gültüsünün oluşturulması.
noise_cikis=a.*randn(size(y))+b;%Çıkış gürültüsünün oluşturulması.
u2=u+noise_giris;%gürültülü giriş sinyali
y2=y+noise_cikis;%gürültülü çıkış sinyali
figure;
lsim(Kest1,[u2(:) y2(:)],t);%Gürültülü kalman filtresi test (Kare dalga giriş) 
T=5;%Örnekleme periyodu.
t=linspace(0,5*T,1000);%Zaman ekseninin oluşturulması.
u=sin(2*pi*1/T*t);%sinüs giriş sinyali.
figure;
lsim(Kest1,[u(:) y(:)],t);%Gürültüsüz kalman filtresi test (Sinüs dalga giriş) 
a=0.1;%standart sapma=0.1
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%Gürültü oluşturulması.
noise_cikis=a.*randn(size(y))+b;%Gürültü oluşturulması.
u2=u+noise_giris;%gürültülü çıkış sinyali
y2=y+noise_cikis;%gürültülü giriş sinyali
figure;
lsim(Kest1,[u2(:) y2(:)],t);%Gürültülü kalman filtresi test (Kare dalga giriş) 

%SORU2 Bölüm 2.2
%sisotool(G);
%I-kontrolcü CI=165.95/s ile birim basamak referansının takibi
%denemiştir fakat başarılı sonuç alınamamıştır. I-kontrolcü olmuyor.
%LQG olmuyor.
%Optimization based tuning olmuyor. Birim basamak cevabı 0'a gidiyor.
%Internal model control (IMC) tuning ile C=4.0746*(1+2.1*s)*(1+0.54*s)/(s^2*(1+0.6*s))
%kontrolcü tasarlanmıştır. Birim basamak takibi sağlanmaktadır fakat
%sınırlı giriş parametresinden vazgeçilmelidir.
%I-kontrol ve IMC tuning ile elde edilmiş olan kontrolcünün simülasyonları
%yapılmıştır.
s=tf('s');
C_SORU2_I = 165.95/s;%I kontrolcü.
GclSORU2I = feedback(G*C_SORU2_I,1);%GclSORU2I Kapalı çevrim sisteminin oluşturulması.
figure;
step(GclSORU2I);%GclSORU2I Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
title('I-kontrolcü');%İlgili başlığın grafiğe eklenmesi.
grid;
T=10;%Örnekleme periyodu.
t=linspace(0,4*T,1000);%t zaman vektörünün oluşturulması.
u=5*square(2*pi*1/T*t);%kare dalga giriş sinyali oluşturulması.
% figure;
% lsim(GclSORU2I,u,t);
% title('I-kontrolcü simülasyon');
C_SORU2_IMC=4.0746*(1+2.1*s)*(1+0.54*s)/(s^2*(1+0.6*s));%IMC kontrolcü.
GclSORU2IMC = feedback(G*C_SORU2_IMC,1);%GclSORU2IMC Kapalı çevrim sisteminin oluşturulması.
figure;
step(GclSORU2IMC);%GclSORU2IMC Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
title('IMC tuning ile elde edilen kontrolcü');%İlgili başlığın grafiğe eklenmesi.
grid;
figure;
lsim(GclSORU2IMC,u,t);%GclSORU2IMC kare dalga giriş simülasyon.
title('IMC simülasyon');%İlgili başlığın grafiğe eklenmesi.