%ELE504 Dijital Kontrol - 2022-2023/II Final Ödevi Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU2-k)
%2 Bileşenli sinüs sinyali pluşturulmuştur ve frekans alanında bu sinyalin
%bileşenleri çizdirilmiştir. a-j şıklarında tasarlanmış olan filtreler bu
%sinyale sırasıyla uygulanmaktadır. Filtrelenmiş sinyaller ve bu
%sinyallerin frekans alanındaki gösterimleri çizdirilmiştir. 
%Tasarlanan her filtrenin bode çizgileri ve dürtü tepkileri de çizdirilmektedir. 
fs=50;%örnekleme frekansı
Ts=1/fs;%örnekleme periyodu
fu1=1;%1. Bileşen için frekans.
fu2=24;%2. Bileşen için frekans.
t=0:Ts:50/10;%t, "zaman" değişkeninin oluşturulması.
u=sin(2*pi*fu1*t)+2*cos(2*pi*fu2*t);%2 farklı bileşenden oluşan sinüs sinyali.
figure;
stem(u);%2 farklı bileşenden oluşan sinüs sinyalinin çizdirilmesi.
title('2 farklı bileşenden oluşan sinüs sinyali');%filtrelenecek olan sinyal.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
xlim([0 100]);
ylim([-4 4]);
ufft = fft(u);%giriş sinyalinin fftsi. 
f = linspace(0,fs,length(ufft));%frekans ekseninin oluşturulması(örnekleme periyodu aralıklarında).
figure;
plot(f,abs(ufft));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileseni');%y ekseninin isimlendirilmesi.
title('2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü');%İlgili başlığın grafiğe eklenmesi.
n = floor(length(f)/2);%fmax = fs/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(ufft(1:n)));%fmax = fs/2 frekansa karşılık frekans bileşeninin çizdirilmesi
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');

