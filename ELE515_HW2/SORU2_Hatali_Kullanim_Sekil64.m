%ELE515 ÖDEV2 Doruk Bilgi 221211041
close all;
clear all;
clc;
%SORU2-a)
s=tf('s');%Sürekli zaman transfer fonksiyonu "s" ifadesinin tf komutu ile tanımlanması.
G1=1/(s*(s+2));%G(s) sistemi.
%G1_stable=isstable(G1);%"isstable" komutu ile G(s) sistemi kararsiz.
rlocus(G1);%G1 için kök yer eğrisi çizdirilmesi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.
C_a=2.04;%C(S)=K (P-kontrolcü) 0.7 sönüm oranı için kapalı çevrim sistemi kararlı yapacak olan 2.04 "K" değeri rootlocus komutu yardımıyla bulunmuştur.
Gcl_a=feedback(G1*C_a,1);%Kapali cevrim sisteminin feedback komutu ile elde edilmesi ve "Gcl_a" ya kaydedilmesi. (KÇTF = C(s)*G(s)/(1+C(s)*G(s)))
%Gcl_stable=isstable(Gcl_a);%"isstable" komutu ile Gcl_a kararli(aslında sınırda kararlı.).
%figure;
%rlocus(Gcl_a);%Gcl_a için kök yer eğrisi çizdirilmesi.
%grid;
%s1,2 = -zeta*wn +- j*wn*(1-zeta^2)^(1/2)
%s1,2 = -attenuation +- wd
[wn_a,zeta_a,p_a] = damp(Gcl_a);%doğal frekans wn, sönüm oranı zeta ve kutupların damp fonksiyonu ile bulunması.
%P = pole(Gcl_a);% Gcl kutuplarının pole komutu ile bulunması.
%wn_a = sqrt(2.04); % Gcl doğal frekans bulunması. Gcl = 2.04/(s^2 + 2s+ 2.04)
%wd_a = wn_a.*sqrt(1-zeta_a.^2)*i;%sönümlü doğal frekansın bulunması.
attenuation_a = zeta_a.*wn_a;%zayıflatma değerinin bulunması.
wd_a = sqrt(attenuation_a.^2-wn_a.^2);%sönümlü doğal frekansın bulunması.
figure;
step(Gcl_a);%Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
title('Birim basamak cevabı Soru2-a)');%İlgili başlığın grafiğe eklenmesi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.
t = 0:0.1:100;
u = t;%Rampa fonksiyonu x(t) = t.
[y,t] = lsim(Gcl_a,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapali cevrim birim rampa cevabini kirmizi cizdir.
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%rampa fonksiyonu x(t)=t.
xlabel('Time (sec)');%x ekseni isimlendir.
ylabel('Amplitude');%y ekseni isimlendir.
title('Birim rampa cevabı Soru2-a)');%İlgili başlığın grafiğe eklenmesi.
%axis([0 25 0 25]);%Grafigin anlasilabilmesi icin gerekli eksen limitlerinin ayarlanmasi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.

%SORU2-b)
%"G1" sisteminin kok yer egrisi incelendiginde kapali cevrim sisteminin
%kutuplari -2+-2j'de olabilecek bir P-Kontrolcu (C(s) = K) tasarlanamaz,
%belirtilen kutuplar "G1" sisteminin kok yer egrisi uzerinde degildir. Bu
%tasarim "faz ilerletici" (Lead Compansator) kontrol yontemi kullanilarak yapilabilir.
%sisotool(G1);%Yeni bir "C" kontrolcu blogunun "sisotool" ile -2+-2j'de kutuplar olacak sekilde ayarlanarak blogun transfer fonksiyonunun export edilmesi.
C_b = 0.0014544/(s^2 + 4*s + 8);%export edilen transfer fonksiyou "C"' nin "C_b" degiskenine kaydedilmesi. 
Gcl_b=feedback(G1*C_b,1);%Kapali cevrim sisteminin feedback komutu ile elde edilmesi ve "Gcl_b" ye kaydedilmesi. (KÇTF = C(s)*G(s)/(1+C(s)*G(s)))
figure;
rlocus(Gcl_b);%"Gcl_b" için yeni kök yer eğrisinin çizdirilmesi.
grid;
%figure;
%pzmap(Gcl_b);%"pzmap" komutu ile de kutuplarin -2+-2j'de oldugu gozlemlenmistir. 
%newP=pole(Gcl_b);%"Gcl"nin yeni kutuplarinin "newP" degiskenine kaydedilmesi.
[wn_b,zeta_b,p_b] = damp(Gcl_b);%doğal frekans wn_b, sönüm oranı zeta_b ve kutupların damp fonksiyonu ile bulunması.
attenuation_b = zeta_b.*wn_b;%zayıflatma değerinin bulunması.
wd_b = sqrt(attenuation_b.^2-wn_b.^2);%sönümlü doğal frekansın bulunması.
figure;
step(Gcl_b);%Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
title('Birim basamak cevabı Soru2-b)');%İlgili başlığın grafiğe eklenmesi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.
t = 0:0.1:10e3;%zaman ekseninin ayarlanmasi. ess'nin daha rahat gozlemlenebilmesi icin 10e3 secilmistir.
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_b,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapali cevrim birim rampa cevabini kirmizi cizdir.
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim rampa cevabı Soru2-b)');%İlgili başlığın grafiğe eklenmesi.
%axis([0 4500 0 4500]);%Grafigin anlasilabilmesi icin gerekli eksen limitlerinin ayarlanmasi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.

