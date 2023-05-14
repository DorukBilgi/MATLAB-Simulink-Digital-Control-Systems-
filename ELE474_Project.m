% ELE474 Proje Doruk Bilgi 161201071

clc;
close all;

N=12;                        %12th Order Butterworth   (elle hesaplandı)
wc=0.27;                     %cut off frequency (elle hesaplandı)
[PAY,PAYDA] = butter(N,wc);
[H,w]=freqz(PAY,PAYDA);        %H(w)'nın pay ve paydası 

b0=1.13725*(10^-6);
b1=[1  1]; %12 tane olacak N=12;
a1=[1 -1.10 0.56];
a2=[1 -0.97 0.39];
a3=[1 -0.84 0.19];
a4=[1 -0.84 0.20];
a5=[1 -1.28 0.83];
a6=[1 -0.81 0.16];

pay1=conv(b1,b1);
pay2=conv(pay1,b1);
pay3=conv(pay2,b1);
pay4=conv(pay3,b1);
pay5=conv(pay4,b1);
pay6=conv(pay5,b1);
pay7=conv(pay6,b1);
pay8=conv(pay7,b1);
pay9=conv(pay8,b1);
pay10=conv(pay9,b1);
PAY=b0*conv(pay10,b1);

payda1=conv(a1,a2);
payda2=conv(payda1,a3);
payda3=conv(payda2,a4);
payda4=conv(payda3,a5);
PAYDA=conv(payda4,a6);

figure(1)
plot(w/pi,abs(H));
xlabel('Frequency (w/\pi)');
ylabel('Frequency Magnitude of H');
ylim([0 1]);
xlim([0 1]);
title('12th Order Butterworth IIR Filter');

%Tasarlanmış olan Butterworth Filtresi ile dosyanın filtrelenmesi 
[x,Fs]= audioread('C:\Users\Administrator\Desktop\fil2.wav');

y = filter(PAY,PAYDA,x); 
player = audioplayer(y,Fs);
play(player);

%Orjinal ve Filtrelenmiş Müzik Dosyasınının Frekans Domaindeki Mutlak Değerlerinin Çizilmesi

%Orijinal
m = length(x); 
n = pow2(nextpow2(m));
x_fft = fft(x, n);
f = (0:n-1)*(Fs/n);
amplitude = abs(x_fft)/n;
figure(2)
subplot(2,1,1);
plot(f(1:floor(n/2)),amplitude(1:floor(n/2)));
title('Frequency Domain Representation - Unfiltered Sound');
xlabel('Frequency');
ylabel('Amplitude');

%Filtrelenmiş
m1 = length(y); 
n1 = pow2(nextpow2(m1));
y_fft = fft(y, n1);
f = (0:n1-1)*(Fs/n1);
amplitude = abs(y_fft)/n1;
figure(2)
subplot(2,1,2);
plot(f(1:floor(n1/2)),amplitude(1:floor(n1/2)))
title('Frequency Domain Representation - Filtered Sound')
xlabel('Frequency')
ylabel('Amplitude')
