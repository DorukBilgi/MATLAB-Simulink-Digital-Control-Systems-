%ELE515 ÖDEV1 Doruk Bilgi 221211041
close all;
clc;
%Soru3-Bolum1
tstart = 0;%Simülasyon başlangıç zamanı.
tfinal = 10;%Simülasyon bitiş zamanı.
tspan = [tstart tfinal];%simülasyon aralığının tspan değişkenine kaydedilmesi.
y0 = [10;0];%x1(0) = 10, x2(0) = 0 başlangıç koşulları.
[t,y] = ode45(@f, tspan, y0);%ode45 ile "f" dinamik sisteminin çözümü
plot(t,y(:,1),'r-','linewidth',2)%x1(t)(yükseklik) çizdirilmesi.
title('Soru3-Bölüm1');%ilgili başlığın grafiğe eklenmesi.
legend('x1(t) (yükseklik)');%eğrinin isimlendirilmesi.
xlabel('time');%x ekseninin isimlendirilmesi.
ylabel('postion');%y ekseninin isimlendirilmesi.
grid;
figure;

%Soru3-Bolum2
options = odeset('Events', @stopevent);%ODE Event Location Tanımlanması. Stopevent fonksiyonu.
[t,y] = ode45(@f, tspan , y0, options);%ode45 ile "f" dinamik sisteminin options ile belirtilen stopevent kısıtlaması altında çözümü.
plot(t,y(:,1),'r-','linewidth',2);%yükseklik x1(t)'nin çizdirilmesi.
title('Soru3-Bölüm2');%ilgili başlığın grafiğe eklenmesi.
legend('x1(t) (yükseklik)');%eğrinin isimlendirilmesi.
xlabel('time');%x ekseninin isimlendirilmesi.
ylabel('postion');%y ekseninin isimlendirilmesi.
grid;
figure;

%Soru3-Bolum3
k = 1;
options1 = odeset('events',@stopevent2,'refine',10);%ODE Event Location Tanımlanması. Stopevent2 fonksiyonu.
[t,y,~,~]=ode45(@f,[0 10],[10;0],options1);%ode45 ile "f" dinamik sisteminin options1 ile belirtilen stopevent2 kısıtlaması altında çözümü.
tplot = t;%t değerlerinin tplot değikenine kaydedilmesi.
yplot = y;%y değerlerinin yplot değişkenine kaydedilemsi.
while k<5% bounce count = 5. Topun 5 kere yere çarptığı durum için while döngüsü oluşturulmuştur.
%ode45 ile "f" dinamik sisteminin options1 ile belirtilen stopevent2 kısıtlaması altında çözümü.
%Topun her çarpma durumdan sonra hızının ters yönde daha düşük bir hızla
%hareketi için y(2) hız değişkeni ilk koşulu "a" katsayısı ile çarpılmaktadır.
a=-0.9;%ters yönde hızlanma çarpanı.(0,1) aralığında bir değer. 
[t,y]=ode45(@f,[tplot(end) 10],[0; yplot(end)*a],options1);
%Topun t+1 anındaki hızı t anındaki hızına göre her zaman daha düşük
%çıkmaktadır. Böylelikle topun yüksekliği her sekmede azalmaktadır.
tplot = [tplot;t];%tplot değerinin her adımda güncellenmesi.
yplot = [yplot;y];%yplot değerinin her adımda güncellenmesi.
k=k+1;
end
plot(tplot,yplot(:,1),'r-','linewidth',2);%yükseklik x1(t)'nin çizdirilmesi.
title('Soru3-Bölüm3');%ilgili başlığın grafiğe eklenmesi.
legend('x1(t) (yükseklik)');%eğrinin isimlendirilmesi.
xlabel('time');%x ekseninin isimlendirilmesi.
ylabel('postion');%y ekseninin isimlendirilmesi.
grid;
figure;

