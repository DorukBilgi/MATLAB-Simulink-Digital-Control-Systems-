%ELE515 ÖDEV3 Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU1
%SORU1-a)
%Sistemin durum uzayı gösterimi ve transfer fonksiyonu hesaplanmıştır.
%[dVC1/dt;diL1/dt]=[-1/C1*R1 -1/C1;1/L1 -R2/L1]*[VC1;iL1]+[1/C1*R1;0]*V1;
%VR2=[0 R2][VC1;iL1]+[0]V1;
%TF = (R2/L1*R1*C1)/(s^2+s*((L1+R1*R2*C1)/L1*C1*R1)+(R1+R2/L1*R1*C1))
%Sorunun devamında R1 = 2, R2 = 1, C1 = 1, L1 = 2 değerleri kullanılmaktadır. 

%SORU1-b)
R1 = 2;%R1 parametresi.
R2 = 1;%R2 parametresi.
C1 = 1;%C1 parametresi.
L1 = 2;%L1 parametresi.
Am = [-1/(C1*R1) -1/C1;1/L1 -R2/L1];
Bm = [1/(C1*R1);0];
Cm = [0 R2];
Dm = 0;
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

%SORU1-c)
%sisotool(G);%sisotool ile istenilen değerlerde pid kontrolcü 
%tasarlanmıştır ve export edilmiştir. Tasarlanan kontrolcü
%2.9165*(1+1.2*s)*(1+1.3*s)/(s*(1+0.33*s)) şeklindedir.
s=tf('s');
C_SORU1_PID=2.9165*(1+1.2*s)*(1+1.3*s)/(s*(1+0.33*s));%PID kontrolcü.
%pid(C_SORU1_PID);%Tasarlanmış olan kontrolcünün katsayıları komut ekranında gösterilmektedir. D terimi için filtre de kullanılmıştır.
GclSORU1PID = feedback(G*C_SORU1_PID,1);%GclSORU1PID Kapalı çevrim sisteminin oluşturulması.
figure;
step(GclSORU1PID);%GclSORU1PID Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
legend('GclSORU1PID (PID kontrolcü (c))');%Eğrinin isimlendirilmesi.
grid;
% figure;
% impulse(GclSORU1PID);%GclSORU1LQI Kapalı çevrim sisteminin birim dürtü cevabının çizdirilmesi.
% grid;
% n = length(GclSORU1PID.A); % Durum vektörü sayısı
% initial(GclSORU1PID,ones(n,1)); % İlk durum cevabını çizdir

%SORU1-d)
%LQI kontrolcü ile c) şıkkının tekrarlanması.
%doc lqi blok diyagram incelenmiştir.
Q=10*eye(3);%Regülasyonun hızlanması için "Q" arttırılmalı.(2 sistem durumu + 1 integralci durumu)
R=1;%Az enerji harcanması için "R" arttırılmalı.  
K=lqi(G,Q,R);%Kazanç matrisinin oluşturulması.
K1=K(1:2);%Sistem durumlarının (Vc1, iL1) kazancı.
K2=K(3);%İntegralci durumunun kazancı. (1/s Integrator)
G1=ss(Am-Bm*K1,-Bm*K2,Cm-Dm*K1,-Dm*K2);%G1 sisteminin oluşturulması.
Gi=1/s;%Integrator bloğununun Gi değişkenine tanımlanması.
GclSORU1LQI=feedback(G1*Gi,1);%GclSORU1LQI kapalı çevrim sisteminin oluşturulması.
figure;
step(GclSORU1LQI);%GclSORU1LQI Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
legend('GclSORU1LQI (LQI kontrolcü (d))');%Eğrinin isimlendirilmesi
grid;
% figure;
% impulse(GclSORU1LQI);%GclSORU1LQI Kapalı çevrim sisteminin birim dürtü cevabının çizdirilmesi.
% grid;
% n = length(GclSORU1LQI.A); % Durum vektörü sayısı
% initial(GclSORU1LQI,ones(n,1)); % İlk durum cevabını çizdir

