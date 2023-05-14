%ELE515 ÖDEV1 Doruk Bilgi 221211041
%SORU1 a) 
%4. Derece Runge Kutta methodu ile diferansiyel denklem çözümü için oluşturulan odeRK fonsiyonu. 
%Soru1-a)
function [t,y]=odeRK(odefun,tspan,y0,h)
t = tspan(1):h:tspan(2); %çözümün başlangıç-bitiş anlarını belirten vektör("h" adım büyüklüğü).
y = zeros(1,length(t)); %t vektörünün uzunluğu kadar 0'dan oluşan sonucun tutulacağı y vektörünün oluşturulması.
y(1) = y0;% ilk koşul y0'ın y vektörünün 1. elemanına atanması.
%y(t) anındaki çözümden tspan aralığında y(t+h) anındaki çözümün elde
%edilmesi için ilgili döngünün oluşturulması ve Runge-Kutta methodu ile
%odefun => dy/dt = f(t,y(t)) diferansiyel denkleminin h byüklüğünde adım aralıklarında çözdürülmesi.
for k=1:(length(t)-1)
k_1 = odefun(t(k),y(k));%f(t,y(t))
k_2 = odefun(t(k)+0.5*h,y(k)+0.5*h*k_1);%f(t+h/2,y(t)+h*k1/2)
k_3 = odefun((t(k)+0.5*h),(y(k)+0.5*h*k_2));%f(t+h/2,y(t)+h*k2/2)
k_4 = odefun((t(k)+h),(y(k)+k_3*h));%f(t+h,y(t)+h*k3)
%f(t,y(t))= dy/dt 'nin çözdürülmesi, y vektörünün zaman eksenine karşılık değerlerinin kaydedilmesi. 
y(k+1) = y(k) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;
end
end