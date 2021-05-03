Icp=500e-6;
Kdl=2e-9;
C=10^-10;
Tref=50e-9;
Wn=Icp*Kdl/(C*Tref);
s=tf("s");
[num,den]=padecoef(Tref,4);
 #Hclosed_dll=((s+wn)*(num(1)*s^3 + num(2)*s^2 + num(3)*s + num(4)))/((den(1)*s^4 + den(2)*s^3 + den(3)*s^2 + den(4)*s + wn*(num(1)*s^3 + num(2)*s^2+ num(3)*s^1+ num(4))));
#Hclosed_dll_1=(s+wn)*(1-s*Tref)/(s+wn*(1-s*Tref));
#Hclosed_dll_2=(s+wn)*(1-s*Tref+(s*Tref/2)^2)/(s+wn*(1-s*Tref+(s*Tref/2)^2));
#Hclosed_dll_3=((s+wn)*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6))/(s+wn*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6));
Hclosed_dll_5=((s+Wn)*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120))/(s+Wn*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120));
#bodemag(Hclosed_dll_2);
[mag5 phase w]=bode(Hclosed_dll_5);
plot(log10(w),10*log10(mag5));
#step(Hclosed_dll,0.01);
Wn=200000:1000:500000
for j=1:numel(Wn)
  Hclosed_dll_5=((s+Wn(j))*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120))/(s+Wn(j)*(1-s*Tref+((s*Tref)^2)/2-((s*Tref)^3)/6+((s*Tref)^4)/24-((s*Tref)^5)/120));
  [mag5 phase w]=bode(Hclosed_dll_5);
  for i=1:numel(mag5)
    if(10*log10(mag5(i))<0)
      Closed_loop_BW(j)=w(i);
      break;
    end
  endfor
end