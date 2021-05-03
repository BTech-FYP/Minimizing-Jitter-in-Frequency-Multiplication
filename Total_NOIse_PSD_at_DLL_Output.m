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
[mag1 phase w1]=bode(Hclosed_dll_6,{1,1e9});
[mag2 phase w2]=bode(Hnoise_dll_1,{1,1e9});
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
if (numel(psd_in_vcdl)>=numel(mag2'))
  d=numel(psd_in_vcdl)-numel(mag2');
 end
psd_out_dll_noise=psd_in_ref.*(mag1'(1:end-1).^2)+psd_in_vcdl(1:end-d).*(mag2'.^2);