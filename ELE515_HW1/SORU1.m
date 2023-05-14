%ELE515 ÖDEV1 Doruk Bilgi 221211041
%SORU1 b-f) 
close all;
clc;
%Soru1-b)
odefun=@(t,y) y; % çözdürülmesi istenen f(t,y(t)) fonksiyonunun odefun anonim fonksiyonuna kaydedilmesi.
[t,y]=odeRK(odefun,[0 10],1,2); % odeRK fonksiyonu kullanılarak odefun fonsiyonunun y0 = 1, tspan = [0 10] ve h = 2 için çözdürülmesi.
plot(t,y,'g-','linewidth',2);%çözümün yeşil renk çizgi ile zaman eksenine karşılık çizdirilmesi.
title('Soru1-b)');%ilgili başlığın grafiğe eklenmesi.
legend('y=dy/dt, tspan=[0,10], y0=1, h=2');%zaman eksenine karşılık çizilen değerlerin isimlendirilmesi.
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
grid;
figure
%Soru1-c)
[t,y]=odeRK(odefun,[0 10],1,0.2);%odeRK fonksiyonu kullanılarak odefun fonsiyonunun y0 = 1, tspan = [0 10] ve h = 0.2 için çözdürülmesi.
plot(t,y,'r-','linewidth',2);%çözümün kırmızı renk çizgi ile zaman eksenine karşılık çizdirilmesi.
title('Soru1-c)');%ilgili başlığın grafiğe eklenmesi.
legend('y=dy/dt, tspan=[0,10], y0=1, h=0.2');%zaman eksenine karşılık çizilen değerlerin isimlendirilmesi.
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
grid;
figure
%Soru1-d)
[t,y]=odeRK(odefun,[0 10],1,0.02);%odeRK fonksiyonu kullanılarak odefun fonsiyonunun y0 = 1, tspan = [0 10] ve h = 0.02 için çözdürülmesi.
plot(t,y,'b-','linewidth',2);%çözümün mavi renk çizgi ile zaman eksenine karşılık çizdirilmesi.
title('Soru1-d)');%ilgili başlığın grafiğe eklenmesi.
legend('y=dy/dt, tspan=[0,10], y0=1, h=0.02');%zaman eksenine karşılık çizilen değerlerin isimlendirilmesi.
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
grid;
figure
%Soru1-e)
[t,y]=ode45(odefun,[0 10],1);%ode45 fonksiyonu kullanılarak odefun fonsiyonunun y0 = 1 ve tspan = [0 10] için çözdürülmesi.
plot(t,y,'c-','linewidth',2);%çözümün cyan renk çizgi ile zaman eksenine karşılık çizdirilmesi.
title('Soru1-e)(ode45)');%ilgili başlığın grafiğe eklenmesi.
legend('ode45, y=dy/dt, tspan=[0,10], y0=1');%zaman eksenine karşılık çizilen değerlerin isimlendirilmesi.
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
grid;
figure
%Soru1-f) (y=dy/dt foksiyonunun tspan=[0,10] ve y0=1 
%değerlerinde anlatik çözümü)
syms y(t)%İlgili diferansiyel denklemin eq1'e atanabilmesi için sembolik değişken y(t)'nin oluşturulması.
eq1= diff(y)== y;%dy/dt = y diferansiyel denkleminin eq1'e kaydedilemsi.
ic = y(0) == 1;%ilk değer y0=1'in initial condition(ic) değişkenine kaydedilmesi.
S = dsolve(eq1,ic);%eq1 diferansiyel denkleminin ilk koşul altında dsolve ile çözdürülemsi. 
fplot(S,[0 10],'y-','linewidth',2);%sembolik çözümün fplot ile sarı renkte çizdirilmesi.
title('Soru1-f)(Analitik)');%ilgili başlığın grafiğe eklenmesi.
legend('y=dy/dt, t=[0,10], y0=1');%zaman eksenine karşılık çizilen değerlerin isimlendirilmesi.
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
grid;
%Soru1-g)
figure
subplot(3,2,[1,2]);%ilk satırın ilk iki sütunu boyunca b-f şıklarında elde edilen sonuçların üst üste çizdirilmesi.
%b şıkkı çözümünün çizdirilmesi.(1 numralı kısımın çizdirilmesi)
[t,y]=odeRK(odefun,[0 10],1,2);
plot(t,y,'g-','linewidth',2);
hold on;%grafiğin açık tutulması ve diğer aşamalardaki çizimlerin bu grafiğe çizdirilmesi.
%c şıkkı çözümünün çizdirilmesi.
[t,y]=odeRK(odefun,[0 10],1,0.2); % c şıkkı
plot(t,y,'r-','linewidth',2);
hold on;
%d şıkkı çözümünün çizdirilmesi.
[t,y]=odeRK(odefun,[0 10],1,0.02); % d şıkkı
plot(t,y,'b-','linewidth',2);
hold on;
%e şıkkı çözümünün çizdirilmesi.
[t,y]=ode45(odefun,[0 10],1); % e şıkkı
plot(t,y,'c-','linewidth',2);
hold on;
%f şıkkı çözümünün çizdirilmesi.
fplot(S,[0,10],'y-','linewidth',2); % f şıkkı
legend('b','c','d','e','f');%İlgili şıklardaki çözümler sırasıyla işaretlenmiştir.
title('Subplot 1: b,c,d,e,f üst üste çizim');%ilgili başlığın grafiğe eklenmesi.
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
grid;
subplot(3,2,3);%g) şıkkı 2 numralı kısımın çizdirilmesi.
[t,y]=odeRK(odefun,[0 10],1,2);%b şıkkı çözümünün elde edilmesi.
newS1 = subs(S);%symbolik S(S=exp(t)) değerinin subs komutu ile t anındaki(h=2) değerlerinin newS1 değişkenine kaydedilemsi.
plot(t,abs(y-double(newS1)),'r-','linewidth',2);%b-f farkının mutlak değerinin çizdirlmesi.
title('Subplot 2: b-f farkının mutlak değeri');%ilgili başlığın grafiğe eklenmesi.
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
legend('|b-f|');%çizginin isimlendirilmesi
grid;
subplot(3,2,4);%g) şıkkı 3 numralı kısımın çizdirilmesi.
[t,y]=odeRK(odefun,[0 10],1,0.2);%c şıkkı 
newS2 = subs(S);%symbolik S(S=exp(t)) değerinin subs komutu ile t anındaki(h=0.2) değerlerinin newS2 değişkenine kaydedilemsi.
plot(t,abs(y-double(newS2)),'r-','linewidth',2);%c-f farkının mutlak değerinin çizdirlmesi.
title('Subplot 3: c-f farkının mutlak değeri');%ilgili başlığın grafiğe eklenmesi.
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
legend('|c-f|');%çizginin isimlendirilmesi
grid;
subplot(3,2,5);%g) şıkkı 4 numralı kısımın çizdirilmesi.
[t,y]=odeRK(odefun,[0 10],1,0.02);%d şıkkı 
newS3 = subs(S);%symbolik S(S=exp(t)) değerinin subs komutu ile t anındaki(h=0.02) değerlerinin newS3 değişkenine kaydedilemsi.
plot(t,abs(y-double(newS3)),'r-','linewidth',2);%d-f farkının mutlak değerinin çizdirlmesi.
title('Subplot 4: d-f farkının mutlak değeri')
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
legend('|d-f|');%çizginin isimlendirilmesi
grid;
subplot(3,2,6);%g) şıkkı 5 numralı kısımın çizdirilmesi.
[t,y]=ode45(odefun,[0 10],1); % e şıkkı 
news4 = subs(S);%symbolik S(S=exp(t)) değerinin subs komutu ile t anındaki değerlerinin newS4 değişkenine kaydedilemsi.
plot(t,abs(y-double(news4)),'r-','linewidth',2);%% symbolik S değerinin subs komutu ile
title('Subplot 5: e-f farkının mutlak değeri')%ilgili başlığın grafiğe eklenmesi.
xlabel('t');%x ekseninin isimlendirilmesi
ylabel('y(t)');%y ekseninin isimlendirilmesi
legend('|e-f|');%çizginin isimlendirilmesi
grid;