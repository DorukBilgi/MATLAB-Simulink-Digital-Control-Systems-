%ELE515-PROJE Doruk Bilgi 221211041
clear all;
close all;
clc;
%1.Bölüm
%2.Derece doğrusal olmayan sistemin MATLAB ve Simulink altında oluşturulması.
t=0:1:100;
omega1=30;%rad/sec
omega2=50;%rad/sec
omega3=80;%rad/sec
omega4=20;%rad/sec
omega5=100;%rad/sec
delta1=200;%Genlik1
delta2=500;%Genlik2
delta3=400;%Genlik3
delta4=300;%Genlik4
delta5=100;%Genlik5
F1=delta1*sin(omega1*t);%N
F2=delta2*sin(omega2*t);%N
F3=delta3*sin(omega3*t);%N
F4=delta4*sin(omega4*t);%N
F5=delta5*sin(omega5*t);%N
u=[F1 F2 F3 F4 F5];%5 giriş. F1,F2,F3,F4,F5.
tspan=[0 25];
x0=[0;0;0;0;0;0;0;0;0;0];%Durumların (hız ve yerdegistirme değerleri) ilk değerleri 0.
[t,x]=ode45(@five_wagon_system,tspan,x0,[],u);
plot(t,x,'linewidth',2);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('x_n');%y ekseninin isimlendirilmesi.
legend('x1=yerdeğiştirme1','x2=hız1','x3=yerdeğiştirme2','x4=hız2','x5=yerdeğiştirme3','x6=hız3','x7=yerdeğiştirme4','x8=hız4','x9=yerdeğiştirme5','x10=hız5');%Sinyallerin (Durumların) isimlendirilmesi.
title('Tüm Durumlar');%İlgili başlığın grafiğe eklenmesi.
grid;
%2.Bölüm
%Doğrusal olmayan sistem Simulink altında doğrusallaştırılmıştır.
%Doğrusallaştırılmış sistemin durum uzayı gösterimi MATLAB'a alınmıştır.
%Durumlar x1,x2,x3,x4,x5,x6
%Girişler F1,F2,F3,F4,F5
%Çıkış y1
%Doğrusallaştırılmış sistemin A,B,C,D matrisleri.
A=[0 1 0 0 0 0;-2.936 -1.667 0.932 0.6667 0 0;0 0 0 1 0 0;0.5442 1 -2.359 -1.5 0 0;0 0 0 0 0 1;0 0 0.2571 4 -9.039 -5];
B=[0 0 0 0 0; 0.003333 0 0 0 0;0 0 0 0 0;0 0.005 0 0 0;0 0 0 0 0;0 0 0.01 0 0];
C=[0 0 0 0 1 0];
D=[0 0 0 0 0];
G=ss(A,B,C,D);%Doğrusal sistem G.
sysTum=ss(A,[B B],C,[D D]);%Kalman için tümleşik sistem.
Q1=diag([1 1 1 1 1]);%Proses gürültüsü
R1=1;%Ölçüm gürültüsü.
Kest1=kalman(sysTum,Q1,R1);%Kalman filtresi için Durum Uzayı elde edilmiştir.
Q2=diag([1 1 1 1 1]);%Proses gürültüsü
R2=0.00001;%Ölçüm gürültüsü.
Kest2=kalman(sysTum,Q2,R2);
Q3=diag([1 1 1 1 1]);%Proses gürültüsü
R3=0.00005;%Ölçüm gürültüsü.
Kest3=kalman(sysTum,Q3,R3);