Icp=0.001;
Kdl=10^-8;
C=10^-10;
K=Icp*Kdl/C;
Tref=50*10^-9;
z= tf("z",Tref);
Hclosed_Icp_to_out=(2*pi*K/Icp)/(z-(1-K));
bode(Hclosed_Icp_to_out);