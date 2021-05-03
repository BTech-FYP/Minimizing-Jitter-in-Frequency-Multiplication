Icp=0.0001;
Kdl=10^-9;
C=10^-10;
Tref=10^-6
Wn=Icp*Kdl/(C*Tref);
H_delay_noise_dll=tf([ 1 0 ],[(1-Wn*Tref) Wn]);
[mag phase w]=bode(H_delay_noise_dll);
bode(H_delay_noise_dll);