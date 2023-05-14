%ELE515 ÖDEV2 Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU3-BOLUM1
x_true = linspace(3,3,1000);%1000 elemanlı her elemanı 3 olan x_true vektörünün oluşturulması.
v = randn(1,1000);%randn fonksiyonu kullanılarak aynı boyutta bir v vektörünün üretilmesi.
%"v" vektörü için "mean" ve "var" fonksiyonlarının kontrol edilmesi.
mean_v = mean(v);%ortalama 0'a yakın.
var_v = var(v);%varyans 1'e yakın.
x_cor = x_true + v;%x_cor sinyalinin elde edilmesi.
t=1:1:1000;%x-ekseninin oluşturulması.
plot(t,x_true,'blue');%x_true'nun t eksenine karşılık çizdirilmesi.
hold on;%x_true ve x_cor'un üst üste çizdirilmesi.
plot(t,x_cor,'red');%x_cor'un t eksenine karşılık çizdirilmesi.
legend('Xtrue','Xcor');%eğrilerin isimlendirilmesi.
title('SORU3-BOLUM1: Xtrue ve Xcor sinyallerinin üst üste çizdirilmesi')%Grafiğin isimlendirilmesi.
grid;

%SORU3-BOLUM2
%Optimizasyonun manuel olarak yapılması.
tvec = linspace(0,5,1000);%[0,5] aralığında 1000 değerden oluşan "tvec" oluşturulması.
%Üretilen "tvec" vektörünün her bir elemanı için c(t) vektörünün oluşturulması.
c=linspace(0,0,1000);%1000 elemanlı boş bir c vektörü oluştur.
for t=1:1000%"tvec" vektörünün her bir elemanı için toplam.
    for k=1:1000%toplam sembolündeki "k" için for döngüsü.
        c(t)=c(t)+(tvec(t)-x_cor(k)).^2;%Toplamın hesaplanması.
    end
end
figure;%Manuel olarak yapılan optimizasyonun çizdirilmesi.
plot(tvec,c,'red');%[0,5] aralığında C(t)'nin grafiğinin çizilmesi.
hold on;%c(t) minimum noktasının aynı grafik üzerine işaretlenmesi.
min_c = islocalmin(c);%c(t) minimum noktasının koordinatlarının bulunması ve min_c değerine bu değerin kaydedilmesi.
plot(tvec(min_c),c(min_c),'*b');%C(t) fonksiyonunun minimum noktasının mavi ile işaretlenmesi.
legend('c(t)','min(C)');%Eğrilerin ve minimum noktanın isimlendirilmesi.
title('SORU3-BOLUM2: [0,5] aralığında c(t) fonksiyonunun çizdirilmesi');%İlgili başlığın grafiğe eklenmesi.
grid;

%"fminunc" fonksiyonu ile optimizasyonun yapılması.
% x_true = linspace(3,3,1000);
% v = randn(1,1000);
% x_cor = x_true + v;
% n1 = 1000;
% t0 = linspace(0,5,1000);
% options = optimoptions('fminunc','Display','iter','Algorithm','trust-region','OptimalityTolerance',6000,'MaxFunctionEvaluations',1e7,'SpecifyObjectiveGradient',true,'HessianFcn','objective');
% [xfinal,fval,exitflag] = fminunc(@(t)(seritoplami01(t,n1,x_cor)),t0,options);
% x_true=[6*ones(1,200),-4*ones(1,200),10*ones(1,200),-2*ones(1,200),8*ones(1,200)];
options = optimoptions(@fminunc,'Algorithm','quasi-newton','OptimalityTolerance',1e-10,'MaxFunctionEvaluations',1e7,'Display','iter');%fminunc fonksiyonu için options argümanının oluşturulması.
t=1:1000;%x-ekseninin oluşturulması.
t0=linspace(0,0,1000);%fminunc fonksiyonuna argüman olarak verilecek ilk değer vektörü.
fun1 = @(t) ((sum(t(1:1000)-x_cor(1:1000)).^2));%SORU3-BOLUM2 optimizasyon probleminin oluşturulması.
[xfinal1,fval1,exitflag1] = fminunc(fun1,t0,options);%optimizasyon problemi çözdürülerek tahmin sinyalinin bulunması.
figure;
plot(t,x_true,'.b');%xtrue sinyalinin mavi nokta ile çizdirilmesi.
hold on;
plot(t,xfinal1,'.r');%tahmin sinyalinin kırmızı nokta ile çizdirilmesi.
hold on;
plot(t,x_cor,'.y');%xcor sinyalinin sarı nokta ile çizdirilmesi.
legend('Xtrue','Xfinal','Xcorr');%sinyallerin isimlendirilmesi.
title('SORU3-BOLUM2: [0,1000] aralığında Xtrue, Xhat, Xcorr sinyallerinin çizdirilmesi ');%İlgili başlığın grafiğe eklenmesi.

