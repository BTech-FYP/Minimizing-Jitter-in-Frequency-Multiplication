Icp=0.001;
Kdl=10^-9;
C=10^-10;
Tref=10^-8
Wn=Icp*Kdl/(C*Tref);
Hv_voltage_noise_dll=tf([-Kdl*2*pi Kdl*2*pi/Tref 0],[0 (1-Wn*Tref) Wn]);
bode(Hv_voltage_noise_dll);