%SORU2-c)
%e(inf)=1/Kv=0.1 isteniyor. s*G(s)'nin s, 0'a giderken ki limiti K/2'dir ve
%buradan da K yani P-kontrolcu 20 degerinde secilecek olursa birim rampa
%referans takip hatasi 0.1 olmaktadir fakat soruda bu degerin 0.1'den
%kucuk olmasi ve zeta degerinin 0.7 olmasi istenmektedir. "a" seceneginde
%zeta = 0.7 icin K degeri 2.04 olarak kok yer egrisinden bulunmustu fakat
%bu durumda sistemin birim rampa referans takip hatasi "1" olarak
%hesaplanmaktadir. Bu degerin zeta=0.7 degeri ile birlikte 0.1'den kucuk
%secilebilmesi P-kontrolcu ile mumkun degildir. Bu durumda "faz geriletici"
%kontrolor kullanilmalidir. C(s) = K yerine C(s) = K*(s+z)/(s+p) tipinde bir 
%kontrolcu secilmeli. zeta=0.7'yi degistirmeden ess=1 degerini ess=0.01(0.1'den kucuk)
%1/100 katina getirme islemi yapilmalidir. ess=1/Kv=0.01 isleminden Kv'nin
%100 katına çıkması gerektigi hesaplanmistir. -p=-0.001 ve -z=(100)*-p=-0.1 değerleri seçilmeli, K = 2.04
%degerini degistirmeden zeta=0.7'yi saglayacak sekilde C(s)=2.04*(s+0.1)/(s+0.001) kontrolcu kullanabiliriz.

