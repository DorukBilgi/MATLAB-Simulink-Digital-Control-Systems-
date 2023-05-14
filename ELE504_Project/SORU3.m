%ELE504 Dijital Kontrol - 2022-2023/II Final Ödevi Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU3
%SORU3-b)
T=1;%Örnekleme periyodu T=1 alınmıştır.
z=tf('z',T);%Ayrık zaman z-dönüşümü transfer fonksiyonu için "z" değişkeninin tanımlanması.
P=(0.1*z-0.02)/(z^3-0.8*z^2+0.04*z+0.048);%Sistem P transfer fonksiyonu.
rlocus(P);%P sistemi kök yer eğrisi.
zgrid([0.6 0.8],[(0.2*pi)/T (0.4*pi)/T]);%Verilen şartlara karşılık gelen bölge gösterilmiştir.
axis equal;
xlim([-1 1]);
ylim([-1 1]);
%SORU3-c)
%Verilen şartlara uygun iki farklı Kp (K1 ve K2) değerleri seçilmiştir.
%Bölge gösterilmiştir.
K1=2.61;%Zeta = 0.635
K2=1.55;%Zeta = 0.751
%SORU3-d)
cl1=feedback(P*K1,1);
[wn_cl1,zeta_cl1]=damp(cl1);%KÇTF'nin dominant kutupları için verilen şartların sağlandığı "damp"
%fonksiyonu ile gözlemlenmektedir.
cl2=feedback(P*K2,1);
[wn_cl2,zeta_cl2]=damp(cl2);%KÇTF'nin dominant kutupları için verilen şartların sağlandığı "damp"
%fonksiyonu ile gözlemlenmektedir.
figure;
step(cl1);%KÇTF1 Birim basamak cevabı.
grid;
figure;
step(cl2);%KÇTF2 Birim basamak cevabı.
grid;
%SORU3-e)
%Kapalı çevrim sistemleri için birim basamak cevapları incelenmiş olup a)
%şıkkında elde edilen sonuçlar ile karşılaştırılmıştır.
%K1=2.61; için (Zeta = 0.635) Aşım ve yükselme zamanlarında farklılıklar
%vardır. A şıkkında hesaplanmış sınırlara çok yakın fakat bu sınırlar
%içerisinde değildir.