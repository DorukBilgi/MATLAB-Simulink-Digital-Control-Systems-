%ELE515 ÖDEV3 Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU3
%SORU3 Bölüm 3.1
%dx1/dt=x1^3+x2; -> f1
%dx2/dt=x2+u; -> f2
%Sistemi ele alınmaktadır.
%x(t) = x0 + delta(x(t)) => x(t) = delta(x(t)); => delta = 1; (x0 = 0)
%u(t) = u0 + delta(u(t)) => x(t) = delta(u(t)); => delta = 1; (u0 = 0)
%Orijin bu sistem için doğal denge noktasıdır.
syms x1 x2 u real %x1,x2,u
%Doğrusal olmayan sistem modeli bileşenleri
f=[x1^3+x2;x2+u];
h=0;%y=h(x,u) fakat y=0 sistem dolayısıyla h=0.
%(x0,u0)=(0,0) orijin noktası etrafında.
x10=0;%1. Durum ilk değer = 0
x20=0;%2. Durum ilk değer = 0
x0=[x10;x20];%x0 durum vektörü.
u0=0;%Giriş ilk değer 0.
subs(f,[x1 x2 u],[x10 x20 u0]);
%Orijin denge noktası etrafında doğrusallaştırma.
x=[x1;x2];%Durum değişkenleri
As=jacobian(f,x);%As bulunması.
Bs=jacobian(f,u);%Bs bulunması.
Cs=jacobian(h,x);%Cs bulunması.
Ds=jacobian(h,u);%Ds bulunması.
vars=[x1 x2 u];%variables
vals=[x10 x20 u0];%values
%Doğrusallaştırılmış sistemin A,B,C,D matrisleri.
A=double(subs(As,vars,vals));
B=double(subs(Bs,vars,vals));
C=double(subs(Cs,vars,vals));
D=double(subs(Ds,vars,vals));
G=ss(A,B,C,D);%Doğrusallaştırılmış sistem G.
G.StateName={'deltax1','deltax2'};
G.InputName='deltau';
G.OutputName='deltay';
%Doğrusallaştırılmış sistem üzerinde LQR kontrol tasarımı.
Q=diag([1 1]);%Q=I
R=1;%R=1
K=lqr(G,Q,R);%lqr ile K kazancının bulunması.
Gcl=ss(A-B*K,zeros(size(B)),C-D*K,zeros(size(D)));%Kapalı çevrim sistemi oluşturulması. LQR ile durum geribeslemesi.

for i=1:100
deltax0=randn(2,1);%Doğrusallaştırılmış sistemin (delta) durumları için ilk değer tanımlanması.
[y,t,x]=initial(Gcl,deltax0);%Çıkış y=0; Çıkışı olmayan sistem. LQR testi durumlar (x1,x2) için yapılmıştır.
hold on;
figure(1);
plot(t,x(:,1)+x10,'linewidth',2);%delta(x1) Durum-1
title('delta(x1)');%ilgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
grid;
figure(2);
plot(t,x(:,2)+x20,'linewidth',2);%delta(x2) Durum-2
title('delta(x2)');%ilgili başlığın grafiğe eklenemsi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
grid;
end

Q=diag([1000 1]);
R=1;
K=lqr(G,Q,R);%lqr ile K kazancının bulunması.
Gcl=ss(A-B*K,zeros(size(B)),C-D*K,zeros(size(D)));%Kapalı çevrim sistemi oluşturulması. LQR ile durum geribeslemesi.
for i=1:100
deltax0=randn(2,1);%Doğrusallaştırılmış sistemin (delta) durumları için ilk değer tanımlanması.
[y,t,x]=initial(Gcl,deltax0);%Çıkış y=0; Çıkışı olmayan sistem. LQR testi durumlar (x1,x2) için yapılmıştır.
figure(3);
hold on;
plot(t,x(:,1)+x10,'linewidth',2);%delta(x1) Durum-1
title('delta(x1) Q=diag([1000 1]) R=1');%ilgili başlığın grafiğe eklenemsi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
grid;
figure(4);
hold on;
plot(t,x(:,2)+x20,'linewidth',2);%delta(x2) Durum-2
title('delta(x2) Q=diag([1000 1]) R=1');%ilgili başlığın grafiğe eklenemsi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
grid;
end

Q=diag([1 1000]);
R=10;
K=lqr(G,Q,R);%lqr ile K kazancının bulunması.
Gcl=ss(A-B*K,zeros(size(B)),C-D*K,zeros(size(D)));%Kapalı çevrim sistemi oluşturulması. LQR ile durum geribeslemesi.
for i=1:100
deltax0=randn(2,1);%Doğrusallaştırılmış sistemin (delta) durumları için ilk değer tanımlanması.
[y,t,x]=initial(Gcl,deltax0);%Çıkış y=0; Çıkışı olmayan sistem. LQR testi durumlar (x1,x2) için yapılmıştır.
figure(5);
hold on;
plot(t,x(:,1)+x10,'linewidth',2);%delta(x1) Durum-1
title('delta(x1) Q=diag([1 1000]) R=10');%ilgili başlığın grafiğe eklenemsi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
grid;
figure(6);
hold on;
plot(t,x(:,2)+x20,'linewidth',2);%delta(x2) Durum-2
title('delta(x2) Q=diag([1 1000]) R=10');%ilgili başlığın grafiğe eklenemsi.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
grid;
end