% C_c = 20;%Bu asamada K=20 degeri icin birim rampa referans takip hatasi incelenmektedir. Takip hatasi 0.1'den kucuktur fakat zeta 0.7 degildir.
% Gcl_c = feedback(G1*C_c,1);
% t = 0:0.1:100;%zaman ekseninin ayarlanmasi(0.1 adim araliklari ile "ess" rahatlikla gorulebilmektedir).
% u = t;%rampa fonksiyonu x(t)=t.
% [y,t] = lsim(Gcl_c,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
% figure;
% plot(t,y,'r');%Birim rampa kirmizi cizdir.
% hold on;
% plot(t,u,'b');%Birim rampa mavi cizdir.
% legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
% xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
% ylabel('Amplitude');%y ekseninin isimlendirilmesi.
% title('Birim Rampa Referans Takip Hatasi Analizi K = 20, ess = 0.1, zeta =/ 0.7');%Ilgili basligin grafige eklenmesi.
% grid;
% 
% C_c = 2.04;%Bu asamada K=2.04 degeri icin birim rampa referans takip hatasi incelenmektedir. 
% Gcl_c = feedback(G1*C_c,1);
% t = 0:1:100;%zaman ekseninin ayarlanmasi(1 adim araliklari ile "ess" rahatlikla gorulebilmektedir).
% u = t;%rampa fonksiyonu x(t)=t.
% [y,t] = lsim(Gcl_c,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
% figure;
% plot(t,y,'r');%Birim rampa kirmizi cizdir.
% hold on;
% plot(t,u,'b');%Birim rampa mavi cizdir.
% legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
% xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
% ylabel('Amplitude');%y ekseninin isimlendirilmesi.
% title('Birim Rampa Referans Takip Hatasi Analizi K = 2.04, ess= 1, zeta = 0.7');%Ilgili basligin grafige eklenmesi.
% grid;

C_c = 2.04*(s+0.1)/(s+0.001);%Bu asamada C(s)=2.04*(s+0.5)/(s+0.005) icin birim rampa referans takip hatasi incelenmektedir. 
Gcl_c = feedback(G1*C_c,1);%Kapali cevrim sisteminin feedback komutu ile elde edilmesi ve "Gcl" ye kaydedilmesi. (KÇTF = C(s)*G(s)/(1+C(s)*G(s)))
figure;
step(Gcl_c);%Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
title('Birim basamak cevabı Soru2-c');
%isstable(Gcl_c); %Kapali cevrim kararli
%figure;
%rlocus(Gcl_c);
%grid;
[wn_c,zeta_c,p_c] = damp(Gcl_c);%doğal frekans wn_c, sönüm oranı zeta_c ve kutupların damp fonksiyonu ile bulunması.
attenuation_c = zeta_c.*wn_c;%zayıflatma değerinin bulunması.
wd_c = sqrt(attenuation_c.^2-wn_c.^2);%sönümlü doğal frekansın bulunması.
t = 0:0.01:100;%zaman ekseninin ayarlanmasi(0.01 adim araliklari ile "ess" rahatlikla gorulebilmektedir).
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_c,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapali cevrim birim rampa cevabini kirmizi cizdir.
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim Rampa Cevabı C(s) = 2.04*(s+0.1)/(s+0.001), ess= 0.01, zeta = 0.7 Soru 2-c)');%Ilgili basligin grafige eklenmesi.
grid;

%SORU2-d)
G2=1/(s*(s-1));%G(s) sisteminin tanımlanması.
%G2_stable=isstable(G2);%"isstable" komutu ile G(s) sistemi kararsiz.
figure;
rlocus(G2);%G2 için kök yer eğrisi çizdirilmesi.
grid;
%Kararlı yapılamıyor sistem kararsız. Sistemin kutupları sanal eksenin sağında bulunmaktadır.
C_d=5;%K=1. Direkt olarak G(s)nin kapalı cevrim sistemi oluşturulmuştur ve bu sistemin birim basamak/rampa cevabı çizdirilmiştir.
Gcl_d=feedback(G2*C_d,1);%Kapali cevrim sisteminin "feedback" komutu ile elde edilmesi ve "Gcl_d" ye kaydedilmesi. (KÇTF = G(s)/(1+G(s)))
%Gcl_d_stable=isstable(Gcl_d);%"isstable" komutu ile Gcl_d "kararsiz".
%Kapali cevrim sistemini kararli yapacak ve sonum orani 0.7 olacak sekilde
%bir P-kontrolcu tasarlanamaz. G(s)'nin s=1'de kutubu vardır. Sistem kararsızdır. Dolayısıyla zeta < 0 'dır. Kapali cevrim sisteminin kok yer egrisi
%incelendiginde -0.7 sonum orani icin -0.51 kazanc degeri P-kontrolcu olarak
%denenmistir fakat elde edilen kapali cevrim sistemi yine kararsizdir. 0.51 P-
%kontrolcu ile 0.7 sonum oraninda kapali cevrim sistemi kararli
%yapilamamaktadir. Bu tasarım P-kontrolcü ile yapılamaz.
%(KÇTF = G(s)/(1+G(s)))'nin birim basamak ve rampa cevabının çizdirilmesi.
figure;
step(Gcl_d);%Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
title('Birim basamak cevabı Soru2-d)');%Ilgili başlığın grafiğe eklenmesi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.
t = 0:0.1:100;%zaman ekseninin ayarlanmasi.
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_d,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapalı çevrim sistemi birim rampa cevabı kirmizi cizdir.
ylim([0 100]);
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim rampa cevabı Soru2-d)');%Ilgili basligin grafige eklenmesi.
grid;