%SORU1-e)
%Sistemin girişine ve çıkışına gürültü karıştığı durumu gözlemlemek için
%kare dalga sinyali oluşturulmuştur.
T=5;%Örnekleme periyodu.
t=linspace(0,5*T,1000);%Zaman ekseninin oluşturulması.
u=square(2*pi*1/T*t);%Kare dalga sinyalinin oluşturulması.
y=lsim(G,u,t);%G sisteminin kare dalga girişe olan tepksi.
figure;
plot(t,u,t,y,'linewidth',2);%Giriş-Çıkış sinyallerininin çizdirilmesi.
legend('Giriş','Çıkış');%Sinyallerin isimlendirilmesi.
xlabel('t(s)');%Zaman ekseninin isimlendirilmesi
title('Kare dalga giriş ve Kare dalga tepkisi çıkış (Sistem G)');%İlgili başlığın grafiğe eklenmesi.
sysTum=ss(Am,[Bm Bm],Cm,[Dm Dm]);%Gürültülerin durum uzayı gösterimine eklenmesi için tümleşik sistemin oluşturulması. 
figure;
lsim(sysTum,[u(:) y(:)],t);%Tümleşik sistemin gürültüsüz sinyallere tepkisi.
title('Kare dalga giriş ve Kare dalga tepkisi çıkış (Sistem sysTum)');%İlgili başlığın grafiğe eklenmesi.
a=0.1;%standart sapma=0.1
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%giriş için gürültü
noise_cikis=a.*randn(size(y))+b;%çıkış için gürültü
%mean() ve std() komutları ile sinyallerin ortalama ve standart sapma
%değerleri kontrol edilmektedir.
u2=u+noise_giris;%gürültülü giriş sinyali
y2=y+noise_cikis;%gürültülü çıkış sinyali
figure;
lsim(sysTum,[u2(:) y2(:)],t);%Tümleşik sistemin gürültülü sinyallere tepkisi.
title('Gültülü Kare dalga giriş ve Gürültülü Kare dalga tepkisi çıkış (Sistem sysTum)');%İlgili başlığın grafiğe eklenmesi.
%Tasarlanmış olan PID kontrolcü ile sistemin gürültülere karşı tepkisi analiz edilmektedir.(C_SORU1_PID)
% figure;
% lsim(feedback(sysTum*C_SORU1_PID,1,1,1),[u(:) y(:)],t);%PID kontrolcü ile tümleşik sistemin kapalı çevrim sisteminin gürültüsüz sinyallere tepkisi.
% title('PID kontrolcü gürültüsüz giriş-çıkış (Sistem sysTum)');%İlgili başlığın grafiğe eklenmesi.
figure;
lsim(feedback(sysTum*C_SORU1_PID,1,1,1),[u2(:) y2(:)],t);%PID kontrolcü ile tümleşik sistemin kapalı çevrim sisteminin gürültülü sinyallere tepkisi.
title('PID kontrolcü gürültülü giriş-çıkış (Sistem sysTum)');%İlgili başlığın grafiğe eklenmesi.
%Tasarlanmış olan LQI kontrolcü ile sistemin gürültülere karşı tepkisi analiz edilmektedir.(C_SORU1_PID)
sysTum_1 = ss(Am-[Bm Bm].*K1,-[Bm Bm].*K2,Cm-[Dm Dm].*K1,-[Dm Dm].*K2);
% figure;
% lsim(feedback(sysTum_1*Gi,1,1,1),[u(:) y(:)],t);%LQI kontrolcü ile tümleşik sistemin kapalı çevrim sisteminin gürültüsüz sinyallere tepkisi.
% title('LQI kontrolcü gürültüsüz giriş-çıkış (Sistem sysTum1)');%İlgili başlığın grafiğe eklenmesi.
figure;
lsim(feedback(sysTum_1*Gi,1,1,1),[u2(:) y2(:)],t);%LQI kontrolcü ile tümleşik sistemin kapalı çevrim sisteminin gürültülü sinyallere tepkisi.
title('LQI kontrolcü gürültülü giriş-çıkış (Sistem sysTum1)');%İlgili başlığın grafiğe eklenmesi.

%SORU1-f)
%Farklı ortalama ve standart sapma değerleri için simülasyonlar
%tekrarlanmaktadır.
a=0.1;%standart sapma=0.1
b=1;%ortalama=1
noise_giris=a.*randn(size(u))+b;%giriş için gürültü
noise_cikis=a.*randn(size(y))+b;%çıkış için gürültü
u2=u+noise_giris;%gürültülü giriş sinyali
y2=y+noise_cikis;%gürültülü çıkış sinyali
figure;
lsim(feedback(sysTum*C_SORU1_PID,1,1,1),[u2(:) y2(:)],t);%PID test
title('PID kontrolcü gürültülü giriş-çıkış (a=0.1 b=1)');%İlgili başlığın grafiğe eklenmesi.
figure;
lsim(feedback(sysTum_1*Gi,1,1,1),[u2(:) y2(:)],t);%LQI test
title('LQI kontrolcü gürültülü giriş-çıkış (a=0.1 b=1)');%İlgili başlığın grafiğe eklenmesi.

a=0.5;%standart sapma=0.5
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%giriş için gürültü
noise_cikis=a.*randn(size(y))+b;%çıkış için gürültü
u2=u+noise_giris;%gürültülü giriş sinyali
y2=y+noise_cikis;%gürültülü çıkış sinyali
figure;
lsim(feedback(sysTum*C_SORU1_PID,1,1,1),[u2(:) y2(:)],t);%PID test
title('PID kontrolcü gürültülü giriş-çıkış (a=0.5 b=0)');%İlgili başlığın grafiğe eklenmesi.
figure;
lsim(feedback(sysTum_1*Gi,1,1,1),[u2(:) y2(:)],t);%LQI test
title('LQI kontrolcü gürültülü giriş-çıkış (a=0.5 b=0)');%İlgili başlığın grafiğe eklenmesi.