%SORU3-BOLUM3
% x_true=[6*ones(1,200),-4*ones(1,200),10*ones(1,200),-2*ones(1,200),8*ones(1,200)];%(piecewise constant) Xtrue vektörünün oluşturulması.
% v = randn(1,1000);%"randn" fonksiyonu kullanılarak Bölüm-1'deki v vektörünün üretilmesi.
% x_cor = x_true + v;%Bölüm 3 için "x_cor" sinyalinin elde edilmesi.
% n1=1000;
% xhat0 = linspace(0,5,1000);
% options = optimoptions('fminunc','Display','iter','Algorithm','trust-region','OptimalityTolerance',1e-10,'MaxFunctionEvaluations',1e7,'SpecifyObjectiveGradient',true,'HessianFcn','objective');
% [xfinal2,fval2,exitflag2] = fminunc(@(x_hat)(seritoplami02(x_hat,n1,x_cor)),xhat0,options);%"xhat" sinyalinin elde edilmesi.
% figure;
% plot(xhat0,x_true,'.b');
% hold on;
% plot(xhat0,xfinal2,'.r');
% hold on;
% plot(xhat0,x_cor,'.y');
% legend('Xtrue','Xhat','Xcorr');
% title('SORU3-BOLUM3: [0,1000] aralığında Xtrue, Xhat, Xcorr sinyallerinin çizdirilmesi');
x_true=[6*ones(1,200),-4*ones(1,200),10*ones(1,200),-2*ones(1,200),8*ones(1,200)];%SORU3-BOLUM3 xtrue sinyalinin oluşturulması.
v = randn(1,1000);%v vektörünün oluşturulması.
x_cor = x_true + v;%xcor vektörünün oluşturulması.
options = optimoptions(@fminunc,'Algorithm','quasi-newton','OptimalityTolerance',1e-9,'MaxFunctionEvaluations',1e7,'Display','iter');%fminunc fonksiyonu için options argümanının oluşturulması.
t=1:1000;%x-ekseninin oluşturulması.
xhat0=linspace(0,0,1000);%fminunc fonksiyonuna argüman olarak verilecek ilk değer vektörü.
fun3 = @(xhat) (sum((xhat(1:1000)-x_cor(1:1000)).^2)+sum(norm(diff(xhat(1:1000)),1)).^2);%fun3 fonksiyonunun oluşturulması(.^2) norm(,1) olarak girilmeli.
[xfinal2,fval2,exitflag2] = fminunc(fun3,xhat0,options);%optimizasyon problemi çözdürülerek tahmin sinyalinin bulunması.
figure;
plot(t,x_true,'.b');%xtrue sinyalinin mavi nokta ile çizdirilmesi.
hold on;
plot(t,xfinal2,'.r');%tahmin sinyalinin kırmızı nokta ile çizdirilmesi.
hold on;
plot(t,x_cor,'.y');%xcor sinyalinin sarı nokta ile çizdirilmesi.
legend('Xtrue','Xfinal','Xcorr');%Sinyallerin isimlendirilmesi.
title('SORU3-BOLUM3: [0,1000] aralığında Xtrue, Xhat, Xcorr sinyallerinin çizdirilmesi');%İlgili başlığın grafiğe eklenmesi.

%SORU3-BOLUM4
%Bölüm3'teki optimizasyonun "ischange" komutu ile yapılamsı.
[xhat,S1,S2] = ischange(x_cor,'linear','Threshold',200);
xhat_segline = S1.*(1:1000) + S2;
figure;
plot(1:1000,x_true,'.b',1:1000,xhat_segline,'.r',1:1000,x_cor,'.y');
legend('Xtrue','Xhat','Xcorr');
title('SORU3-BOLUM4: Xtrue, Xhat, Xcorr sinyallerinin çizdirilmesi (ischange)');

%BÖLÜM2 "fminunc" fonksiyonu otomatik kullanım.
% function [c,g,H]=seritoplami01(t,n1,x_cor)
% c=0;
% for i=1:n1
%  for k=1:1000
%   c = c + (t(i)-x_cor(k)).^2;
%  end
% end
% if nargout > 1 % gradient required
% g=linspace(0,0,1000);  
% for l=1:n1
%     for m=1:1000
%     g(l) = g(l) +(-2.*(t(l)-x_cor(m)));
%     end
% end
% if nargout > 2 % Hessian required
% H=zeros(1000,1000);
% for n=1:1000
%     H(n,n) = 2000;  
% end
% end
% end
% end

%BÖLÜM3 "xhat" için "fminunc" fonksiyonu otomatik kullanım.
% function [c,g,H]=seritoplami02(x_hat,n2,x_cor)
% a=0;
% b=0;
% for k=1:n2
%   a = a + (x_hat(k)-x_cor(k)).^2;
% end
% for i=1:n2-1
%   b = b + norm(x_hat(i+1)-x_hat(i));
% end
% c = a + b.^2;
% if nargout > 1 % gradient required
% g=linspace(0,0,1000);  
% for l=1:n2
%     for m=1:1000
%     g(l) = g(l) +(-2.*(x_hat(l)-x_cor(m)));
%     end
% end
% end
% if nargout > 2 % Hessian required
% H=zeros(1000,1000);
% for n=1:1000
%     H(n,n) = 2000;  
% end
% end
% end
