#DLL
#_Noise_TO_OUT
Icp=500e-6;
Kdl=10e-9;
C_dll=10^-10;
Tref=50e-9;
Wn=Icp*Kdl/(C_dll*Tref);
#s=tf("s");
pkg load control;
s=tf("s");
M1=600;
Hnoise_dll_1=M1*(s*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120+((s*Tref)^6)/720))/(s+Wn*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120+((s*Tref)^6)/720));
K_dll=Icp*Kdl/C_dll;
#bodemag(Hnoise_dll_1,"g");
#hold on;
#DLL_Ref_to_out
Hclosed_dll_6=M1*((s+Wn)*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120+((s*Tref)^6)/720))/(s+Wn*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120+((s*Tref)^6)/720));
#bodemag(Hclosed_dll_6,"r");
#//////////////////////////////////////////////////////////
#PLL_IN_TO_OUT
Ip=200e-6;
Kpd=Ip/(2*pi);
Kvco=1e7;
R=1e3;
C_PLL=200e-12;;
M=1;
K=Kpd*Kvco/C_PLL;
Tref=50*10^-9;
H_ref_to_out_pll_1=(K*(s*C_PLL*R+1))/(s^2+K*(s*C_PLL*R/M+1/M));
Q=1/(R*sqrt(Kpd*Kvco*C_PLL));
#bodemag(Hnoise_dll_1);
#bodemag(H_ref_to_out_pll_1,{1,40e6},"b");
 ##on;#//////////////////////////////////////////////////////
#JTF 2nd Order 4 MHz
JTF=s^2/((s-16e6)^2);
#DLL_CASCADED_PLL
#VCO_Noise_Considered_Zero
H_cascad_vco_zero=Hnoise_dll_1*H_ref_to_out_pll_1*JTF;
#bodemag(H_cascad_vco_zero,{1,40e6},"r");
#VCDL_Noise_Considered_Zero
H_cascad_vcdl_zero=(s^2/(s^2+K*R*C_PLL*s/M+K/M))*JTF;
#bodemag(H_cascad_vcdl_zero/JTF,{1,40e6},"m");
#Ref_of_dll_to_output_of_PLL
H_cascad_ref_to_out=Hclosed_dll_6*H_ref_to_out_pll_1*JTF;
#bodemag(H_cascad_ref_to_out,{1,40e6},"g");
#VCO_Noise_Considered_Zero
#H_cascad_vco_zero=Hnoise_dll_1*H_ref_to_out_pll_1;
#VCDL_Noise_Considered_Zero
#H_cascad_vcdl_zero=s^2/(s^2+K*R*C_PLL*s/M+K/M);
[mag1 phase1 w1]=bode(H_cascad_ref_to_out,{1,40e6});
#[mag2 phase2 w2]=bode(H_cascad_vco_zero,{1,40e6});
#[mag3 phase3 w3]=bode(H_cascad_vcdl_zero,{1,40e6});
#[mag4 phase4 w4]=bode(JTF,{1,40e6});
#H_ref_pll_out=H_cascad_ref_to_out/JTF;
#[mag5 phase5 w5]=bode(H_ref_pll_out_1,{1,40e6});
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
for i=1:numel(w1)
  if w1(i)<=215
    psd_in_db_vcdl=0;
  end
  if 215<w1(i)<=10^6
    psd_in_db_vcdl(i)=70-log10(w1(i))*30;
   end
  if 10^6<w1(i)
    psd_in_db_vcdl(i)=-110-(log10(w1(i))-6)*20;
   end
   
end
psd_in_vcdl=10.^(psd_in_db_vcdl./10);
psd_in_ref=10^-14;

  WN=10e6;
  K_BW_PLL=500:5000:40000
  for z=1:numel(K_BW_PLL)
    K=K_BW_PLL(z)/(R*C_PLL);
    Hnoise_dll_1=M1*(s*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120+((s*Tref)^6)/720))/(s+WN*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120+((s*Tref)^6)/720));
    Hclosed_dll_6=M1*((s+WN)*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120+((s*Tref)^6)/720))/(s+WN*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120+((s*Tref)^6)/720));
   # K_BW=10000:5000:3e5;
   #for q=1:numel(K_BW);
    H_ref_to_out_pll_1=(K*(s*C_PLL*R+1))/(s^2+K*(s*C_PLL*R/M+1/M));  
    [mag_pll phase_pll w_pll]=bode(H_ref_to_out_pll_1,{1,40e6});
    dc_gain=20*log10(mag_pll(1));
    for j=1:numel(mag_pll)
     if(20*log10(mag_pll(j))<=(dc_gain-3))
      BW_PLL_1(z)=w_pll(j);
      break;
     end
    end
    H_cascad_ref_to_out=Hclosed_dll_6*H_ref_to_out_pll_1*JTF;
    H_cascad_vco_zero=Hnoise_dll_1*H_ref_to_out_pll_1*JTF; 
    H_cascad_vcdl_zero=(s^2/(s^2+K*R*C_PLL*s/M+K/M))*JTF;
    [mag1 phase1 w1]=bode(H_cascad_ref_to_out,{1,40e6});
    [mag2 phase2 w2]=bode(H_cascad_vco_zero,{1,40e6});
    [mag3 phase3 w3]=bode(H_cascad_vcdl_zero,{1,40e6});
    if(numel(psd_in_vcdl)>=numel(mag2'))
      d=numel(psd_in_vcdl)-numel(mag2');
      psd_out_vcdl=psd_in_vcdl(1:end-d).*(mag2'.^2);
     end
     if(numel(psd_in_vcdl)<numel(mag2'))
      d1=numel(mag2')-numel(psd_in_vcdl);
      psd_out_vcdl=psd_in_vcdl.*(mag2'(1:end-d1).^2);
     end
     P_rms_vcdln_11(z)=sum(psd_out_vcdl);
     A_rms_vcdl_11(z)=sqrt(P_rms_vcdln_11(z));
     if(numel(psd_in_vco)>numel(mag3'))
      d2=numel(psd_in_vco)-numel(mag3');
      psd_out_vco=psd_in_vco(1:end-d2).*(mag3'.^2);
     end
     if(numel(psd_in_vco)<numel(mag3'))
     d3=numel(mag3')-numel(psd_in_vco);
     psd_out_vco=psd_in_vco.*(mag3'(1:end-d3).^2);
     end
     psd_out_ref=psd_in_ref.*(mag1'.^2);
     P_rms_refn_1(z)=sum(psd_out_ref);
     A_rms_refn_1(z)=sqrt(P_rms_refn_1(z));
     P_rms_vcon_1(z)=sum(psd_out_vco);
     A_rms_vcon_1(z)=sqrt(P_rms_vcon_1(z));
 ##A_rms_vcdln_1(z)=sqrt(P_rms_vcdln_11(z));
     P_rms_totaln_1(z)=P_rms_refn_1(z)+P_rms_vcdln_11(z)+ P_rms_vcon_1(z);
     A_rms_totaln_11(z)=sqrt(P_rms_totaln_1(z));
  ##[min_jitter_wrt_bw_pll(j) index_opt(j)]=min(A_rms_total_1);
  ##K_BW_OPT(j)=K_BW(index_opt(j));
  #plot(log10(w1(1:end-3)j),10*log10(psd_out_vco),"b");
  #hold on;
  #plot(log10(w3),10*log10(mag3),"r");
  #plot(log10(w4),10*log10(mag4),"g");
  #plot(log10(w5),10*log10(mag5),"m");
  #plot(log10(w1),10*log10(psd_in_ref),"m");
end