a=5;%standart sapma=5
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%giriş için gürültü
noise_cikis=a.*randn(size(y))+b;%çıkış için gürültü
u2=u+noise_giris;%gürültülü giriş sinyali
y2=y+noise_cikis;%gürültülü çıkış sinyali
figure;
lsim(feedback(sysTum*C_SORU1_PID,1,1,1),[u2(:) y2(:)],t);%PID test
title('PID kontrolcü gürültülü giriş-çıkış (a=5 b=0)');%İlgili başlığın grafiğe eklenmesi.
figure;
lsim(feedback(sysTum_1*Gi,1,1,1),[u2(:) y2(:)],t);%LQI test
title('LQI kontrolcü gürültülü giriş-çıkış (a=5 b=0)');%İlgili başlığın grafiğe eklenmesi.

%SORU1-g)
%Sistem için durum gözleyicisi tasarlanmaktadır.
L=place(G.A,G.B,[-2 -2.1]);%Durum geri beslemesi kazancı oluşturulması.%u=-Kx için Sistem kazancı L'yi bul.
Gest=estim(G,L',1,1);%Gözleyici tahmini yapılması.
T=10;%örnekleme periyodu.
t=linspace(0,4*T,1000);%t zaman vektörü.
u=5*square(2*pi*1/T*t);%u kare dalga giriş sinyali
x0=[1;1];%G sistemi için ilk değer.
[y,t,x]=lsim(G,u,t,x0);%Kare dalga giriş için G için sistem durumlarının bulunması.
xe0=[0;0];%Gest sistemi için ilk değer.
[ye,te,xe]=lsim(Gest,[u(:) y(:)],t,xe0);%Kare dalga giriş için Gest için sistem durumlarının bulunması.
figure;
subplot(4,1,1);
plot(t,x,t,xe,'linewidth',2);%G ve Ge için durumların çizdirilmesi.
legend('Vc1','iL1');%sinyallerin isimlendirilmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
grid;
title('Tüm durumlar');%İlgili başlığın grafiğe eklenmesi.
subplot(4,1,2);
plot(t,u,'linewidth',2);%Kare dalga girişin çizidirilmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
legend('u');%Sinyalin isimlendirilmesi.
grid;
Gc=ss(Am-Bm*L,zeros(size(Bm)),Cm-Dm*L,zeros(size(Dm)));%Gc kapalı çevrim sistemi oluşturulması.
n=length(Gc.A);%Durum sayısı
[y,t,x]=initial(Gc,ones(n,1));%İlk değer cevabının hesaplanması. (Durumlar x)
subplot(4,1,3);
plot(t,x,'linewidth',2);%Tüm durumların (x) çizdirilmesi.
title('Tüm Durumlar');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('x(t)');%y ekseninin isimlendirilmesi.
legend('VC1','iL1');%Eğrinin isimlendirilmesi.
grid;
subplot(4,1,4);
plot(t,-L.*x,'linewidth',2);%u=-K*x çizdirilmesi.
legend('u=-K*x');%Eğrinin isimlendirilmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('u(t)');%y ekseninin isimlendirilmesi.
grid;
%Beklendiği gibi sistem cevabı sıfıra gitmektedir.
%t=3sn'de sistemin durumları oturmaktadır.

%SORU1-h)
%C şıkkında tasarlanmış olan PID kontrolcü (C_SORU1_PID=2.9165*(1+1.2*s)*(1+1.3*s)/(s*(1+0.33*s));)
%ile tasarlanmış olan kapalı çevrim sistemi GclSORU1PID ele alınmıştır.
%Gözleyici tabanlı durum geribeslemesi regülasyonu yapılmıştır. Gc
%oluşturulmuştur ve PID kontrolcünün istenilen şekilde çalıştığı
%gözlemlenmiştir.
GclSORU1PID.u='u';%KÇTF giriş.
GclSORU1PID.y='y';%KÇTF çıkış.
Gest.u = {'u','y'};%Gözleyici giriş.
Gest.y = {'ye','x1e','x2e'};%Gözleyici çıkış.
sysK = ss(-L);%kazanç bloğunun durum uzayı gösterimi.
sysK.u = {'x1e','x2e'};%Kazanç bloğu için giriş çıkış. (Sistem durumları)
sysK.y='SysKy';%kazanç bloğunun çıkışı.
sysSum=sumblk('u=z+sysKy');%Toplam bloğu oluşturulması.
Gc_PID=connect(GclSORU1PID,Gest,sysK,sysSum,'z',{'y','u'});%Gc_PID sisteminin oluşturulması.
x0=[1;1;1;1];%Gc_PID için ilk değerler.
[yu,t,x]=initial(Gc_PID,x0);%response to initial conditions.
figure;
subplot(2,1,1)
plot(t,x,'linewidth',2);%Sistem durumlarının çizdirilmesi.
grid;
title('Tüm Durumların ilk değer cevabı (PID Kontrolcü + Gözleyici)');
xlabel('t(s)');
ylabel('Amplitude');
subplot(2,1,2);
u=yu(:,1);%Çıkışa verilen voltajın tutulması.
plot(t,u,'linewidth',2);%Çıkışa verilen voltajın çizdirilmesi.
title('Çıkışa verilen voltajın ilk değer cevabı');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
grid;
figure;
step(Gc_PID);%Kontrolcü istenilen şekilde çalışmaktadır.
grid;
figure;
pzmap(Gc_PID);%Gc sistemi kararlıdır. Kutuplar sanal eksenin solundadır. Kullanılan kmontrolcünün ve gözleyicinin sağlaması yapılmıştır.
grid;