%SORU3 Bölüm 3.2
%Tasarlanan LQR kontrolcünün "doğrusal olmayan" sisteme uygulanması.
%Durumlar (x1,x2), kazanç ve (x0,u0) = 0 orijin noktası sistem01 fonksiyonuna argüman olarak
%verilmektedir.
Q=diag([1 1]);%Q=I
R=1;%R=1
K=lqr(G,Q,R);%lqr ile K kazancının bulunması.
f=@(t,x)sistem01(x(1),x(2),K,x0,u0);%doğrusal olmayan sistemin girişine 𝑢 = −𝐾𝑥 verilmiştir. odefun.
deltax0=0;
xInit=x0+deltax0;%İlk değer.
[tt,xx]=ode45(f,[0 10],xInit);%f fonksiyonunun çözdürülmesi. (sistemin çözdürülmesi)
figure;
subplot(2,1,1);
plot(tt,xx(:,1),'linewidth',2);%1. Durum çizdir.
title('delta(x1)');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%zaman ekseninin isimlendirilmesi.
subplot(2,1,2);
plot(tt,xx(:,2),'linewidth',2);%2. Durum çizdir.
title('delta(x2)');%İlgili başlığın grafiğe eklenmesi.
xlabel('t(s)');%zaman ekseninin isimlendirilmesi.
%(𝑥10, 𝑥20) ∈ [−8, 8] × [−8, 8] bölgesinde iki yönde de 0.2 adımlık aralıklarla
%noktalar alarak bir örgü (mesh) oluşturulmuştur.
x10 = -8:0.2:8;
x20 = -8:0.2:8;
[X1,X2] = meshgrid(x10,x20);%mesgrid ile örgü.
figure;
plot(X1,X2,'r.','linewidth',2);%Örgü çizdir.
xlim([-10 10]);%x ekseni için limit.
ylim([-10 10]);%y ekseni için limit.
xlabel('x1');%x ekseni isimlendir.
ylabel('x2');%y ekseni isimlendir.
% Her (𝑥10, 𝑥20) için bu noktayı ilk koşul olarak alarak gerçek kapalı çevrim sisteminin bir
% simülasyonu gerçekleştirilecekti
for i=1:81
for k=1:81%81*81=6561 tane her nokta için başlangıç koşulu altında ode45.
Q=diag([1 1]);%Q=1*I
R=1;%R=1
K=lqr(G,Q,R);%lqr ile K kazancının bulunması.
x0=[x10(i);x20(k)];%Normalde (0,0) noktasıydı.
f=@(t,x)sistem01(x(1),x(2),K,x0,u0);%doğrusal olmayan sistemin girişine 𝑢 = −𝐾𝑥 verilmiştir.
deltax0=0;
xInit=x0+deltax0;%İlk değer.
[tt,xx]=ode15s(f,[0 10],xInit);%f fonksiyonunun çözdürülmesi. (sistemin çözdürülmesi)
a=xx(:,1)./1e4;%Durum 1
b=xx(:,2)./1e4;%Durum 2
figure(9);
hold on;
if(sum(abs([a(length(tt));b(length(tt))]).^2)^(1/2)<=0.1)%norm hesapla karşılaştır.
    plot(x10(i),x20(k),'b*')%Durum ilk değer çizdir. mavi.
    xlim([-10 10]);%x ekseni limit.
    ylim([-10 10]);%y ekseni limit.
    xlabel('x1');%x ekseni isimlendirilmesi.
    ylabel('x2');%y ekseni isimlendirilmesi.
    title('Q=I R=1');%İlgili başlığın grafiğe eklenmesi.
else
    plot(x10(i),x20(k),'r.','linewidth',10)%Durum ilk değer çizdir. kırmızı.
    xlim([-10 10]);%x ekseni limit.
    ylim([-10 10]);%y ekseni limit.
    xlabel('x1');%x ekseni isimlendirilmesi.
    ylabel('x2');%y ekseni isimlendirilmesi.
    title('Q=I R=1');%İlgili başlığın grafiğe eklenmesi.
end
Q=diag([1000 1]);
R=10;
K=lqr(G,Q,R);%lqr ile K kazancının bulunması.
x0=[x10(i);x20(k)];%Normalde (0,0) noktasıydı.
f=@(t,x)sistem01(x(1),x(2),K,x0,u0);%doğrusal olmayan sistemin girişine 𝑢 = −𝐾𝑥 verilmiştir.
deltax0=0;
xInit=x0+deltax0;%İlk değer.
[tt,xx]=ode15s(f,[0 10],xInit);%f fonksiyonunun çözdürülmesi. (sistemin çözdürülmesi)
a=xx(:,1)./1e4;%Durum 1
b=xx(:,2)./1e4;%Durum 2
figure(10);
hold on;
if(sum(abs([a(length(tt));b(length(tt))]).^2)^(1/2)<=0.1)%norm hesapla karşılaştır.
    plot(x10(i),x20(k),'b*')%Durum ilk değer çizdir. mavi.
    xlim([-10 10]);%x ekseni için limit.
    ylim([-10 10]);%y ekseni için limit.
    xlabel('x1');%x ekseni isimlendirilmesi.
    ylabel('x2');%y ekseni isimlendirilmesi.
    title('Q=[1000 1] R=10');%İlgili başlığın grafiğe eklenmesi.
