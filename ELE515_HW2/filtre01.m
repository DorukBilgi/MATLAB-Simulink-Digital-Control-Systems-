%ELE515 ÖDEV2 Doruk Bilgi 221211041
%SORU1
function [b,a]=filtre01(fs,gecirmeFrekanslari,varargin)
if(~isa(fs,'double'))
  error('Örnekleme frekansı hatalı.')%HATA (Örnekleme frekansı hatalı.)
elseif(~isscalar(fs))
  error('Örnekleme frekansı hatalı.')%HATA (Örnekleme frekansı hatalı.)
end
fmax=(fs)/2;
if(gecirmeFrekanslari(1,1)==Inf)
     error('Geçirme frekansı vektörü hatalı.')%HATA (Geçirme frekansı vektörü hatalı.)
elseif(gecirmeFrekanslari(1,1)>=fmax)
     error('Maksimum frekanstan (%d Hz) büyük frekans olmamalı.',fmax)%HATA (Maksimum frekanstan büyük frekans olmamalı.)
elseif(gecirmeFrekanslari(1,2)==Inf)
     error('Geçirme frekansı vektörü hatalı.')%HATA (Geçirme frekansı vektörü hatalı.)
elseif(gecirmeFrekanslari(1,2)>=fmax)
     error('Maksimum frekanstan (%d Hz) büyük frekans olmamalı.',fmax)%HATA (Maksimum frekanstan büyük frekans olmamalı.)     
elseif(gecirmeFrekanslari(2,1)==Inf)
     error('Geçirme frekansı vektörü hatalı.') %HATA (Geçirme frekansı vektörü hatalı.)
elseif(gecirmeFrekanslari(2,1)>=fmax)
     error('Maksimum frekanstan (%d Hz) büyük frekans olmamalı.',fmax)%HATA (Maksimum frekanstan büyük frekans olmamalı.)   
elseif(gecirmeFrekanslari(2,2)==Inf)
     gecirmeFrekanslari(2,2) = fmax-1;%Inf girildiği durumda fmax = fs/2 alınmalıdır.
elseif(gecirmeFrekanslari(2,2)>=fmax)
     error('Maksimum frekanstan (%d Hz) büyük frekans olmamalı.',fmax)%HATA (Maksimum frekanstan büyük frekans olmamalı.)
end

   defaultdurtuTepkisiCizdir = false;%durtuTepkisiCizdir için default değer.
   defaultbodeCizdir = false;%bodeCizdir için ilk değer.
   defaultornekVer = false;%ornekVer için ilk değer.
   defaultornekSayisi = 0;%ornekSayisi için ilk değer.

   p = inputParser;%opsiyonel ve gerekli giriş parametreleri için inputParser komutu.
   p.KeepUnmatched=true;%Yanlış girilen argümanların tespiti için KeepUnmatched ayarının true olarak ayarlanması.
   validScalarFs = @(x) isvector(x);
   validScalarMatrix = @(x) ismatrix(x);
   %validLogic = @(x) islogical(x);
   validScalar = @(x) isscalar(x);
   
   addRequired(p,'fs',validScalarFs);
   addRequired(p,'gecirmeFrekanslari',validScalarMatrix);
   addOptional(p,'durtuTepkisiCizdir',defaultdurtuTepkisiCizdir);%Hemen ardından logic gelmeli.
   addOptional(p,'bodeCizdir',defaultbodeCizdir);%Hemen ardından logic gelmeli.
   addOptional(p,'ornekVer',defaultornekVer);%Hemen ardından logic gelmeli.
   addOptional(p,'ornekSayisi',defaultornekSayisi,validScalar);%Scalar gelecek sonrasında.
   parse(p,fs,gecirmeFrekanslari,varargin{:});
      
%   if(~ismember(varargin{:,1},p.UsingDefaults))
%     error('%s diye bir parametre yok.',varargin{:,1});
%   end

%     if(~isempty((p.Unmatched)))
%      disp(p.Unmatched,{1});
%     end
    
