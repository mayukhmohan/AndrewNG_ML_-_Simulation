clear all;
close all;
clc;
Ts = 500e-06; %Sampling Time
Ra = 1; %Armature Resistance
La = 46e-6; %Armature Inductance
J = 0.0093; %Moment of INertia
B = 0.008; %Friction
Ia=20;
Kaphi = 0.55; %V.sec/rad
Ta = 20;
Tm = J/B; %Mechanical Time Constant
Rf = 100; %Field Resistance
Lf = 10e-3; %Field INductance
Tf = Lf/Rf; %Time const. (LR ckt) for Field
Ka = 0.69;
D = ((Kaphi)^2)+(Ra+B);
Tm1 = (Tm*Ra*B)/D;
Km1=B/D;
Km2=Kaphi/B;
Km= Km1*Km2;
Kt = 0.057;
Kr = 0.5;
Kc = 25;
Ks= 10;
Kp = 1;
Kd=1;
Ki = 5;
N1= 1/Ra;
D1 = [Ta 1];
N2 = Kaphi/B;
D2= [Tm 1];
N4=[Kaphi];
D4=1;
[Nfw, Dfw]=series(N1,D1,N2,D2);
[Nc1 Dc1]= feedback(Nfw,Dfw,N4,D4);
sys=tf(Nc1,Dc1);
sys.inputName = ('average voltage');
sys.outputName = ('speed');
%subplot(2,2,1); rlocusplot(sys);
%subplot(2,2,2); bodplot(sys);
% subplot(2,2,3); nyquistplot(sys);
% subplot(2,2,4); nicholsplot(sys);


Amat = [-(Ra/La) -Kaphi/La; Kaphi/J  -B/J];
%Bmat = [1/La 0; 0 -1/J];
Bmat = [1/La ; 0];
Cmat = [1 0];
Dmat = 0;

p1 = -15 + 1i;
p2 = -15 - 1i;
K = place(Amat,Bmat,[p1 p2]);
system = ss(Amat,Bmat,Cmat,Dmat);
% sys_order = order(sys);
% sys_rank = rank(ctrb(Amat,Bmat));
sys_cl = ss(Amat-Bmat*K,Bmat,Cmat,Dmat);
t = 0:0.01:3;
Kp = 0.262; Ki = 0.305; Kd = 0.0564;
figure
step(system,t)
grid

figure
step(sys_cl,t)
grid


