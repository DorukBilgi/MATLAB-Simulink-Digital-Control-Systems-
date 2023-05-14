function dx = five_wagon_system(t,x,u)
%Kütleler.(kg)
m1=300;
m2=200;
m3=100;
m4=300;
m5=500;
%Doğrusal olmayan yay formülü (Ki=ki*exp(xi)+ai*(xi^3)) için
%"k" ve "a" sabitleri.
k1=500;
k2=200;
k3=100;
k4=400;
k5=500;
k6=600;
a1=300;
a2=450;
a3=300;
a4=400;
a5=500;
a6=600;
%Doğrusal amortisör sabitleri.(N*s/m)
c1=300;
c2=200;
c3=100;
c4=400;
c5=550;
c6=250;
%Durum değişkenleri.(Yer değiştirme (m) ve hız (m/s))
x1=x(1);
x2=x(2);
x3=x(3);
x4=x(4);
x5=x(5);
x6=x(6);
x7=x(7);
x8=x(8);
x9=x(9);
x10=x(10);
%Durumların türevleri.
dx1=x2;
dx2=(u(1)/m1)-((c1+c2)*x2/m1)+c2*x4/m1-(((k1+k2)*exp(x1))/m1)+k1*exp(x3)/m1-(a2*x1^3)/m1+(a1*(x3-x1)^3)/m1;
dx3=x4;
dx4=(u(2)/m2)-((c2+c3)*x4/m2)+c2*x2/m2-(((k2+k3)*exp(x3))/m2)+k2*exp(x1)/m2-(a3*x3^3)/m2-(a2*(x3-x1)^3)/m2;
dx5=x6;
dx6=(u(3)/m3)-((c3+c4)*x6/m3)+c4*x4/m3-(((k3+k4)*exp(x5))/m3)+k3*exp(x3)/m3-(a4*x5^3)/m3+(a3*(x5-x3)^3)/m3;
dx7=x8;
dx8=(u(4)/m4)-((c4+c5)*x8/m4)+c4*x6/m4-(((k4+k5)*exp(x7))/m4)+k4*exp(x5)/m4-(a5*x7^3)/m4-(a4*(x7-x5)^3)/m4;
dx9=x10;
dx10=(u(5)/m5)-((c5+c6)*x10/m5)+c5*x8/m5-(((k5+k6)*exp(x9))/m5)+k5*exp(x7)/m5-(a6*x9^3)/m5+(a5*(x9-x7)^3)/m5;
dx=[dx1;dx2;dx3;dx4;dx5;dx6;dx7;dx8;dx9;dx10];