%SORU2-e)
%"G2" sisteminin kok yer egrisi incelendiginde kapali cevrim sisteminin
%kutuplari -2+-2j'de olabilecek bir P-Kontrolcu (C(s) = K) tasarlanamaz,
%belirtilen kutuplar "G2" sisteminin kok yer egrisi uzerinde degildir.
%"faz ilerletici" (Lead Compansator) kontrol yontemi kullanilarak
%egrinin belirtilen noktalardan gecme islemi saglanmis olsa da bu asamada
%"G2"nin imajiner eksenin saginda(s=1) kutubu olmasi sebebiyle kapali
%cevrim sistemi kararli hale getirilememektedir, sistemde noktaklar eğri üzerinde olsa bile sistem kararsızdır. "sisotool" ile kapali cevrim 
%sisteminin kok yer egrisinin bu noktalardan gececek sekilde ve sönüm oranı 0.7 olacak şekilde C(s)=0.0007569/(s^2 + 4*s + 8)
%tasarlanmistir fakat kapali cevrim sistemi kararli hale getirilememektedir.
%(Compansator tasarimina Real-zero eklenerek +1 noktasindaki kutup
%giderilmeye calisilmistir ve aynı zamanda bu duruma ek olarak eğrinin istenilen
%noktalardan geçmesi için C(s)=0.000841*(s-1)/(s^2 + 4*s + 8)
%tasarlanmıştır fakat sistem yine kararlı hale getirilememiştir.
%sisotool(G2);%Yeni bir "C" kontrolcu blogunun "sisotool" ile -2+-2j'de kutuplar olacak sekilde ayarlanarak blogun transfer fonksiyonunun export edilmesi.
C_e = 0.0007569/(s^2 + 4*s + 8);%export edilen transfer fonksiyou "C"' nin "C_e" degiskenine kaydedilmesi. 
Gcl_e=feedback(G2*C_e,1);%Kapali cevrim sisteminin feedback komutu ile elde edilmesi ve "Gcl_e" ye kaydedilmesi. (KÇTF = C(s)*G(s)/(1+C(s)*G(s)))
figure;
rlocus(Gcl_e);%"Gcl_e" için yeni kök yer eğrisinin çizdirilmesi.
grid;
%Sistemin istenilen eğrilerden geçebildiği fakat kararlı hale
%getirilemediği C(s) = 0.0007569/(s^2 + 4*s + 8)'ye göre
%tasarlanmış kapalı çevrim sisteminin birim basamak/rampa cevapları incelendiğinde anlaşılmkatadır. 
figure;
step(Gcl_e);%Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
xlim([0 100]);%x ekseni icin kisitlama.
title('Birim basamak cevabı Soru2-e)');%İlgili başlığın grafiğe eklenmesi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.
t = 0:0.1:100;%zaman ekseninin ayarlanmasi(0.01 adim araliklari ile "ess" rahatlikla gorulebilmektedir).
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_e,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapali cevrim birim rampa cevabini kirmizi cizdir.
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
ylim([0 100]);%y ekseni icin kisitlama.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim rampa cevabı Soru2-e)');%İlgili başlığın grafiğe eklenmesi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.

