Icp=0.001;
Kdl=10^-9;
C=10^-10;
K=Icp*Kdl/C;
Tref=50*10^-9;
pkg load control;
z= tf("z",Tref);
Hclosed_ref_out=4*((z*(1+K)-1)/(z*(z-(1-K))));
Hopen_loop=K/(z-1);
b=[1+K -1];
a=[1 -(1-K)];
Wn=Icp*Kdl/(C*Tref);
Hclosed_dll=tf([-Tref (1-Wn*Tref) Wn],[0 (1-Wn*Tref) Wn]);
[mag ,phase, w]=bode(Hclosed_ref_out,{10^3,10^7});
psd_in=10^-14;
psd_out=psd_in.*(mag.^2);
P_rms=sum(psd_out);
A_rms=sqrt(P_rms);
A_rms_t=A_rms*Tref/(2*pi);
#plot(log10(w),10*log10(psd_in));
#hold on;
for i=1:1:3
  if i==1
    K=1/10;
   end
   if i==2
     K=1/30;
    end
   if i==3;
     K=1/100;
    end
    Hclosed_ref_out=4*((z*(1+K)-1)/(z*(z-(1-K))));
    [mag,phase,w]=bode(Hclosed_ref_out,{1,4*10^7});
    psd_out=psd_in.*(mag'.^2);
    P_rms=sum(psd_out);
    A_rms=sqrt(P_rms);
    A_rms_t=A_rms*Tref/(2*pi); 
    if i==1
    #bode(Hclosed_ref_out,"r");
    #set(findobj(gcf,"type","axes"),"nextplot","add");
    #plot(log10(w),10*log(mag),"r");
    plot(log10(w),10*log10(psd_out),"r");
    hold on;
    tj1=A_rms_t*10^12;
   end
   if i==2
    #bode(Hclosed_ref_out,"b");
   #plot(log10(w),10*log(mag),"g");
    plot(log10(w),10*log10(psd_out),"b");
    tj2=A_rms_t*10^12;
    end
   if i==3;
    # bode(Hclosed_ref_out,"g");
   #plot(log10(w),10*log(mag),"b");
    plot(log10(w),10*log10(psd_out),"g");
    tj3=A_rms_t*10^12;
    end
end 

#plot(log10(w),20*log10(psd_out));

