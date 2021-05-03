#DLL_IN_TO_OUT
Icp=500e-6;
Kdl=2e-9;
C_dll=10^-10;
Tref=50e-9;
Wn=Icp*Kdl/(C_dll*Tref);
s=tf("s");
[num,den]=padecoef(Tref,4);
 #Hclosed_dll=((s+wn)*(num(1)*s^3 + num(2)*s^2 + num(3)*s + num(4)))/((den(1)*s^4 + den(2)*s^3 + den(3)*s^2 + den(4)*s + wn*(num(1)*s^3 + num(2)*s^2+ num(3)*s^1+ num(4))));
Hclosed_dll_1=(s+wn)*(1-s*Tref)/(s+wn*(1-s*Tref));
#Hclosed_dll_2=(s+wn)*(1-s*Tref+(s*Tref/2)^2)/(s+wn*(1-s*Tref+(s*Tref/2)^2));
#Hclosed_dll_3=((s+wn)*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6))/(s+wn*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6));
Hclosed_dll_5=((s+Wn)*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120))/(s+Wn*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120));
#bodemag(Hclosed_dll_2);
[mag5 phase w]=bode(Hclosed_dll_1);
#plot(log10(w),10*log10(mag5));
hold on;
#PLL_IN_TO_OUT
Ip=500e-6;
Kpd=Ip/(2*pi);
Kvco=1e9;
R=5e3;
C_PLL=75e-12;;
M=1;
K=Kpd*Kvco/C_PLL;
Tref=50*10^-9;
#Hopen=tf([Kpd*Kvco*R*C Kpd*Kvco],[C 0 0]);
Hclosed=(s*K*R*C_PLL+K)/(s^2+(K*R*C/M)*s+K/M);
#Hclosed=tf([Kpd*Kvco*R Kpd*Kvco/C],[1 Kpd*Kvco*R/M Kpd*Kvco/(M*C)]);
[mag6 phase w]=bode(Hclosed);
#plot(log10(w),10*log10(mag6));
#H_DLL_PLL_ref_to_out=(((s+Wn)*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120))/(s+Wn*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120)))*((s*K*R*C_PLL+K)/(s^2+(K*R*C/M)*s+K/M));
#bodemag(Hclosed_dll_2))
H_dll_pll_1=((s+wn)*(1-s*Tref)*((s*K*R*C_PLL+K)))/((s+wn*(1-s*Tref))*(s^2+(K*R*C/M)*s+K/M))
bode(H_dll_pll_1);