C_e = 0.000841*(s-1)/(s^2 + 4*s + 8);%export edilen transfer fonksiyou "C"' nin "C_e" degiskenine kaydedilmesi. 
Gcl_e=feedback(G2*C_e,1);%Kapali cevrim sisteminin feedback komutu ile elde edilmesi ve "Gcl_e" ye kaydedilmesi. (KÇTF = C(s)*G(s)/(1+C(s)*G(s)))
figure;
rlocus(Gcl_e);%"Gcl_e" için yeni kök yer eğrisinin çizdirilmesi.
grid;
%Sistemin istenilen eğrilerden geçebildiği fakat kararlı hale
%getirilemediği C(s) = 0.0007569/(s^2 + 4*s + 8)'ye göre
%tasarlanmış kapalı çevrim sisteminin birim basamak/rampa cevapları incelendiğinde anlaşılmkatadır. 
figure;
step(Gcl_e);%Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
xlim([0 100]);%x ekseni icin kisitlama.
title('Birim basamak cevabı Soru2-e)');%İlgili başlığın grafiğe eklenmesi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.
t = 0:0.1:100;%zaman ekseninin ayarlanmasi(0.01 adim araliklari ile "ess" rahatlikla gorulebilmektedir).
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_e,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapali cevrim birim rampa cevabini kirmizi cizdir.
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
ylim([0 100]);%y ekseni icin kisitlama.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim rampa cevabı Soru2-e)');%İlgili başlığın grafiğe eklenmesi.
grid;%grid komutu ile degerler daha net anlasilabilmektedir.


%SORU2-f)
%d) şıkkında da bahsedildiği üzere kapali cevrim sistemini kararli yapacak ve sonum orani 0.7 olacak sekilde
%bir P-kontrolcu tasarlanamaz. G(s)'nin s=1'de kutubu vardır. Sistem kararsızdır. Dolayısıyla zeta < 0 'dır. Kapali cevrim sisteminin kok yer egrisi
%incelendiginde -0.7 sonum orani icin -0.51 kazanc degeri P-kontrolcu olarak
%denenmistir fakat elde edilen kapali cevrim sistemi yine kararsizdir. 0.51 P-
%kontrolcu ile 0.7 sonum oraninda kapali cevrim sistemi kararli
%yapilamamaktadir. Bu tasarım P-kontrolcü ile yapılamaz. 
%Sorunun c) şıkkında kullanılan faz geriletici kontrolcüsüne benzer bir faz geriletici kontrolcü C(s)=0.51*(s+0.1)/(s+0.001)  
%f) şıkkı için denenmiş olup, kapalı çevrim sisteminin birim basamak/rampa
%cevapları incelenmiştir. Sonuç olarak P kontrolcu, faz ilerletici veya faz geriletici kontrolculer ile bu kapali
%cevrim sistemi kararli yapilamaz. 

