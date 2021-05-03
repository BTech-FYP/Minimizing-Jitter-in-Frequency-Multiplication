pkg load control;
s=tf("s");
Ip=500*10^-6; #harge pump current.Value chosen from behzad razavi ( 1-10uA)
Kpd=Ip/(2*pi);#ip/2pi
Kvco=10^9;#Behzad Razavi
R=10^5;
C=75*10^-12;
K=Kvco*Kpd/C;
Tref=50*10^-9;#input frequency 20MHz
N=200;
#Hnoise=tf([1 0 0],[1 50 50]);
Hnoise=tf([1 0 0],[1 K*R*C/200 K/200]);
Hclosed=tf([K*R*C K],[1 K*R*C/200 K/200]);
#JTF_1=s^2/((s-16e6)^2);
[mag1,phase,w1]=bode(Hnoise,{1,40e6});
for i=1:numel(w1)
  if w1(i)<=100
    psd_in_db_vco=0;
  end
  if 100<w1(i)<=10^6
    psd_in_db_vco(i)=60-log10(w1(i))*30;
   end
  if 10^6<w1(i)
    psd_in_db_vco(i)=-120-(log10(w1(i))-6)*20;
   end
   
end
psd_in_vco=10.^(psd_in_db_vco./10);
psd_in_ref=10^-14;
c=0;
#N= 210:2:270
#for a=1:numel(N)
##bodemag(JTF_1,{1,1e9});
  K_BW=500:100000:4000000
  for j=1:numel(K_BW)
    K=K_BW(j)/(R*C/N);
    Hclosed_JTF1=tf([K*R*C K],[1 K*R*C/N K/N]);
    Hnoise_JTF1=tf([1 0 0],[1 K*R*C/N K/N]);
    [mag1,phase,w]=bode(Hnoise_JTF1,{1,40e6});
    [mag2,phase,w]=bode(Hclosed_JTF1,{1,40e6});
    if numel(psd_in_vco)>=numel(mag1)
      d=numel(psd_in_vco)-numel(mag1');
      psd_out_vco=psd_in_vco(1:end-d).*(mag1'.^2);
    end
    if numel(psd_in_vco)<=numel(mag1)
      dd=-numel(psd_in_vco)+numel(mag1');
      psd_out_vco=psd_in_vco.*(mag1'(1:end-dd).^2);
    end
    #if numel(psd_in_vco)<numel(mag2)
     # psd_out_ref=psd_in_vco.*(mag2'(1:end-1).^2);
    #end
     #if numel(psd_in_vco)>numel(mag2)
      # psd_out_ref=psd_in_vco(1:end-1).*(mag2'.^2);
     #end
    psd_out_ref=psd_in_ref.*(mag2'.^2);
    P_rms_vco(j)=sum(psd_out_vco);
    P_rms_ref(j)=sum(psd_out_ref);
    A_rms_vco(j)=sqrt(P_rms_vco(j));
    A_rms_ref(j)=sqrt(P_rms_ref(j));
    P_rms_1(j)=P_rms_vco(j)+P_rms_ref(j);
    A_rms_11(j)=sqrt(P_rms_1(j));
   ## bodemag(Hclosed_JTF1,{1,1e9});
    hold on;
    #for l=1:numel(mag1)
    ##  if 10*log10(mag1(l))>=-3
    #    band_width_noise(j)=w(l);
     #   c++;
     #   break;
     #  end
   end
   # for b=1:numel(mag2)
    #  if 10*log10(mag2(b))>=-3
   #     band_width_ref(j)=w(l);
   #     c++;
   #     break;
   #    end
   # end
   # min_jitter_power = min(P_rms);
   # for p=1:numel(P_rms)
   #   if P_rms(p)== min_jitter_power
     #   min_index=p;
     #   PLL_BW_optimized(a)=K(p)*R*C/N(a);
     # end
   # end