%Soru3-Bolum4
k = 1;
options2 = odeset('events',@stopevent3,'refine',10);%ODE Event Location Tanımlanması. Stopevent3 fonksiyonu.
[t,y,~,~]=ode45(@f1,[0 30],[10;11],options2);%tspan = [0 30],x1_0=10 ve x2_0=11 ilk koşulları ile "f1" dinamik sistemi çözdürülmüştür.
tplot = t;%t değerlerinin tplot değikenine kaydedilmesi.
yplot = y;%y değerlerinin yplot değişkenine kaydedilemsi.
while k<100% bounce count herhangi bir değer seçilebilir. Topun 5 kere yere çarptığı durum için while döngüsü oluşturulmuştur.
[t,y]=ode45(@f1,[tplot(end) 30],[yplot(end,1); yplot(end,2)],options2);%ode45 ile "f1" dinamik sisteminin options2 ile belirtilen stopevent3 kısıtlaması altında çözümü.
tplot = [tplot;t];%tplot değerinin her adımda güncellenmesi.
yplot = [yplot;y];%yplot değerinin her adımda güncellenmesi.
if(abs(y(1)) + abs(y(2))<=0.001)
break;%|x1|+|x2| <= 0.001 koşulu sağlandığı zaman döngüden çıkılmalı.
end
k=k+1;
end
plot(yplot(:,1),yplot(:,2),'r-','linewidth',2);%yükseklik-hız grafiğinin çizdirilmesi.
title('Soru3-Bölüm4');%ilgili başlığın grafiğe eklenmesi.
xlabel('x1');%x ekseninin isimlendirilmesi.
ylabel('x2');%y ekseninin isimlendirilmesi.
figure;

%Soru3-Bolum5
l = 1;
options3 = odeset('events',@stopevent3,'refine',10);%ODE Event Location Tanımlanması. Stopevent4 fonksiyonu.
[t,y,tev,yev]=ode45(@f2,[0 30],[10;11],options3);%tspan = [0 30],x1_0=10 ve x2_0=11 ilk koşulları ile "f1" dinamik sistemi çözdürülmüştür.
tplot = t;%t değerlerinin tplot değikenine kaydedilmesi.
yplot = y;%y değerlerinin yplot değişkenine kaydedilemsi.
while l<5% bounce count = 5. Topun 5 kere yere çarptığı durum için while döngüsü oluşturulmuştur.
[t,y]=ode45(@f2,[tplot(end) 30],[yplot(end,1); yplot(end,2)],options2);
tplot = [tplot;t];%tplot değerinin her adımda güncellenmesi.
yplot = [yplot;y];%yplot değerinin her adımda güncellenmesi.
if(abs(y(1)) + abs(y(2))<=0.001)
break;%|x1|+|x2| <= 0.001 koşulu sağlandığı zaman döngüden çıkılmalı.
end
l=l+1;
end
plot(yplot(:,1),yplot(:,2),'r-','linewidth',2);%yükseklik-hız grafiğinin çizdirilmesi.
title('Soru3-Bölüm5');%ilgili başlığın grafiğe eklenmesi.
xlabel('x1');%x ekseninin isimlendirilmesi.
ylabel('x2');%y ekseninin isimlendirilmesi.

% Dinamik sistem fonksiyonu 1 (Bolum 3)
% dy1/dt = y2
% dy2/dt = -g
function dydt = f(t,y) 
  dydt = [y(2); -9.8];
end

% Dinamik sistem fonksiyonu 2 (Bolum 4)
% dy1/dt = y2
% dy2/dt = -k1*sgn(x1)-k2*sgn(x2), k1=4, k2=1
function dydt = f1(t,y) 
  dydt = [y(2);(-4.*sign(y(1))-sign(y(2)))];
end

% Dinamik sistem fonksiyonu 3 (Bolum 5)
% Bolum 5 altında verilmiş sistem dinamikleri ile koşulların sağlanması.
function dydt = f2(t,y) 
if(y(1)>0 && y(2)>0)
    dydt = [1; -3];
elseif(y(1)<0 && y(2)>0)
    dydt = [3; 1];
elseif(y(1)<0 && y(2)<0)
    dydt = [-1; 3];
elseif(y(1)>0 && y(2)<0)
    dydt = [-3;-1];
end
end

% Stop Event Fonksiyonu 1
% x1(t) değeri 0'a gelince simülasyonun durdurulması.
function [value, stop, direction] = stopevent(t,y)
value = y(1); 
stop = 1;       
direction = 0;   
end

% Stop Event Fonksiyonu 2
% x1(t) değerinin top yere çarptıktan sonra artması yani topun yerden yukarı yükselmesi anlamında
% direction = -1 değeri kullanılmaktadır.
% x1(t) değeri yine 0'a gelince simülasyon durudurulamktadır.
function [value, stop, direction] = stopevent2(t,y)
value = y(1);
stop = 1;      
direction = -1; 
end

% Stop Event Fonksiyonu 3
% x2(t) değeri için top yere çarptıktan sonra topun ters yönde hareketini
% tanımlamak için direction = -1 seçilmiştir.
% x2(t) hız değeri 0'a gelince simülasyon durudurulamktadır.
function [value, stop, direction] = stopevent3(t,y)
value = y(2); 
stop = 1;        
direction = -1;   
end
