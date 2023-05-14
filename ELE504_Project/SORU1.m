%ELE504 Dijital Kontrol - 2022-2023/II Final Ödevi Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU1
%SORU1-a) MATLAB altında sistem gerçeklenmiştir.
%Kutup-sıfır, birim dürtü be birim basamak cevapları çizdirilmiştir.
T=1;%Örnekleme periyodu T=1 alınmıştır.
z=tf('z',T);%Ayrık zaman z-dönüşümü transfer fonksiyonu için "z" değişkeninin tanımlanması.
%Soruda verilen G(z) sisteminin MATLAB altında gerçeklenmesi.
G=(20000*z^5+12000*z^4+2800*z^3+3800*z^2+1450*z)/(2000*z^5-800*z^4-960*z^3+476*z^2+19*z-21);
figure;
pzmap(G);%Kutup ve sıfırlarının bulunması çizdirilmesi.
grid;
figure;
impulse(G);%Birim dürtü cevabının çizdirilmesi.
grid;
figure;
step(G);%Birim basamak cevabının çizdirilmesi.
grid;
%Sistemin kutupları birim çember içerisindedir. 
%Birim dürtü cevabı bir süre sonra oturmaktadır. 
%Birim basamak referans takibi sağlanmaktadır.
%Sistem KARARLIDIR.
%b) şıkkı tf bloğu ile Simulink ortamında gerçeklenmiştir.
%c) şıkkı doğrudan programlama yöntemi ile Simulink ortamında gerçeklenmiştir.
%d) şıkkı standart programlama yöntemi ile Simulink ortamında gerçeklenmiştir.
%e) şıkkı seri programlama yöntemi ile Simulink ortamında gerçeklenmiştir.
%zpk(G) komutuyla zero/pole/gain model bulunmuştur. Gerekli işlemler
%sonrasında Simulink ortamında gerçeklenmiştir.
Gzpk=zpk(G);
%f) şıkkı paralel programlama yöntemi ile Simulink ortamında
%gerçeklenebilmesi için "G" sisteminin öncelikle pay ve payda kısımları num
%ve den değişkenlerine kaydedilmiştir. Sonrasında "residuez" komutu ile kısmi kesirler formuna getirilmiştir.
%Gerekli işlemler sonrasında gerçeklenmiştir.
[num,den]=tfdata(G,'v');%PAY ve PAYDA terimlerinin num ve den değişkenlerine kaydedilmesi.
G1 = tf(num,den,T,'Variable','z^-1');%Sistemin z^-1'li terimler cinsinden ifade edilmesi.
[r,p,k]=residuez(num,den);
%g) şıkkı ile b-f şıklarında Simulink ortamında gerçeklenen sistemler alt
%alta ve alt modül olarak düzenlenmiştir.
%h) şıkkında sistemlerin hepsinin girişine birim basamak sinyali
%uygulanmıştır. Scope bloğu kullanılarak  verilen giriş ve elde edilen
%çıkışlar uygun şeklide çizdirilmiştir.
%SORU1-i) Y(z)/X(z)=G(z) -> Y(z)=X(z)*G(z) -> y[k]
T=1;%örnekleme periyodu.
syms z;%sembolik z
syms k;%sembolik k
%G sisteminin sembolik olarak tanımlanması.
G=(20000*z^5+12000*z^4+2800*z^3+3800*z^2+1450*z)/(2000*z^5-800*z^4-960*z^3+476*z^2+19*z-21);
X=z/(z-1);%Birim basamak sinyali Z dönüşümü.
Y=G*X;%%Birim basamak sinyali Z dönüşümü ve sistemin transfer fonksiyonu kullanılarak Y(z) ifadesi elde edilmiştir.
yk=iztrans(Y,z,k);%Sistemin birim basamak cevabı y[k] sembolik olarak ters z dönüşümü ile k cinsinden elde edilmiştir.
k = 1:T:25;%k zaman vektörünün örnekleme periyodu (T=1) ile oluşturulması.
figure;
stem(double(subs(yk,k)));%stem fonksiyonu ile ayrık zaman sistemi cevaplarının çizdirilmesi.
grid;
title("Soru-1 h) Birim basamak cevabı y[k]");%İlgili başlığın grafiğe eklenmesi.
xlabel('k');%x-ekseninin isimlendirilmesi.
ylabel('y[k]');%y-ekseninin isimlendirilmesi.