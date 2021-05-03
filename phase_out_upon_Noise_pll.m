pkg load control;
Ip=500*10^-6;
Kpd=Ip/(2*pi);#ip/2pi
Kvco=10^9
R=10^5;
C=75*10^-12;
K=Kvco*Kpd/C;
Tref=50*10^-9;
#Hnoise=tf([1 0 0],[1 50 50]);
Hnoise=tf([1 0 0],[1 K*R*C K]);
Hclosed=tf([K*R*C K],[1 K*R*C K]);
#bode(Hnoise);
#step(Hnoise,0.01);
[mag,phase,w]=bode(Hnoise,{10000,10^20});
[mag1,phase1,w1]=bode(Hclosed,{10000,10^20});
#plot(log10(w),10*log10(mag));
hold on;
w(503)=w(502);
#plot(log10(w),10*log10(mag1),"r");
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
#psd_in_db_vco(501)=psd_in_db_vcdl(500);
psd_in_vco=10.^(psd_in_db_vco./10);
psd_in_vco(501)=psd_in_vco(500);
 mag(503)=mag(502)
psd_out_vco=psd_in_vco.*(mag'.^2);
plot(log10(w),10*log10(psd_out_vco));
hold on;
plot(log10(w),10*log10(mag));
plot(log10(w),10*log(psd_in_vco));
P_rms=sum(psd_out_vco);
A_rms_c=sqrt(P_rms);
A_rms_t_c=A_rms_c*Tref/(2*pi);
#psd_in=0.01;
K=1.0610e+15-10^15:2*10^13:1.0610e+15+10^15;
for j=1:1:101
  Hnoise=tf([1 0 0],[1 K(j)*R*C K(j)]);
 [mag,phase,w]=bode(Hnoise,{1,100000000});
 psd_out_vco=psd_in_vco(1:501).*(mag'.^2);
P_rms(j)=sum(psd_out_vco);
A_rms(j)=sqrt(P_rms(j));
A_rms_t(j)=A_rms(j)*Tref/(2*pi);
  
 # A_rms_t(i)=A_rms(i)*Tref/(2*pi);
end 
#plot(K,10*log10(A_rms));