%     if(getfield(p.Unmatched,{1}))
%     error('%s diye bir parametre yok.',varargin{:,1});
%     end

   if(~islogical(p.Results.bodeCizdir))%bodeCizdir'den sonra girilen argümanın kontrol edilmesi.
       error('bodeCizdir parametresi true ya da false olmalı.')
   elseif(~islogical(p.Results.ornekVer))%ornekVer'den sonra girilen argümanın kontrol edilmesi.
       error('ornekVer parametresi true ya da false olmalı.')
   elseif(~islogical(p.Results.durtuTepkisiCizdir))%durtuTepkisiCizdir'den sonra girilen argümanın kontrol edilmesi.
       error('durtuTepkisiCizdir parametresi true ya da false olmalı.')     
   elseif(p.Results.ornekVer == defaultornekVer && p.Results.ornekSayisi ~= defaultornekSayisi)%ornekSayisi sonrasında girilen argümanın kontrol edilmesi ve bu argümanın ornekVer true ise girilmesi gerektiğinin kontrolü.
       error('ornekSayisi sadece ornekVer true olursa verilmeli.');
   end
   
% disp(gecirmeFrekanslari(1,:));%geçirme frekanslarını ekranda göster.
% disp(gecirmeFrekanslari(2,:));%geçirme frekanslarını ekranda göster.
Ts=1/fs;%Argüman olarak verilen fs için Örnekleme periyodu.   
% fc1=[gecirmeFrekanslari(1,1) gecirmeFrekanslari(1,2)];%1. passband
% fc2=[gecirmeFrekanslari(2,1) gecirmeFrekanslari(2,2)];%2. passband
fc3 = [gecirmeFrekanslari(1,2) gecirmeFrekanslari(2,1)];%Bu frekansları geçirme(stop-band).
N=7;%Filtre derecesi.
% wc1=2*pi*fc1;%radyan cinsinden kesim frekansı.
% wc2=2*pi*fc2;%radyan cinsinden kesim frekansı.
wc3=2*pi*fc3;%radyan cinsinden kesim frekansı.
ws=2*pi*fs;%radyan cinsinden örnekleme frekansı.
wmax = ws/2;%radyan cinsinden maksimum frekans.
% wn1 = wc1/wmax;%radyan cinsinden normalize kesim frekansı.
% wn2 = wc2/wmax;%radyan cinsinden normalize kesim frekansı.
wn3 = wc3/wmax;%radyan cinsinden normalize kesim frekansı.
% [num1,den1]=butter(N,wn1,'bandpass');
% [num2,den2]=butter(N,wn2,'bandpass');
[num,den]=butter(N,wn3,'stop');%wn3 aralığının bastırılması için filtre katsayılarının bulunması.
% H1=dfilt.df2t(num1,den1);%birinci passband için filtre
% H2=dfilt.df2t(num2,den2);%ikinci passband için filtre
% Hcas=dfilt.parallel(H1,H2);%cascade yöntemi ile iki aralık için verilen
% iki farklı filtrenin birleştirilmesi.(dual-band)

% b = Hcas.Stage.Numerator; %filtrenin pay kısmı katsayısı
% a = Hcas.Stage.Denominator; %filtrenin payda kısmı katsayısı

% tf1=tf(num1,den1,Ts);%birinci passband için filtrenin transfer fonksiyonu.
% tf2=tf(num2,den2,Ts);%ikinci passband için filtrenin transfer fonksiyonu.
% tf3=tf1*tf2;%iki farklı filtrenin H1(s)*H2(s) konvolüsyon birleştirilmesi.(dual-band)
tf_filtre = tf(num,den);%Filtrenin transfer fonksiyonunun oluşturulması.
[b,a] = tfdata(tf_filtre,'v');%[b,a] tek bir filtre katsayısı olmalı ve en sonda birleşmeli.

% G1=filt(num1,den1,Ts);
% G2=filt(num2,den2,Ts);
% G1G2=series(G1,G2);
% G1G2 = zpk(G1)*zpk(G2);
% [b,a] = tfdata(G1G2,'v');

