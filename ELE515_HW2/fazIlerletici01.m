%ELE515 ÖDEV2 Doruk Bilgi 221211041
%SORU2-g)
%Lead Compansator
function C=fazIlerletici01(G,p)
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
z_lead = -a; % Sıfırın yeri 0'dan farklı kutubun üstünde seçilmeli.
% Açı koşulu kullanarak kontrolcü kutubunun bulunması.
x = -real(p);%KÇTF kutubunun real kısmı.
y = imag(p);%KÇTF kutubunun imajiner kısmı.
h = 180 + (180 + atand(y/(b-x))) + atand(y/(-a-x))- 360;%Açı koşulu hesaplanması.
p_lead = y*tand(h)+x;%Açı eksiği kullanılarak p kutubunun yerinin hesaplanması.
% Genlik koşulu K kazanç değeri bulunması.
K = (sqrt((-x-a)^2+y^2)*sqrt((-x+b)^2+y^2)*sqrt((-x+p_lead)^2+y^2))/sqrt((-x+z_lead)^2+y^2);%Genlik koşulu hesaplanması.
[z,g]= zero(G);%C kontrolcüsü için bulunan K kazanç değeri G sisteminin kazanç değerine(g) bölünmeli.
K = K/g;%Kontrolcü kazancının G sisteminin kazancından ayrılması.
C = K*(s+z_lead)/(s+p_lead);%Faz ilerletici kontrolör "C" nin bulunması.
disp(C);%Tasarlanmış olan kontrolcünün komut ekranında gösterilmesi.
end
end
