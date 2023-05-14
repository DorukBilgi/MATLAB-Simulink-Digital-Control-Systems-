%ELE515 ÖDEV2 Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU1
fs=1000;%örnekleme frekansı
Ts=1/fs;%örnekleme periyodu
fu1=50;%1. Bileşen için frekans.
fu2=100;%2. Bileşen için frekans.
fu3=200;%3. Bileşen için frekans.
t=0:Ts:50/fu1;%t, "zaman" değişkeninin oluşturulması.
u=sin(2*pi*fu1*t)+2*cos(2*pi*fu2*t)+3*sin(2*pi*fu3*t);%3 farklı bileşenden oluşan sinüs sinyali.
figure;
plot(t,u);%3 farklı bileşenden oluşan sinüs sinyalinin çizdirilmesi.
title('3 farklı bileşenden oluşan sinüs sinyali');%filtrelenecek olan sinyal.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
xlim([0 0.25]);%x ekseni için limit.
ufft = fft(u);%giriş sinyalinin fftsi. 
f = linspace(0,fs,length(ufft));%frekans ekseninin oluşturulması(örnekleme periyodu aralıklarında).
figure;
plot(f,abs(ufft));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileseni');%y ekseninin isimlendirilmesi.
title('3 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü');%İlgili başlığın grafiğe eklenmesi.
n = floor(length(f)/2);%fmax = fs/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(ufft(1:n)));%fmax = fs/2 frekansa karşılık frekans bileşeninin çizdirilmesi
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('3 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');
%"u" giriş sinyalinin fftsine bakıp istenilen aralıkları çıkartmak istiyoruz.
%filtre01 fonksiyonunun kullanılması.
[b,a] = filtre01([1 2 3], [20 50; 200 Inf]); 
y = filter(b,a,u);%Fonksiyon tarafından elde edilen filtre katsayıları ile giriş sinyalinin filtrelenerek y çıkışına kaydedilmesi.
figure;
plot(t,u,t,y);%giriş ve çıkış sinyallerinin çizdirilmesi.
xlim([0 0.25]);%x ekseni için limit.
xlabel('t(s)');%x ekseninin isimlendirilmesi.
ylabel('Genlik');%y ekseninin isimlendirilmesi.
legend('Giriş','Çıkış');%sinyallerin isimlendirilmesi.
tf_filtre = tf(b,a);%Başlıkta kullanılmak üzere bode faz ve bode mag değerleri için filtrenin transfer fonksiyonunun oluşturulması.
[mag,phase] = bode(tf_filtre,fu2);%bode faz ve bode mag değerlerinin bulunması.
title([num2str(fu2),' Hz için filtre genliği ',num2str(20*log10(mag)),' dB ve fazı ',num2str(phase),char(176)]);%char(176) ile derece sembolünün kullanılması. num2str ile değerlerin başlığa eklenmesi. 
yfft=fft(y);%filtrelenmiş sinyalin fftsinin çizdirilmesi.
f=linspace(0,fs,length(yfft));%Fft için frekans ekseninin oluşturulması.
n=floor(length(f)/2);%fmax/2 değerinin "n" değişkenine atanması.
figure;
plot(f(1:n),abs(yfft(1:n)));%Frekansa karşılık frekans bileşeninin çizdirilmesi.
xlabel('f(Hz)');%x ekseninin isimlendirilmesi.
ylabel('Frekans Bileşeni');%y ekseninin isimlendirilmesi.
title('Filtrelenmiş 3 Bileşenli Sinüs Sinyalinin Fourier Dönüşümü (fmax/2)');%İlgili başlığın grafiğe eklenmesi.
