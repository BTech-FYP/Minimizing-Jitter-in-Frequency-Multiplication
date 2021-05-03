Ip=10^-3;
Kpd=Ip/(2*pi);
Kvcdl=5;
R=10000;
C=10^(-10);
Hi=tf([Kvcdl/C],[1 Kpd*Kvcdl/C]);
#bode(Hi);
#step(Hi,.000001);
ramp(Hclosed,1);
hold on;
t=0:0.01:1;
#plot(t,t,"r");
hold off;