%SORU1-i)
%d şıkkında tasarlanmış olan LQI kontrolcü ile oluşturulmuş olan kapalı
%çevrim sistemi GclSORU1LQI'dir. Gözleyici tabanlı durum geribeslemesi regülasyonu yapılmıştır.
%Gc oluşturulmuştur ve LQI kontrolcünün istenilen şekilde çalıştığı gözlemlenmiştir
GclSORU1LQI.u='u';%KÇTF giriş.
GclSORU1LQI.y='y';%KÇTF çıkış.
Gest.u = {'u','y'};%Gözleyici giriş.
Gest.y = {'ye','x1e','x2e'};%%Gözleyici çıkış.
sysK = ss(-L);%kazanç bloğunun durum uzayı gösterimi.
sysK.u = {'x1e','x2e'};%Kazanç bloğu için giriş çıkış. (Sistem durumları)
sysK.y='SysKy';%kazanç bloğunun çıkışı.
sysSum=sumblk('u=z+sysKy');%Toplam bloğu oluşturulması.
Gc_LQI=connect(GclSORU1LQI,Gest,sysK,sysSum,'z',{'y','u'});%Gc sisteminin oluşturulması.
x0=[1;1;1];%Gc_LQI için ilk değerler.
[yu,t,x]=initial(Gc_LQI,x0);%response to initial conditions.
figure;
subplot(2,1,1)
plot(t,x,'linewidth',2);%Durumların ilk tepksini çizdir.
grid;
title('Tüm Durumların ilk değer cevabı (LQI Kontrolcü + Gözleyici)');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
subplot(2,1,2);
u1=yu(:,1);%Çıkışı verilen voltajın tutulması.
plot(t,u1,'linewidth',2);
title('Çıkışa verilen voltajın ilk değer cevabı');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
grid;
figure;
step(Gc_LQI);%Kontrolcü istenilen şekilde çalışmaktadır.
grid;
figure;
pzmap(Gc_LQI);%Gc_LQI sistemi kararlıdır. Kutuplar sanal eksenin solundadır. Kullanılan kmontrolcünün sağlaması yapılmıştır.
grid;

%SORU1-k)
%Sistemin girişine ve çıkışına ortalaması 0 ve standart sapması 0.05 olan
%gürültü karıştığı durum için h ve i şıkkında yapılan işlemler
%tekrarlanmıştır.
T=5;%Örnekleme periyodu.
t=linspace(0,5*T,1000);%Zaman ekseninin oluşturulması.
u=square(2*pi*1/T*t);%Kare dalga sinyalinin oluşturulması.
y=lsim(G,u,t);%G sisteminin kare dalga girişe olan tepksi y değerine kaydedilmektedir.
a=0.05;%standart sapma=0.05
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%gürültülü giriş sinyali
noise_cikis=a.*randn(size(y))+b;%gürültülü çıkış sinyali
u2=u+noise_giris;%Gürültülü giriş.
y2=y+noise_cikis;%Gürültülü çıkış.
clPID=feedback(sysTum*Gc_PID,1);%clPID üst sistem.
figure;%PID
lsim(clPID,u2,t);%clPID kare dalga simülasyon.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clPID std=0.05');%İlgili başlığın grafiğe eklenmesi.
clLQI=feedback(sysTum_1*Gc_LQI,1);%clLQI alt sistem.
figure;%LQI
lsim(clLQI,u2,t);%clLQI kare dalga simülasyon.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clLQI std=0.05');%İlgili başlığın grafiğe eklenmesi.

