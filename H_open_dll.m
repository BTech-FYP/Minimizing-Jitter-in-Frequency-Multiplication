Icp=0.001;
Kdl=10^-9;
C=10^-10;
Tref=10^-6
Wn=Icp*Kdl/(C*Tref);
Hopen_dll=tf([-Tref 1],[1/Wn 0]);
bode(Hopen_dll);