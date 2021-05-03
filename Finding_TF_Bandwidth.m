pkg load control;
s=tf("s");
Ip=200e-6;
Kpd=Ip/(2*pi);
Kvco=1e7;
R=1e3;
C_PLL=200e-12;
M=1;
K=Kpd*Kvco/C_PLL;
K_BW=K*R*C_PLL/M;
Tref=50*10^-9;
K_BW=1e3;
#for i=1:numel(K_BW)
  K=K_BW/(R*C_PLL/M);
  H_ref_to_out_pll_1=(K*(s*C_PLL*R+1))/(s^2+K*(s*C_PLL*R/M+1/M));
  H_cascad_vcdl_zero=(s^2/(s^2+K*R*C_PLL*s/M+K/M));
  [mag_pll phase_pll w_pll]=bode(H_ref_to_out_pll_1,{1,40e6});
   dc_gain=20*log10(mag_pll(1));
  for j=1:numel(mag_pll)
   if(20*log10(mag_pll(j))<=(dc_gain-3))
    BW_PLL=w_pll(j);
    break;
   end
end
#end