%SORU1-l)
a=0.5;%standart sapma=0.5
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%Gürültünün oluşturulması.
noise_cikis=a.*randn(size(y))+b;%Gürültünün oluşturulması.
u2=u+noise_giris;%gürültülü giriş sinyali
y2=y+noise_cikis;%gürültülü çıkış sinyali
clPID=feedback(sysTum*Gc_PID,1);%clPID kapalı çevrim sisteminin elde edilmesi.
figure;
lsim(clPID,u2,t);%gürültülü PID simülasyon.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clPID std=0.5');
clLQI=feedback(sysTum_1*Gc_LQI,1);%clLQI kapalı çevrim sisteminin elde edilmesi.
figure;%LQI simülasyon
lsim(clLQI,u2,t);
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clLQI std=0.5');
a=5;%standart sapma=5
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%Gürültünün oluşturulması.
noise_cikis=a.*randn(size(y))+b;%Gürültünün oluşturulması.
u2=u+noise_giris;%gürültülü giriş sinyali
y2=y+noise_cikis;%gürültülü çıkış sinyali
clPID=feedback(sysTum*Gc_PID,1);%clPID kapalı çevrim oluşturulması.
figure;
lsim(clPID,u2,t);%gürültülü PID simülasyon.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clPID std=5');
clLQI=feedback(sysTum_1*Gc_LQI,1);
figure;
lsim(clLQI,u2,t);
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clLQI std=5');

%SORU1-m)
%Kalman filtresi modele ve ölçümlere eşit güvenen filtre.
Q_kalman=10;%Process gürültüsü (modelleme sıkıntıları)
R_kalman=10;%Ölçüm gürültüsü (ölçüm sıkıntıları)
Kest1=kalman(sysTum,Q_kalman,R_kalman);%Kalman Filtresi.
figure;
lsim(Kest1,[u(:) y(:)],t);%Gürültüsüz kalman filtresi test (Kare dalga giriş) 
a=0.1;%standart sapma=0.1
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%gürültülü giriş sinyali
noise_cikis=a.*randn(size(y))+b;%gürültülü çıkış sinyali
u2=u+noise_giris;
y2=y+noise_cikis;
figure;
lsim(Kest1,[u2(:) y2(:)],t);%Gürültülü kalman filtresi test (Kare dalga giriş) 
T=5;%Örnekleme periyodu.
t=linspace(0,5*T,1000);%Zaman ekseninin oluşturulması.
u=sin(2*pi*1/T*t);
figure;
lsim(Kest1,[u(:) y(:)],t);%Gürültüsüz kalman filtresi test (Sinüs dalga giriş) 
a=0.1;%standart sapma=0.1
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%gürültülü giriş sinyali
noise_cikis=a.*randn(size(y))+b;%gürültülü çıkış sinyali
u2=u+noise_giris;
y2=y+noise_cikis;
figure;
lsim(Kest1,[u2(:) y2(:)],t);%Gürültülü kalman filtresi test (Kare dalga giriş) 

%SORU1-n)
%C şıkkında tasarlanmış olan PID kontrolcü (C_SORU1_PID=2.9165*(1+1.2*s)*(1+1.3*s)/(s*(1+0.33*s));)
%ile tasarlanmış olan kapalı çevrim sistemi GclSORU1PID ele alınmıştır.
%Kalaman filtresi gözleyici tabanlı durum geribeslemesi regülasyonu yapılmıştır. Gc
%oluşturulmuştur ve PID kontrolcünün istenilen şekilde çalıştığı
%gözlemlenmiştir.
GclSORU1PID.u='u';
GclSORU1PID.y='y';
Kest1.u = {'u','y'};%Kalman Gözleyici giriş.
Kest1.y = {'ye','x1e','x2e'};%Kalman Gözleyici çıkış.
sysK = ss(-L);
sysK.u = {'x1e','x2e'};
sysK.y='SysKy';
sysSum=sumblk('u=z+sysKy');%sumblk komutu ile blokların toplanması.
Gc_PID_kalman=connect(GclSORU1PID,Kest1,sysK,sysSum,'z',{'y','u'});%Gc_PID_kalman sisteminin oluşturulması.
x0=[1;1;1;1];
[yu,t,x]=initial(Gc_PID_kalman,x0);%response to initial conditions.
figure;
subplot(2,1,1)
plot(t,x,'linewidth',2);%Durumların ilk değer tepksinin çizdirilmesi.
grid;
title('Tüm Durumlar (PID Kontrolcü + Kalman)');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
subplot(2,1,2);
u=yu(:,1);
plot(t,u,'linewidth',2);%Çıkış voltajının çizdirilmesi.
title('Çıkışa verilen voltajın ilk değer cevabı');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
grid;
figure;
step(Gc_PID_kalman);%Kontrolcü istenilen şekilde çalışmaktadır.
grid;
figure;
pzmap(Gc_PID_kalman);%Gc_PID_kalman sistemi kararlıdır. Kutuplar sanal eksenin solundadır. Kullanılan kmontrolcünün sağlaması yapılmıştır.
grid;

