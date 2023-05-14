%ELE504 Dijital Kontrol - 2022-2023/II Final Ödevi Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU4
%SORU4-a)
%Şartlar;
%1) Kapalı çevrim sisteminin sönüm oranı (𝜁) 0.3 ile 0.4 arasında olmalı. 
%2) Kapalı çevrim sisteminin doğal frekansı (𝜔𝑛) 0.1𝜋𝑇 ile 0.2𝜋𝑇 arasında olmalı.
T=1;%Örnekleme periyodu T=1 alınmıştır.
z=tf('z',T);%Ayrık zaman z-dönüşümü transfer fonksiyonu için "z" değişkeninin tanımlanması.
P=(z^2-0.5)/(z^3-1*z^2-1*z+0.5);%Üçüncü derece kararsız sistem P(z) transfer fonksiyonu.
%order(P);
rlocus(P);%P sistemi kök yer eğrisi.
zgrid([0.3 0.4],[(0.1*pi)/T (0.2*pi)/T]);
axis equal;
xlim([-2 2]);
ylim([-2 2]);
%P(z) sisteminin birim çemberin dışında kutbu var. Hiçbir Kp kazanç bloğu
%(P-kontrolcü) değeri ile bu kutbun birim çemmber içerisinde olması
%sağlanamaz.(Sistemin kararlı hale getirilmesi sağlanamaz). 
%Dolayısıyla sistemin bir Kp (P-Kontrolcü) ile verilen şartları sağlaması mümkün değildir.
%P sisteminin kök yer eğrisi incelendiğinde eğrinin hiç bir noktası
%verilen şartları sağlayacak bölge içerisinde olmadığı görülmektedir.
%SORU4-b)
%sisotool(P);
C_PID=(1.168*(z-0.3018)^2)/(z-1);%sisotool ile kök yer eğrisinden istenilen P-kontrolcü seçilmesi.
%pid(C_PID);%PID kontrolcü parametreleri "pid" komutu ile gösterilmiştir.
cl=feedback(P*C_PID,1);%Kapalı çevrim sistemi oluşturulması.
[wn_cl,zeta_cl]=damp(cl);%KÇTF'nin dominant kutupları için verilen şartların sağlandığı "damp"
%fonksiyonu ile gözlemlenmektedir.
figure;
step(cl);%KÇTF birim basamak cevabı.
grid;
figure;
rlocus(cl);%KÇTF kök yer eğrisi.
zgrid([0.3 0.4],[(0.1*pi)/T (0.2*pi)/T]);
