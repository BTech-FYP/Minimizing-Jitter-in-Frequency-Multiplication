Ip=10^-3;
Kpd=Ip/(2*pi);
Kvcdl=5;
R=10000;
C=10^(-10);
Hclosed=tf([Kpd*Kvcdl/C],[1 Kpd*Kvcdl/C]);
#bode(Hclosed);
Hopen=tf([Kpd*Kvcdl/C],[1 0]);
#bode(Hopen);
step(Hopen,.000001);
#ramp(Hclosed,1);
hold on;
t=0:0.01:1;
#plot(t,t,"r");
hold off;