%SORU1-o)
%d şıkkında tasarlanmış olan LQI kontrolcü ile oluşturulmuş olan kapalı
%çevrim sistemi GclSORU1LQI'dir. Kalman filtresi gözleyici tabanlı durum geribeslemesi regülasyonu yapılmıştır.
%Gc oluşturulmuştur ve LQI kontrolcünün istenilen şekilde çalıştığı gözlemlenmiştir
GclSORU1LQI.u='u';%KÇTF giriş.
GclSORU1LQI.y='y';%KÇTF çıkış.
Kest1.u = {'u','y'};%Gözleyici giriş.
Kest1.y = {'ye','x1e','x2e'};%%Gözleyici çıkış.
sysK = ss(-L);%L kazanç için durum uzayı gösterimi elde edilmesi.
sysK.u = {'x1e','x2e'};
sysK.y='SysKy';
sysSum=sumblk('u=z+sysKy');%sumblk komutu ile blokların toplanması.
Gc_LQI_kalman=connect(GclSORU1LQI,Kest1,sysK,sysSum,'z',{'y','u'});%Gc sisteminin oluşturulması.
x0=[1;1;1];
[yu,t,x]=initial(Gc_LQI_kalman,x0);%response to initial conditions.
figure;
subplot(2,1,1)
plot(t,x,'linewidth',2);%Durumların ilk değer tepkisnin çizdirilmesi.
grid;
title('Tüm Durumlar (LQI Kontrolcü + Kalman)');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekesninin isimlendirilmesi.
ylabel('Amplitude');%y ekesninin isimlendirilmesi.
subplot(2,1,2);
u1=yu(:,1);%Çıkış voltajının çizdirilmesi.
plot(t,u1,'linewidth',2);
title('Çıkışa verilen voltaj');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekesninin isimlendirilmesi.
ylabel('Amplitude');%y ekesninin isimlendirilmesi.
grid;
figure;
step(Gc_LQI_kalman);%Kontrolcü istenilen şekilde çalışmaktadır.
grid;
figure;
pzmap(Gc_LQI_kalman);%Gc_LQI_kalman sistemi kararlıdır. Kutuplar sanal eksenin solundadır. Kullanılan kmontrolcünün sağlaması yapılmıştır.
grid;

%SORU1-q)
%Sistemin girişine ve çıkışına ortalaması 0 ve standart sapması 0.05 olan
%gürültü karıştığı durum için n ve o şıkkında tasarlanmış kontrolcüler test
%edilmektedir.
T=5;%Örnekleme periyodu.
t=linspace(0,5*T,1000);%Zaman ekseninin oluşturulması.
u=square(2*pi*1/T*t);%Kare dalga sinyalinin oluşturulması.
y=lsim(G,u,t);%G sisteminin kare dalga girişe olan tepksi y değerine kaydedilmektedir.
a=0.05;%standart sapma=0.05
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%Gürültü oluşturulması.
noise_cikis=a.*randn(size(y))+b;%Gürültü oluşturulması.
u2=u+noise_giris;%gürültülü çıkış sinyali
y2=y+noise_cikis;%gürültülü giriş sinyali
clPID_kalman=feedback(sysTum*Gc_PID_kalman,1);%clPID_kalman kapalı çevrim elde edilmesi.
figure;
lsim(clPID_kalman,u2,t);%gürültü altında clPID_kalman simülasyonu.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clPID kalman std=0.05');%İlgili başlığın grafiğe eklenmesi.
clLQI_kalman=feedback(sysTum_1*Gc_LQI_kalman,1);%clLQI_kalman kapalı çevrim sisteminin oluşturulması.
figure;
lsim(clLQI_kalman,u2,t);%gürültülü clLQI_kalman simülasyonu.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clLQI kalman std=0.05');

%SORU1-r)
a=0.5;%standart sapma=0.5
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%gürültülü giriş sinyali
noise_cikis=a.*randn(size(y))+b;%gürültülü çıkış sinyali
u2=u+noise_giris;
y2=y+noise_cikis;
clPID_kalman=feedback(sysTum*Gc_PID_kalman,1);%clPID_kalman kapalı çevriminin oluşturulması.
figure;%PID
lsim(clPID_kalman,u2,t);%gürültü altında clPID_kalman simülasyonu.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clPID kalman std=0.5');
clLQI_kalman=feedback(sysTum_1*Gc_LQI_kalman,1);%clLQI_kalman kapalı çevriminin oluşturulması.
figure;%LQI
lsim(clLQI_kalman,u2,t);%gürültü altında clLQI_kalman simülasyonu.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clLQI kalman std=0.5');
a=5;%standart sapma=5
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;
noise_cikis=a.*randn(size(y))+b;
u2=u+noise_giris;%gürültülü giriş sinyali
y2=y+noise_cikis;%gürültülü çıkış sinyali
clPID_kalman=feedback(sysTum*Gc_PID_kalman,1);%clPID_kalman kapalı çevriminin oluşturulması.
figure;
lsim(clPID_kalman,u2,t);%gürültü altında clPID_kalman simülasyonu.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clPID kalman std=5');%İlgili başlığın grafiğe eklenmesi.
clLQI_kalman=feedback(sysTum_1*Gc_LQI_kalman,1);%clLQI_kalman kapalı çevriminin oluşturulması.
figure;
lsim(clLQI_kalman,u2,t);%gürültü altında clLQI_kalman simülasyonu.
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('clLQI kalman std=5');%İlgili başlığın grafiğe eklenmesi.