%a şıkkında elde edilen filtrenin transfer fonksiyonu.
T=0.02;%Örnekleme periyodu T=0.02 alınmıştır.
z=tf('z',T);%Ayrık zaman z-dönüşümü transfer fonksiyonu için "z" değişkeninin tanımlanması.
A=0.239*(z+1)/(z-0.522);
figure;
subplot(3,1,1)
bode(A);
title('bode A');
grid;
subplot(3,1,2)
impulse(A)
title('impulse A');
grid;
subplot(3,1,3)
step(A)
title('step A');
grid;
figure;
rlocus(A);
title('rlocus A');
grid;
[b,a] = tfdata(A,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('A) 5 Hz Alçak Geçirgen Filtre');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('A) Filtrelenmiş 2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');%İlgili başlığın grafiğe eklenmesi.
%b şıkkında elde edilen filtrenin transfer fonksiyonu.
B=0.761*(z-1)/(z-0.522);
figure;
subplot(3,1,1)
bode(B);
title('bode B');
grid;
subplot(3,1,2)
impulse(B)
title('impulse B');
grid;
subplot(3,1,3)
step(B)
title('step B');
grid;
figure;
rlocus(B);
title('rlocus B');
grid;
[b,a] = tfdata(B,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('B) 5 Hz Yüksek Geçirgen Filtre');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('B) Filtrelenmiş 2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');%İlgili başlığın grafiğe eklenmesi.
%c şıkkında elde edilen filtrenin transfer fonksiyonu.
C=0.2185*(z+1)/(z-0.563);
figure;
subplot(3,1,1)
bode(C);
title('bode C');
grid;
subplot(3,1,2)
impulse(C)
title('impulse C');
grid;
subplot(3,1,3)
step(C)
title('step C');
grid;
figure;
rlocus(C);
title('rlocus C');
grid;
[b,a] = tfdata(C,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('C) 5 Hz Alçak Geçirgen Filtre Doğrudan Ayrıklaştırma');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('C) Filtrelenmiş 2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');%İlgili başlığın grafiğe eklenmesi.
%d şıkkında elde edilen filtrenin transfer fonksiyonu.
D=0.781*(z-1)/(z-0.563);
figure;
subplot(3,1,1)
bode(D);
title('bode D');
grid;
subplot(3,1,2)
impulse(D)
title('impulse D');
grid;
subplot(3,1,3)
step(D)
title('step D');
grid;
figure;
rlocus(D);
title('rlocus D');
grid;
[b,a] = tfdata(D,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('D) 5 Hz Yüksek Geçirgen Filtre Doğrudan Ayrıklaştırma ');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('D) Filtrelenmiş 2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');%İlgili başlığın grafiğe eklenmesi.
%e şıkkında elde edilen filtrenin transfer fonksiyonu.
E=0.385*(z+1)/(z-0.228);
figure;
subplot(3,1,1)
bode(E);
title('bode E');
grid;
subplot(3,1,2)
impulse(E)
title('impulse E');
grid;
subplot(3,1,3)
step(E)
title('step E');
grid;
figure;
rlocus(E);
title('rlocus E');
grid;
[b,a] = tfdata(E,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('E) 10 Hz Alçak Geçirgen Filtre');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('E) Filtrelenmiş 2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');%İlgili başlığın grafiğe eklenmesi.
%f şıkkında elde edilen filtrenin transfer fonksiyonu.
F=0.614*(z-1)/(z-0.228);
figure;
subplot(3,1,1)
bode(F);
title('bode F');
grid;
subplot(3,1,2)
impulse(F)
title('impulse F');
grid;
subplot(3,1,3)
step(F)
title('step F');
grid;
figure;
rlocus(F);
title('rlocus F');
grid;
[b,a] = tfdata(F,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('F) 10 Hz Yüksek Geçirgen Filtre');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('F) Filtrelenmiş 2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');%İlgili başlığın grafiğe eklenmesi.
%g şıkkında elde edilen filtrenin transfer fonksiyonu.
G=0.3795*(z+1)/(z-0.241);
figure;
subplot(3,1,1)
bode(G);
title('bode G');
grid;
subplot(3,1,2)
impulse(G)
title('impulse G');
grid;
subplot(3,1,3)
step(G)
title('step G');
grid;
figure;
rlocus(G);
title('rlocus G');
grid;
[b,a] = tfdata(G,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('G) 10 Hz Alçak Geçirgen Filtre Doğrudan Ayrıklaştırma');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('G) Filtrelenmiş 2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');%İlgili başlığın grafiğe eklenmesi.
%h şıkkında elde edilen filtrenin transfer fonksiyonu.
H=0.6205*(z-1)/(z-0.241);
figure;
subplot(3,1,1)
bode(H);
title('bode H');
grid;
subplot(3,1,2)
impulse(H)
title('impulse H');
grid;
subplot(3,1,3)
step(H)
title('step H');
grid;
figure;
rlocus(H);
title('rlocus H');
grid;
[b,a] = tfdata(H,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('H) 10 Hz Yüksek Geçirgen Filtre Doğrudan Ayrıklaştırma ');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('H) Filtrelenmiş 2 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');%İlgili başlığın grafiğe eklenmesi.

%i şıkkında elde edilen filtrenin transfer fonksiyonu.
T=0.02;%Örnekleme periyodu T=0.02 alınmıştır.
z=tf('z',T);%Ayrık zaman z-dönüşümü transfer fonksiyonu için "z" değişkeninin tanımlanması.
I=(0.293*z^2-0.293)/(z^2-0.75*z+0.119);%B*E
figure;
subplot(3,1,1)
bode(I);
title('bode I');
grid;
subplot(3,1,2)
impulse(I)
title('impulse I');
grid;
subplot(3,1,3)
step(I)
title('step I');
grid;
figure;
rlocus(H);
title('rlocus H');
grid;
[b,a] = tfdata(I,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('I)');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('I) B*E Bant Geçirgen Filtre');%İlgili başlığın grafiğe eklenmesi.
ylim([0 180]);
%J şıkkında elde edilen filtrenin transfer fonksiyonu.
J=(0.853*z^2-0.75*z+0.226)/(z^2-0.75*z+0.119);%A+F
figure;
subplot(3,1,1)
bode(J);
title('bode J');
grid;
subplot(3,1,2)
impulse(J)
title('impulse J');
grid;
subplot(3,1,3)
step(J)
title('step J');
grid;
figure;
rlocus(J);
title('rlocus J');
grid;
[b,a] = tfdata(J,'v');%Filtrenin pay ve payda terimleri.
y = filter(b,a,u);%Giriş sinyalinin filtrelenmesi.
figure;
%giriş ve çıkış sinyallerinin çizdirilmesi.
stem(t,u);
hold on;
stem(t,y);
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
title('J)');
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('J) A+F Bant Durduran filtre');%İlgili başlığın grafiğe eklenmesi.
