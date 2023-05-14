%ELE515 ÖDEV2 Doruk Bilgi 221211041
%SORU2-h)
%Lag Compansator
function C=fazGeriletici01(G,p,ess_d)
polesGtest = pole(G);
atest = polesGtest(2);%Girilen sistemin kutuplarının kontrol edilmesi.
if(atest>0)%~isstable(G). 
    error('Verilen sistemin sanal eksenin sağanda kutubu var, sistem kararsızdır.')%HATA (Verilen sistem kararsız.)
elseif(real(p)>0)
     error('Kapalı çevrim sistemi kutupları sanal eksenin solunda olmalıdır.')%HATA (Kapalı çevrim kutupları sanal eksenin solunda olmalıdır.)
else
s=tf('s');
polesG = pole(G);%Verilen "G" sistemi için kutupları polesG değişkenine kaydet.
a = polesG(2);%a değişkenine 0'dan farklı kutubu yerleştir.
b = polesG(1);%b değişkenine sıfır kutubunu yerleştir.
x = -real(p);%p kutbunun reel kısmının x değişkenine kaydedilmesi.
y = imag(p);%p kutbunun sanal kısmının y değişkenine kaydedilmesi.
K = (sqrt((-x-a)^2+y^2)*sqrt((-x+b)^2+y^2));%Kc için genlik koşulu hesaplanması.
[z,g]= zero(G);%C kontrolcüsü için bulunan K kazanç değeri G sisteminin kazanç değerine(g) bölünmeli.
Kc = K/g;%Kontrolcü kazancının G sisteminin kazancından ayrılması.
[Num,Den] = tfdata(G,'v');
syms u;%Limit ile Kv hesaplaması için "u" sembolik değişkeninin tanımlanması.
sys_syms=poly2sym(Num,u)/poly2sym(Den,u);%Limit hesabı için "sys_syms" değişkenine "G" transfer fonksiyonunun sembolik hali kaydedilmektedir. 
Kv = limit(u*Kc*sys_syms,u,0);%Limit ile Kv hesaplanması.
Kv = sym2poly(Kv);%sembolik olan Kv değişkeninin sayısal değere çevrilmesi.
% ess = 1/Kv;%Şimdilik ess bu değerde.
% disp(ess);
% disp(ess_d);
Kv_new = 1/ess_d;
beta = Kv_new/Kv; %Kv kaç katına çıksın = beta bulunması.
p_lag = 0.005;%Sıfıra çok yakın kutup seçilmesi.
z_lag = beta * p_lag;%Seçilen kutup ve bulunan beta değerlerine karşılık sıfırın hesaplanması.
C = Kc*((s+z_lag)/(s+p_lag));%Kc ve kutupların verilen formatta yerleştirilmesi
disp(C);
end