%SORU1-s)
%Farklı gürültü örneklerinde LQI ve Kalman için farklı Q ve R değerleri kullanılmıştır. 
%Gürültü Örnek - 1-1
a=1;%standart sapma=0.2
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;
noise_cikis=a.*randn(size(y))+b;
u2=u+noise_giris;%gürültülü giriş sinyali
y2=y+noise_cikis;%gürültülü çıkış sinyali
%LQI Kontrolcü Tasarım 1-1
Q=1000*eye(3);%Regülasyonun hızlanması için "Q" arttırılmalı.(2 sistem durumu + 1 integralci durumu)
R=1000;%Az enerji harcanması için "R" arttırılmalı.  
K=lqi(G,Q,R);%Kazanç matrisinin oluşturulması.
K1=K(1:2);%Sistem durumlarının (Vc1, iL1) kazancı.
K2=K(3);%İntegralci durumunun kazancı. (1/s Integrator)
G1=ss(Am-Bm*K1,-Bm*K2,Cm-Dm*K1,-Dm*K2);%G1 sisteminin oluşturulması.
Gi=1/s;%Integrator bloğununun Gi değişkenine tanımlanması.
GclSORU1LQI=feedback(G1*Gi,1);%GclSORU1LQI kapalı çevrim sisteminin oluşturulması.
%Kalman Filtresi Tasarım 1-1
Q_kalman=1;%Process gürültüsü (modelleme sıkıntıları)
R_kalman=1;%Ölçüm gürültüsü (ölçüm sıkıntıları)
Kest1=kalman(sysTum,Q_kalman,R_kalman);
GclSORU1LQI.u='u';%KÇTF giriş.
GclSORU1LQI.y='y';%KÇTF çıkış.
Kest1.u = {'u','y'};%Gözleyici giriş.
Kest1.y = {'ye','x1e','x2e'};%%Gözleyici çıkış.
sysK = ss(-L);
sysK.u = {'x1e','x2e'};
sysK.y='SysKy';
sysSum=sumblk('u=z+sysKy');
Gc_LQI_kalman=connect(GclSORU1LQI,Kest1,sysK,sysSum,'z',{'y','u'});%Gc sisteminin oluşturulması.
clLQI_kalman=feedback(sysTum_1*Gc_LQI_kalman,1);
figure;
lsim(clLQI_kalman,u2,t);
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('1-1) std=1 Q=1000 R=1000 Qkalman=1 Rkalman=1');
%Gürültü Örnek - 1-2
a=1;%standart sapma=0.2
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%gürültülü giriş sinyali
noise_cikis=a.*randn(size(y))+b;%gürültülü çıkış sinyali
u2=u+noise_giris;
y2=y+noise_cikis;
%LQI Kontrolcü Tasarım 1-2
Q=eye(3);%Regülasyonun hızlanması için "Q" arttırılmalı.(2 sistem durumu + 1 integralci durumu)
R=1;%Az enerji harcanması için "R" arttırılmalı.  
K=lqi(G,Q,R);%Kazanç matrisinin oluşturulması.
K1=K(1:2);%Sistem durumlarının (Vc1, iL1) kazancı.
K2=K(3);%İntegralci durumunun kazancı. (1/s Integrator)
G1=ss(Am-Bm*K1,-Bm*K2,Cm-Dm*K1,-Dm*K2);%G1 sisteminin oluşturulması.
Gi=1/s;%Integrator bloğununun Gi değişkenine tanımlanması.
GclSORU1LQI=feedback(G1*Gi,1);%GclSORU1LQI kapalı çevrim sisteminin oluşturulması.
%Kalman Filtresi Tasarım 1-2
Q_kalman=1000;%Process gürültüsü (modelleme sıkıntıları)
R_kalman=1000;%Ölçüm gürültüsü (ölçüm sıkıntıları)
Kest1=kalman(sysTum,Q_kalman,R_kalman);
GclSORU1LQI.u='u';%KÇTF giriş.
GclSORU1LQI.y='y';%KÇTF çıkış.
Kest1.u = {'u','y'};%Gözleyici giriş.
Kest1.y = {'ye','x1e','x2e'};%%Gözleyici çıkış.
sysK = ss(-L);
sysK.u = {'x1e','x2e'};
sysK.y='SysKy';
sysSum=sumblk('u=z+sysKy');
Gc_LQI_kalman=connect(GclSORU1LQI,Kest1,sysK,sysSum,'z',{'y','u'});%Gc sisteminin oluşturulması.
clLQI_kalman=feedback(sysTum_1*Gc_LQI_kalman,1);
figure;
lsim(clLQI_kalman,u2,t);
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('1-2) std=1 Q=1 R=1 Qkalman=1000 Rkalman=1000');

