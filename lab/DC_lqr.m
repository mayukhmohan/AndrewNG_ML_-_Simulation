close all;
clear all;
clc;
Ra= 2.7;
La = 0.004;
J = 0.0001;
Kaphi = 0.105;
B = 0.0000093;
Amat = [-Ra/La -Kaphi/La; Kaphi/J -B/J];
Bmat = [1/La;0];
Cmat = [0 1];
Dmat = [0];
step(Amat,Bmat,Cmat,Dmat)
system = ss(Amat,Bmat,Cmat,Dmat);
x0 = [5;80];
figure
initial(system,x0);
% op =[];X=[0;0];U = 220;der=[];
% for t=0:0.01:20
% Xdot = Amat*X + Bmat*U;
% der = [der;Xdot.'];
% Y = Cmat*X;
% op = [op;Y];
% X = Xdot*dt + X;
% end
Q = diag([1 1]);
R =1;
[K,S,e]=lqr(Amat,Bmat,Q,R);
Ac = Amat - Bmat*K;
% op =[];X=[0;0];U = 220;der=[];
% for t=0:0.01:20
% Xdot = Ac*X + Bmat*U;
% der = [der;Xdot.'];
% Y = Cmat*X;
% op = [op;Y];
% X = Xdot*dt + X;
% end
t = 0:0.001:0.1;
figure
step(Ac,Bmat,Cmat,Dmat,1,t);
system_c = ss(Ac,Bmat,Cmat,Dmat);
x0 = [5 ; 0];
xx0= [5;0];
% figure
% tim = 0:0.001:0.001;
% [y,t,x] = initial(system_c,x0,tim)
% for tim = 0:0.001:1
%     [y,t,x] = initial(system_c,x0,tim)
%     x0=x;
% end

%initial(system_c,x0,t);


%Noise
dt = 0.001;
strt = 0.001;
en = 0.1;
tot = ((en - strt) / dt) + 1;

mu = [0 0];
sigma = 0.0001 * eye(2);
rng('default')  % For reproducibility
noise = mvnrnd(mu,sigma,ceil(tot));
y1 = [];
t1 = [];
x1 = [];
y2 = [];
t2 = [];
x2 = [];
i = 1;
for time = strt : dt : en
    [y1d, t1d, x1d] = initial(system_c, x0, 0 : dt : dt);
    y1 = vertcat(y1, y1d(2,:));
    t1 = vertcat(t1, time);
    x1 = vertcat(x1, x1d(2,:));
    x0 = x1d(2,:);
    x0 = x0 + noise(i, :);
    [y2d, t2d, x2d] = initial(system_c, xx0, 0 : dt : dt);
    y2 = vertcat(y2, y2d(2,:));
    t2 = vertcat(t2, time);
    x2 = vertcat(x2, x2d(2,:));
    xx0 = x2d(2,:);
    i = i + 1;
end
 figure
 plot(t1, y1, 'r', t2, y2, 'b')
 grid