if(p.Results.durtuTepkisiCizdir)%durtuTepkisiCizdir'den sonraki argüman "true" ise
  figure;
  impulse(tf(num,den,Ts));%Filtrenin dürtü tepkisini çizdir.
  grid;
end
if(p.Results.bodeCizdir)%bodeCizdir'den sonraki argüman "true" ise
   %Bode options ayarlanması.
   opts = bodeoptions;
   %opts.Title.String = 'Bode Plot of Transfer Function of Designed Filter';
   opts.FreqUnits = 'Hz';
   opts.PhaseWrapping = 'on';%-180,180 aralığında faz değerlerinin gösterilmesi için gerekli ayarlamanın yapılması.
   figure;
   bodeplot(tf_filtre,opts);%Filtrenin bode diagramını bodeoptions argümanı ile çizdir.
   grid;
end
if(p.Results.ornekVer)%ornekVer "true" ise 
  if(p.Results.ornekSayisi~=defaultornekSayisi)%"ornekSayisi","ornekVer"true girildikten sonra girildiyse artık değeri default değildir.
      Ts=1/fs;%örnekleme periyodu.
      fu=linspace(0,0,p.Results.ornekSayisi);%N tane rastgele frekans için boş vektor oluşturulması.
      for i=1:p.Results.ornekSayisi%N tane rastgele frekans seçilmeli.
        fu(i)=1000*rand(1,1);%rastgele bir "fu" seç.
        t=0:Ts:500/fu(i);%t,"zaman" değişkeninin oluşturulması.
        u=sin(2*pi*fu(i)*t);%u, sinüs giriş sinyalinin oluşturulması.
        y=filter(b,a,u);%Elde edilen filtre katsayıları ile giriş sinyalinin filtrelenmesi ve y değişkenine kaydedilmesi.
        [mag,phase]=bode(tf_filtre,fu(i));%Filtrenin fu frekansında bode mag ve bode phase değerlerinin bulunması.
        figure;
        plot(t,u,t,y);%giriş ve çıkış sinyallerinin çizdirilmesi.
        title([num2str(fu(i)),' Hz için filtre genliği ',num2str(20*log10(mag)),' dB ve fazı ',num2str(phase),char(176)]);%char(176) ile derece sembolünün kullanılması. num2str ile değerlerin başlığa eklenmesi.
        xlabel('t(s)');%x ekseninin isimlendirilmesi.
        ylabel('Genlik');%y ekseninin isimlendirilmesi.
        xlim([0 0.25]);%x ekseni için limit.
        legend('giriş','çıkış');%sinyallerin isimlendirilmesi.
      end
   else
   Ts=1/fs;%örnekleme periyodu.
   fu=1000*rand(1,1);%rastgele bir "fu" seç.
   t=0:Ts:500/fu;%t, "zaman" değişkeninin oluşturulması.
   u=sin(2*pi*fu*t);%Rastgele seçilmiş olan "fu" frekansında genliği 1 olan sinüs sinyali.
   y=filter(b,a,u);%Elde edilen filtre katsayıları ile giriş sinyalinin filtrelenmesi ve y değişkenine kaydedilmesi.
   [mag,phase] = bode(tf_filtre,fu);%Filtrenin fu frekansında bode mag ve bode phase değerlerinin bulunması.
   figure;
   plot(t,u,t,y);%giriş ve çıkış sinyallerinin çizdirilmesi. 
   title([num2str(fu),' Hz için filtre genliği ',num2str(20*log10(mag)),' dB ve fazı ',num2str(phase),char(176)]);%char(176) ile derece sembolünün kullanılması. num2str ile değerlerin başlığa eklenmesi. 
   xlabel('t(s)');%x ekseninin isimlendirilmesi.
   ylabel('Genlik');%y ekseninin isimlendirilmesi.
   xlim([0 0.25]);%x ekseni için limit.
   legend('giriş','çıkış');%sinyallerin isimlendirilmesi.
  end
end
end