%P kontrolcü ile bu tasarımın yapılamadığı açıktır.
C_f = 0.51;%Bu asamada K=0.51 degeri icin birim rampa referans takip hatasi incelenmektedir.(Kök yer eğrisi incelendiğinde K=0.51 değeri zeta = -0.7'ye göre seçilmiştir.) 
Gcl_f = feedback(G2*C_f,1);
figure;
step(Gcl_f);%Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
t = 0:0.1:100;%zaman ekseninin ayarlanmasi.
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_f,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapalı çevrim sistemi birim rampa cevabı kirmizi cizdir.
ylim([0 100]);
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim Rampa Referans Takip Hatasi Analizi (C(s)=0.51)');%Ilgili basligin grafige eklenmesi.
grid;
%Faz geriletici kontrolcü ile yapılamadığı açıktır.
C_f = 0.51*(s+0.1)/(s+0.001);%Bu asamada C(s)=0.51*(s+0.1)/(s+0.001) icin birim rampa referans takip hatasi incelenmektedir. 
Gcl_f = feedback(G2*C_f,1);%Kapali cevrim sisteminin feedback komutu ile elde edilmesi ve "Gcl" ye kaydedilmesi. (KÇTF = C(s)*G(s)/(1+C(s)*G(s)))
figure;
step(Gcl_f);%Kapalı çevrim sisteminin birim basamak cevabının çizdirilmesi.
%isstable(Gcl_f); %Kapali cevrim kararsız.
t = 0:0.01:100;%zaman ekseninin ayarlanmasi(0.01 adim araliklari ile "ess" rahatlikla gorulebilmektedir).
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_f,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapali cevrim birim rampa cevabini kirmizi cizdir.
ylim([0 100]);
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim Rampa Referans Takip Hatasi Analizi (C(s)=0.51*(s+0.1)/(s+0.001))');%Ilgili basligin grafige eklenmesi.
grid;

%SORU2-g)
%b şıkkı için faz ilerletici bir kontrolcü tasarlamak için aşağıdaki
%komutlar kullanılmıştır.
G = 1/(s*(s+2));%G1 sistemi.
p = -2+2j;%Kapalı çevrim sistemi kutuplarından birinin olması istenen yer.
C = fazIlerletici01(G, p);%fazIlerletici01 fonksiyonu kullanımı.
Gcl_g=feedback(C*G,1);%Kapalı çevrim sisteminin oluşturulması.
figure;
rlocus(Gcl_g);%Kapalı çevrim sistemi için kök yer eğrisinin çizdirilmesi.
%zetanın p1,2 = -zeta*wn +- j*wn*(1-zeta^2)^(1/2) formülünden hesaplanması.
x = -real(p);
y = imag(p);
wn = sqrt(y^2 + x^2);
zeta = x/wn;
grid;
hold on;
%p1 ve sönüm oranı zetanın kök yer eğrisi üzerinde gösterilmesi.
n = 0:1:160; m = n*sqrt(zeta^2/(1-zeta^2));
plot (-m,n,'--');
plot (-x,y,'rd');
%SORU2-g) için ders videosundaki sistem için fonksiyonun kullanılması.
G = 4/(s*(s+2));%G2 sistemi.
p = -2+2*sqrt(3)*1i;%Kapalı çevrim sistemi kutuplarından birinin olması istenen yer.
C = fazIlerletici01(G, p);%fazIlerletici01 fonksiyonu kullanımı.
Gcl_g=feedback(C*G,1);%Kapalı çevrim sisteminin oluşturulması.
figure;
rlocus(Gcl_g);%Kapalı çevrim sistemi için kök yer eğrisinin çizdirilmesi.
%zetanın p1,2 = -zeta*wn +- j*wn*(1-zeta^2)^(1/2) formülünden hesaplanması.
x = -real(p); 
y = imag(p);
wn = sqrt(y^2 + x^2);
zeta = x/wn;
grid;
hold on;
%p1 ve sönüm oranı zetanın kök yer eğrisi üzerinde gösterilmesi.
n = 0:1:160; m = n*sqrt(zeta^2/(1-zeta^2));
plot (-m,n,'--');
plot (-x,y,'rd');
%SORU2-g) için başka bir örnek.
G = 7/(s*(s+1));%G3 sistemi.
p = -1+4.3i;%Kapalı çevrim sistemi kutuplarından birinin olması istenen yer.
C = fazIlerletici01(G, p);%fazIlerletici01 fonksiyonu kullanımı.
Gcl_g=feedback(C*G,1);%Kapalı çevrim sisteminin oluşturulması.
figure;
rlocus(Gcl_g);%Kapalı çevrim sistemi için kök yer eğrisinin çizdirilmesi.
%zetanın p1,2 = -zeta*wn +- j*wn*(1-zeta^2)^(1/2) formülünden hesaplanması.
x = -real(p); 
y = imag(p);
wn = sqrt(y^2 + x^2);
zeta = x/wn;
grid;
hold on;
%p1 ve sönüm oranı zetanın kök yer eğrisi üzerinde gösterilmesi.
n = 0:1:160; m = n*sqrt(zeta^2/(1-zeta^2));
plot (-m,n,'--');
plot (-x,y,'rd');
%SORU2-g) için hatalı kullanımlara birer örnek.
% G = 1/(s*(s-1));%G3 sistemi.
% p = -2+2i;%Kapalı çevrim sistemi kutuplarından birinin olması istenen yer.
% C = fazIlerletici01(G, p);%fazIlerletici01 fonksiyonu kullanımı.
% G = 1/(s*(s+1));%G3 sistemi.
% p = 10+2i;%Kapalı çevrim sistemi kutuplarından birinin olması istenen yer.
% C = fazIlerletici01(G, p);%fazIlerletici01 fonksiyonu kullanımı.

