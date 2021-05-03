Ip=200e-6;
Kpd=Ip/(2*pi);
Kvco=1e7;
R=1e3;
C_PLL=200e-12;;
M=600;
K=Kpd*Kvco/C_PLL;
K_BW=K*R*C_PLL/M;
Tref=50*10^-9;
H_ref_to_out_pll_1=(K*(s*C_PLL*R+1))/(s^2+K*(s*C_PLL*R/M+1/M));
H_vco_noise_to_pll_out=(s^2/(s^2+K*R*C_PLL*s/M+K/M))
JTF_1=s^2/((s-4e6)^2);
JTF_2=s^2/((s-8e6)^2);
JTF_3=s^2/((s-16e6)^2);
mag1=bodemag(JTF_1,{1,40e6});
mag2=bodemag(JTF_2,{1,40e6});
mag3=bodemag(JTF_3,{1,40e6});
[mag phase w]=bode(H_ref_to_out_pll_1,{1,40e6});
for i=1:numel(w)
  if w(i)<=100
    psd_in_db_vco=0;
  end
  if 100<w(i)<=10^6
    psd_in_db_vco(i)=60-log10(w(i))*30;
   end
  if 10^6<w(i)
    psd_in_db_vco(i)=-120-(log10(w(i))-6)*20;
   end 
end
psd_in_vco=10.^(psd_in_db_vco./10);
psd_in_ref=10^-14;
 K_BW=10000:5000:3e5;
 for n=1:numel(K_BW)
   K=K_BW(n)/(R*C_PLL/M);
   H_ref_to_out_pll_1=(K*(s*C_PLL*R+1))/(s^2+K*(s*C_PLL*R/M+1/M));
   H_PLL_JTF_1_ref_out=H_ref_to_out_pll_1*JTF_1;
   H_PLL_JTF_1_VCO_OUT=H_vco_noise_to_pll_out*JTF_1;
   mag_vco_output=bodemag(H_PLL_JTF_1_VCO_OUT,{1,40e6});
   mag_ref_output=bodemag(H_PLL_JTF_1_ref_out,{1,40e6});
   if(numel(mag_vco_output)>=numel(psd_in_vco))
     d=numel(mag_vco_output)-numel(psd_in_vco);
     psd_out_vco_jtf_1=psd_in_vco.*mag_vco_output'(1:end-d).^2;
    end
    if(numel(mag_vco_output)<=numel(psd_in_vco))
     d1=-numel(mag_vco_output)+numel(psd_in_vco);
     psd_out_vco_jtf_1=psd_in_vco(1:end-d1).*mag_vco_output'.^2;
    end
    psd_out_ref_jtf_1=psd_in_ref.*mag_ref_output'.^2;
    if(numel(psd_out_vco_jtf_1)<=numel(psd_out_ref_jtf_1))
     dd=numel(psd_out_ref_jtf_1)-numel(psd_out_vco_jtf_1);
     psd_out_total_jtf_1=psd_out_vco_jtf_1 + psd_out_ref_jtf_1(1:end-dd);
     end
   P_rms_JTF1(n)=sum(psd_out_total_jtf_1);
   A_rms_JF1(n)=sqrt(P_rms_JTF1(n));
  end
#plot(log10(w),10*log10(mag_output(1:end-2)),"b");
#plot(log10(w(1:end-1)),10*log10(mag1),"g");
#plot(log10(w),10*log10(mag),"r");
#plot(log10(w(1:end-1)),10*log10(psd_out_vco_pll_jtf_1),"m");
#hold on;
#plot(log10(w),10*log10(psd_out_vco_jtf_1),"r");
