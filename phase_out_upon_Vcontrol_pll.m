Ip=0.001;
Kpd=Ip/(2*pi);
Kvco=50;
R=1.6*10^6;
C=10^(-10);
pkg load control;
s=tf("s");
Hv=tf([Kvco 0],[1 Kpd*Kvco*R Kpd*Kvco/C])
step(Hv,10);
hold on;
#ramp(Hv,10,"r");
hold off;
#bode(Hv);