%Gürültü Örnek - 2.1
a=0.1;%standart sapma=0.1
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%gürültülü giriş sinyali
noise_cikis=a.*randn(size(y))+b;%gürültülü çıkış sinyali
u2=u+noise_giris;
y2=y+noise_cikis;
%LQI Kontrolcü Tasarım 2-1
Q=1000*eye(3);%Regülasyonun hızlanması için "Q" arttırılmalı.(2 sistem durumu + 1 integralci durumu)
R=1;%Az enerji harcanması için "R" arttırılmalı.  
K=lqi(G,Q,R);%Kazanç matrisinin oluşturulması.
K1=K(1:2);%Sistem durumlarının (Vc1, iL1) kazancı.
K2=K(3);%İntegralci durumunun kazancı. (1/s Integrator)
G1=ss(Am-Bm*K1,-Bm*K2,Cm-Dm*K1,-Dm*K2);%G1 sisteminin oluşturulması.
Gi=1/s;%Integrator bloğununun Gi değişkenine tanımlanması.
GclSORU1LQI=feedback(G1*Gi,1);%GclSORU1LQI kapalı çevrim sisteminin oluşturulması.
%Kalman Filtresi Tasarım 2-1 
Q_kalman=1;%Process gürültüsü (modelleme sıkıntıları)
R_kalman=1000;%Ölçüm gürültüsü (ölçüm sıkıntıları)
Kest1=kalman(sysTum,Q_kalman,R_kalman);
GclSORU1LQI.u='u';%KÇTF giriş.
GclSORU1LQI.y='y';%KÇTF çıkış.
Kest1.u = {'u','y'};%Gözleyici giriş.
Kest1.y = {'ye','x1e','x2e'};%%Gözleyici çıkış.
sysK = ss(-L);
sysK.u = {'x1e','x2e'};
sysK.y='SysKy';
sysSum=sumblk('u=z+sysKy');
Gc_LQI_kalman=connect(GclSORU1LQI,Kest1,sysK,sysSum,'z',{'y','u'});%Gc_LQI_kalman sisteminin oluşturulması.
clLQI_kalman=feedback(sysTum_1*Gc_LQI_kalman,1);
figure;
lsim(clLQI_kalman,u2,t);
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('2-1) std=0.1 Q=1000 R=1 Qkalman=1 Rkalman=1000');
%Gürültü Örnek - 2.2
a=0.1;%standart sapma=0.1
b=0;%ortalama=0
noise_giris=a.*randn(size(u))+b;%gürültülü giriş sinyali
noise_cikis=a.*randn(size(y))+b;%gürültülü çıkış sinyali
u2=u+noise_giris;
y2=y+noise_cikis;
%LQI Kontrolcü Tasarım 2-2
Q=1*eye(3);%Regülasyonun hızlanması için "Q" arttırılmalı.(2 sistem durumu + 1 integralci durumu)
R=1000;%Az enerji harcanması için "R" arttırılmalı.  
K=lqi(G,Q,R);%Kazanç matrisinin oluşturulması.
K1=K(1:2);%Sistem durumlarının (Vc1, iL1) kazancı.
K2=K(3);%İntegralci durumunun kazancı. (1/s Integrator)
G1=ss(Am-Bm*K1,-Bm*K2,Cm-Dm*K1,-Dm*K2);%G1 sisteminin oluşturulması.
Gi=1/s;%Integrator bloğununun Gi değişkenine tanımlanması.
GclSORU1LQI=feedback(G1*Gi,1);%GclSORU1LQI kapalı çevrim sisteminin oluşturulması.
%Kalman Filtresi Tasarım 2-2 
Q_kalman=1000;%Process gürültüsü (modelleme sıkıntıları)
R_kalman=1;%Ölçüm gürültüsü (ölçüm sıkıntıları)
Kest1=kalman(sysTum,Q_kalman,R_kalman);
GclSORU1LQI.u='u';%KÇTF giriş.
GclSORU1LQI.y='y';%KÇTF çıkış.
Kest1.u = {'u','y'};%Gözleyici giriş.
Kest1.y = {'ye','x1e','x2e'};%%Gözleyici çıkış.
sysK = ss(-L);
sysK.u = {'x1e','x2e'};
sysK.y='SysKy';
sysSum=sumblk('u=z+sysKy');
Gc_LQI_kalman=connect(GclSORU1LQI,Kest1,sysK,sysSum,'z',{'y','u'});%Gc_LQI_kalman sisteminin oluşturulması.
clLQI_kalman=feedback(sysTum_1*Gc_LQI_kalman,1);
figure;
lsim(clLQI_kalman,u2,t);
hold on;
plot(t,y2,'Color', [.7 .7 .7]);
title('2-2) std=0.1 Q=1 R=1000 Qkalman=1000 Rkalman=1');