else
    plot(x10(i),x20(k),'r.','linewidth',10)%Durum ilk değer çizdir. kırmızı.
    xlim([-10 10]);%x ekseni limit.
    ylim([-10 10]);%y ekseni limit.
    xlabel('x1');%x ekseni isimlendir.
    ylabel('x2');%y ekseni isimlendir.
    title('Q=[1000 1] R=10');%İlgili başlığın grafiğe eklenmesi.
end
Q=diag([1 1000]);
R=1;
K=lqr(G,Q,R);%lqr ile K kazancının bulunması.
x0=[x10(i);x20(k)];%Normalde (0,0) noktasıydı.
f=@(t,x)sistem01(x(1),x(2),K,x0,u0);%doğrusal olmayan sistemin girişine 𝑢 = −𝐾𝑥 verilmiştir.
deltax0=0;
xInit=x0+deltax0;%İlk değer.
[tt,xx]=ode15s(f,[0 10],xInit);%f fonksiyonunun çözdürülmesi. (sistemin çözdürülmesi)
a=xx(:,1)./1e4;%Durum 1
b=xx(:,2)./1e4;%Durum 2
figure(11);
hold on;
if(sum(abs([a(length(tt));b(length(tt))]).^2)^(1/2)<=0.1)%norm hesapla karşılaştır.
    plot(x10(i),x20(k),'b*')%Durum ilk değer çizdir. mavi.
    xlim([-10 10]);%x ekseni için limit.
    ylim([-10 10]);%y ekseni için limit.
    xlabel('x1');%x ekseni isimlendir.
    ylabel('x2');%y ekseni isimlendir.
    title('Q=[1 1000] R=1');%İlgili başlığın grafiğe eklenmesi.
else
    plot(x10(i),x20(k),'r.','linewidth',10)%Durum ilk değer çizdir. kırmızı.
    xlim([-10 10]);%x ekseni için limit.
    ylim([-10 10]);%y ekseni için limit.
    xlabel('x1');%x ekseni isimlendir.
    ylabel('x2');%y ekseni isimlendir.
    title('Q=[1 1000] R=1');%İlgili başlığın grafiğe eklenmesi.
end
end
end

%SORU3 Bölüm 3.3
X=zeros(3,1000);%3x1000'lik X matrisinin oluşturulması.
Y=zeros(2,1000);%2x1000'lik Y matrisinin oluşturulması.
for i=1:1000
v=randn(3,1);%std=1 3x1 vektör.      
X(:,i)=v;%X vektörünün doldurulması.
Y(:,i)=[v(1,:)^3+v(2,:);v(2,:)+v(3,:)];%Y vektörünün doldurulması.
end
S=Y/X;%Y=SX ifadesinden S bul.
A_std1=[S(:,1),S(:,2)];%A matrisinin elde edilmesi.
B_std1=S(:,3);%B matrisinin elde edilmesi.
for i=1:1000
v=0.1*randn(3,1);%std=0.1 3x1 vektör.      
X(:,i)=v;%X vektörünün doldurulması.
Y(:,i)=[v(1,:)^3+v(2,:);v(2,:)+v(3,:)];%Y vektörünün doldurulması.
end
S=Y/X;%Y=SX ifadesinden S bul.
A_std2=[S(:,1),S(:,2)];%A matrisinin elde edilmesi.
B_std2=S(:,3);%B matrisinin elde edilmesi.
for i=1:1000
v=0.01*randn(3,1);%std=0.01 3x1 vektör.      
X(:,i)=v;%X vektörünün doldurulması.
Y(:,i)=[v(1,:)^3+v(2,:);v(2,:)+v(3,:)];%Y vektörünün doldurulması.
end
S=Y/X;%Y=SX ifadesinden S bul.
A_std3=[S(:,1),S(:,2)];%A matrisinin elde edilmesi.
B_std3=S(:,3);%B matrisinin elde edilmesi.
%Elde edilen A ve B matrisleri 3.2 de elde edilen A ve B matrisleri ile
%aynıdır.
 
%Tasarlanan LQR kontrolcünün doğrusal olmayan sisteme uygulanması için
%odefun oluşturulması. (sistemin girişine u=-K*x verilmesi.)
function dxdt=sistem01(x1,x2,K,x0,u0)
x=[x1;x2];%Sistem durumları.
deltax=x-x0;
deltau=-K*deltax;%u=-Kx oluşturulması.
u=u0+deltau;%İlk koşul eklemesi.
dxdt=[x1^3+x2;x2+u];%u=-Kx girişli sistem.
end