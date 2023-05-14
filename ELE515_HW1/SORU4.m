%ELE515 ÖDEV1 Doruk Bilgi 221211041
close all;
clc;
%Soru4-Bolum1
n = 1;
h = 1:10;%x1 için başlangıç koşulunun tutulacağı vektör.
k = 1:10;%x2 için başlangıç koşulunun tutulacağı vektör.
while n<=10%10 adet rastgele başlangıç koşulu için dinamik sistemin çözdürülmesi.
 h(n)=randi([-5 5]);%[-5,5] aralığında rastgele başlangıç koşulunun x1 için üretilemsi. 
 k(n)=randi([-5 5]);%[-5,5] aralığında rastgele başlangıç koşulunun x2 için üretilemsi.
 [~,y] = ode45(@f,[0 20],[h(n);k(n)]);%Başlangıç-bitiş zamanı [0,20] olacak şekilde dinamik sistemin her döngüde yeni başlangıç koşuluyla çözdürülmesi.
 plot(y(:,1),y(:,2),'r','linewidth',2);%x1'e karşılık x2'nin kırmızı renk ile çizdirilmesi.
 xlim([-3 4]);%x ekseni limitinin ayarlanması.
 ylim([-3 5]);%y ekseni limitinin ayarlanması.
 hold on;
 title('Soru4-Bölüm1');%İlgili başlığın grafiğe eklenmesi.
 xlabel('x1');%x ekesninin isimlendirilmesi.
 ylabel('x2');%y ekesninin isimlendirilmesi.
 plot(y(1,1),y(1,2),'og','linewidth',3);%Çözümün başlangıç değerlerinin yeşil nokta ile işaretlenmesi.
 plot(y(end,1),y(end,2),'ob','linewidth',3);%Çözümün bitiş değerlerinin mavi nokta ile işaretlenmesi.
 hold on;%Bir sonraki çözümünün çizdirilmesi için grafiğin açık tutulması.
 n=n+1;
end

%Soru4-Bolum2
figure;
l = 1;
while l<=1000%1000 adet farklı başlangıç koşulu için dinamik sistemin çözdürülmesi.
 h(l)=randi([-5 5]);%[-5,5] aralığında rastgele başlangıç koşulunun x1 için üretilemsi.
 k(l)=randi([-5 5]);%[-5,5] aralığında rastgele başlangıç koşulunun x2 için üretilemsi.
 [~,y] = ode45(@f,[0 30],[h(l);k(l)]);%Başlangıç-bitiş zamanı [0,30] olacak şekilde dinamik sistemin her döngüde yeni başlangıç koşuluyla çözdürülmesi.
 plot(y(end,1),y(end,2),'b.','linewidth',3);%Çözümün sadece bitiş değerlerinin mavi nokta ile işaretlenmesi. 
 xlim([-2.5 2.5]);%x ekseni limitinin ayarlanması.
 ylim([-3 3]);%y ekseni limitinin ayarlanması.
 hold on;%Bir sonraki çözümünün çizdirilmesi için grafiğin açık tutulması.
 title('Soru4-Bölüm2');%İlgili başlığın grafiğe eklenmesi.
 xlabel('x1');%x ekesninin isimlendirilmesi.
 ylabel('x2');%y ekesninin isimlendirilmesi.
 hold on;%Bir sonraki çözümünün çizdirilmesi için grafiğin açık tutulması.
 l=l+1;
end

%Soru4-Bolum3
figure;
m = 1;
while m<=1000%1000 adet farklı başlangıç koşulu için dinamik sistemin çözdürülmesi.
 h(m)=randi([-5 5]);%[-5,5] aralığında rastgele başlangıç koşulunun x1 için üretilemsi.
 k(m)=randi([-5 5]);%[-5,5] aralığında rastgele başlangıç koşulunun x2 için üretilemsi.
 [~,y] = ode45(@f,[0 30],[h(m);k(m)]);%Başlangıç-bitiş zamanı [0,30] olacak şekilde dinamik sistemin her döngüde yeni başlangıç koşuluyla çözdürülmesi.
 plot(y(end,1),y(end,2),'b.','linewidth',3) %plots end point 
 xlim([-3 3]);%x ekseni limitinin ayarlanması.
 ylim([-3 3]);%y ekseni limitinin ayarlanması.
 hold on;%Bir sonraki çözümünün çizdirilmesi için grafiğin açık tutulması.
 title('Soru4-Bölüm3');%İlgili başlığın grafiğe eklenmesi.
 xlabel('x1');%x ekesninin isimlendirilmesi.
 ylabel('x2');%y ekesninin isimlendirilmesi.
 hold on;%Bir sonraki çözümünün çizdirilmesi için grafiğin açık tutulması.
 m=m+1;
end

hold on;%Çemberin grafiğe eklenmesi için grafiğin açık tutulması.
objective =@(y)(1-y(1).^2).*y(2)-y(1);%minumum kısıtlaması bulunacak olan fonksiyonun "objective" değişkenine anonim fonksiyon olarak kaydedilmesi.
y0=[randi([-5 5]);randi([-5 5])];%Tüm kısıtlamaları kapsayacak bir başlangıç noktasının rastgele seçilmesi. 
lb = [-5,-5];%fmincon fonksiyonu için alt sınır tanımlanması.(-5<=x1<=5, -5<=x2<=5)
ub = [5,5];%fmincon fonksiyonu için alt sınır tanımlanması.(-5<=x1<=5, -5<=x2<=5)
%minimum kıstlamanın "objective" fonksiyonu için hesaplanması.
x = fmincon(objective,y0,[],[],[],[],lb,ub,@circlecon);%Çözümü çevreleyecek çember için çember üzerindeki minimum noktanın koordinatları. 
yaricap=norm([x(1) x(2)]);%"fmincon" ile hesaplanan noktanın orijine olan uzaklığının yani çemberin yarıçapının "norm" fonksiyonu ile hesaplanması.
%plot(x(1),x(2),'bo','linewidth',10);%Çözümün minumum kısıtlama noktasının işaretlenmesi. 

%Kısıtlama çemberinin çizdirilmesi.
%Çembere, hesaplanmış olan minimum kısıtlama noktalarının orijine olan uzaklığını norm ile bulunması ve yarıçap olarak verilmesi.
%Çemberin yarıçapının ve çemberin merkez koordinatlarının girilerek çemberin çizdirilmesi.
cplot = @(r,xc,yc) plot(xc + r*cos(linspace(0,2*pi)),yc + r*sin(linspace(0,2*pi)),'r','linewidth',2);
cplot(yaricap,0,0);

%Dinamik sistem fonksiyonu "f" nin oluşturulması.
function dydt = f(t,y) 
  dydt = [y(2);(1-y(1).^2).*y(2)-y(1)];
end
%Çözümü minimize edecek olan kısıtlama çemberi fonsksiyonunun tanımlanması.
%"fmincon" fonksiyonu için bir argüman olarak verilecektir.
function [c,ceq] = circlecon(p)
c = p(1)^2 + p(2)^2 - (2.8)^2;
ceq = [];
end