%SORU2-h)
%c şıkkı için faz geriletici bir kontrolcü tasarlamak için aşağıdaki
%komutlar kullanılmıştır.
G = 1/(s*(s+2));
ess_d = 0.01;
p = -1+1.02j;% "G" sisteminin kök yer eğrisi üzerinden 0.7 sönüm oranına denk gelecek şekilde kutup seçilmesi. Kontrolcü kazancı 2.04 olacaktır.
C=fazGeriletici01(G,p,ess_d);
Gcl_h = feedback(C*G,1);
t = 0:0.01:100;%zaman ekseninin ayarlanmasi(0.01 adim araliklari ile "ess" rahatlikla gorulebilmektedir).
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_h,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapali cevrim birim rampa cevabini kirmizi cizdir.
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim Rampa Cevabı 2-h)');%Ilgili basligin grafige eklenmesi.
grid;
%SORU2-h) için başka bir örnek.
G = 8/(s*(s+10));
ess_d = 0.2;
p = -10+4j;
C=fazGeriletici01(G,p,ess_d);
Gcl_h = feedback(C*G,1);
t = 0:0.01:100;%zaman ekseninin ayarlanmasi(0.01 adim araliklari ile "ess" rahatlikla gorulebilmektedir).
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_h,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapali cevrim birim rampa cevabini kirmizi cizdir.
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim Rampa Cevabı 2-h)');%Ilgili basligin grafige eklenmesi.
grid;
%SORU2-h) için başka bir örnek.
G = 1/(s*(s+2));
ess_d = 0.89;
p = -1+1j;
C=fazGeriletici01(G,p,ess_d);
Gcl_h = feedback(C*G,1);
t = 0:0.01:100;%zaman ekseninin ayarlanmasi(0.01 adim araliklari ile "ess" rahatlikla gorulebilmektedir).
u = t;%rampa fonksiyonu x(t)=t.
[y,t] = lsim(Gcl_h,u,t);%kapali cevrim sistemi birim rampa cevabini "y" degerine kaydet.
figure;
plot(t,y,'r');%Kapali cevrim birim rampa cevabini kirmizi cizdir.
hold on;
plot(t,u,'b');%Birim rampa mavi cizdir.
legend('Sistemin Birim Rampa Cevabi','Birim Rampa');%Egrilerin isimlendirilmesi.
xlabel('Time (sec)');%x ekseninin isimlendirilmesi.
ylabel('Amplitude');%y ekseninin isimlendirilmesi.
title('Birim Rampa Cevabı 2-h)');%Ilgili basligin grafige eklenmesi.
grid;
%SORU2-h) için hatalı kullanımlara birer örnek.
% G = 1/(s*(s-1));%G3 sistemi.
% p = -2+2i;%Kapalı çevrim sistemi kutuplarından birinin olması istenen yer.
% ess_d = 0.01;
% C = fazGeriletici01(G, p, ess_d);%fazIlerletici01 fonksiyonu kullanımı.
G = 1/(s*(s+1));%G3 sistemi.
p = 10+2i;%Kapalı çevrim sistemi kutuplarından birinin olması istenen yer.
ess_d = 0.01;
C = fazGeriletici01(G, p, ess_d);%fazIlerletici01 fonksiyonu kullanımı.