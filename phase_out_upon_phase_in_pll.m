%one zero and two pole system damping factor 0f 0.5 natural resonant frequency
%doesnt depend on R,although with increasing R the zero shifts to the right
Ip=0.001;
Kpd=Ip/(2*pi);
Kvco=200*pi;
R=8*10^4;
C=10^(-10);
M=4;
K=Kpd*Kvco/C;
Tref=50*10^-9;
Hopen=tf([Kpd*Kvco*R*C Kpd*Kvco],[C 0 0]);
Hclosed=tf([Kpd*Kvco*R Kpd*Kvco/C],[1 Kpd*Kvco*R/M Kpd*Kvco/(M*C)]);
Hnoise=tf([1 0 0],[1 K*R*C K]);

#step(Hclosed,.0001);
hold on ;
#ramp(Hclosed,0.2,"r");
bode(Hclosed);
[mag,phase,w]=bode(Hclosed,{1000,10000000});
[mag2,phase,w]=bode(Hnoise,{1000,10000000});
psd_in=0.01;
psd_out=psd_in.*(mag.^2);
P_rms=sum(psd_out);
A_rms=sqrt(P_rms);
A_rms_t=Tref*A_rms/(2*pi);
plot(log10(w),20*log(mag));
hold on;
plot(log10(w),20*log(mag2));

