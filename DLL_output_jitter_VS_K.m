pkg load control;
Icp=0.02;
Kdl=10^-9;
C=10^-10;
K=Icp*Kdl/C;
Tref=50*10^-9;
z= tf("z",Tref);
Hclosed_delay_line_noise_to_out=400*(z-1)/(z-(1-K));
[mag1,phase1,w]=bode(Hclosed_delay_line_noise_to_out,{1,4*10^7});
Hclosed_ref_out=400*((z*(1+K)-1)/(z*(z-(1-K))));
for i=1:500
  if w(i)<=100
    psd_in_db=0;
  end
  if 100<w(i)<=10^6
    psd_in_db_vcdl(i)=60-log10(w(i))*30;
   end
  if 10^6<w(i)
    psd_in_db_vcdl(i)=-120-(log10(w(i))-6)*20;
   end
   
end
psd_in_vcdl=10.^(psd_in_db_vcdl./10);
psd_in_ref=10^-14;


K=0.1:0.019:2;
for j=1:1:100
  Hclosed_delay_line_noise_to_out=200*((z-1)/(z*(z-(1-K(j)))));
  [mag1,phase1,w]=bode(Hclosed_delay_line_noise_to_out,{1,4*10^7});
  Hclosed_ref_out=200*((z*(1+K(j))-1)/(z*(z-(1-K(j)))));
  [mag2,phase2,w]=bode(Hclosed_ref_out,{1,4*10^7});
  psd_out_vcdl=psd_in_vcdl.*(mag1'.^2);
  psd_out_ref=psd_in_ref.*(mag2'.^2);
  dc_gain=20*log10(mag1(500));
  psd_out=psd_out_ref + psd_out_vcdl;
  P_rms_vcdl=sum(psd_out_vcdl);
  P_rms_ref=sum(psd_out_ref);
  A_rms_vcdl(j)=sqrt(P_rms_vcdl);
  A_rms_ref(j)=sqrt(P_rms_ref);
  P_rms=sum(psd_out);
  A_rms(j)=sqrt(P_rms);
 A_rms_t(j)=A_rms(j)*Tref/(2*pi);
 
  end
