pkg load control;
Icp=0.02;
Kdl=10^-9;
C=10^-10;
K=Icp*Kdl/C;
Tref=50*10^-9;
z= tf("z",Tref);
Hclosed_delay_line_noise_to_out=4*(z-1)/(z-(1-K));
[mag,phase,w]=bode(Hclosed_delay_line_noise_to_out,{1,4*10^7});
for i=1:numel(mag)
  if w(i)<=100
    psd_in_db=0;
  end
  if 100<w(i)<=10^6
    psd_in_db(i)=60-log10(w(i))*30;
   end
  if 10^6<w(i)
    psd_in_db(i)=-120-(log10(w(i))-6)*20;
   end
   
end
psd_in=10.^(psd_in_db./10);
psd_out=psd_in.*(mag'.^2);
P_rms=sum(psd_out);
A_rms=sqrt(P_rms);
A_rms_t=A_rms*Tref/(2*pi);
#bode(Hclosed_delay_line_noise_to_out);
plot(log10(w),10*log10(psd_in),"r");
hold on;
#k=1/100
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
    Hclosed_delay_line_noise_to_out=4*(z-1)/(z-(1-K));
    [mag,phase,w]=bode(Hclosed_delay_line_noise_to_out,{1,4*10^7});
    psd_out=psd_in.*(mag'.^2);
    P_rms=sum(psd_out);
    A_rms=sqrt(P_rms);
    A_rms_t=A_rms*Tref/(2*pi); 
    if i==1
    #bode(Hclosed_delay_line_noise_to_out,"r");
    #set(findobj(gcf,"type","axes"),"nextplot","add");
    #plot(log10(w),10*log(mag),"r");
    plot(log10(w),10*log10(psd_out),"r");
    tj1=A_rms_t*10^12;
   end
   if i==2
   # bode(Hclosed_delay_line_noise_to_out,"b");
   # plot(log10(w),10*log(mag),"g");
   plot(log10(w),10*log10(psd_out),"b");
    tj2=A_rms_t*10^12;
    end
   if i==3;
    # bode(Hclosed_delay_line_noise_to_out,"g");
   #plot(log10(w),10*log(mag),"b");
    plot(log10(w),10*log10(psd_out),"g");
    tj3=A_rms_t*10^12;
    end
end 
k=1/10;
Hclosed_delay_line_noise_to_out=4*(z-1)/(z-(1-K));
bode(Hclosed_delay_line_noise_to_out,"b");
hold off;
