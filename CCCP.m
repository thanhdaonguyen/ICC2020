function [optOmega] = CCCP(preXita)
%CCCP Summary of this function goes here
%   Detailed explanation goes here
iniOmega = preXita(1:2);
preTime = preXita(3:4*N+2);

% Define constants for transformations
for i = 1:N
   w1(i) = preTime(2*i)*kappa;
   w2(i) = phi(i)/(2*preTime(2*i)*C);
   w3(i) = preTime(2*i+2*N)*kappa;
   w4(i) = phi(i+N)/(2*preTime(2*i+2*N);
   w5(i) = preTime(i+2*N);
   w6(i) = w4(i) - w5(i);
   w7(i) = w4(i) + w5(i);
end
w8 = 1/2*C;

%%
%Construct the matrix A of optimziation
for i = 1:N
    A(i,1)     =   1/(2*Gamma(i)*C*preTime(2*i)*Pt_0(i));                               % Power constraints for AWPDs  --> u
    A(i,2)     =  -1/(2*Gamma(i)*C*preTime(2*i)*Pt_0(i));                               % Power constraints for AWPDs  --> v
    A(i+N,1)   =  (1 - preTime(2*i-1))/(2*Gamma*C*preTime(2*i)*Pt_0(i));                % Power constraints for HWPDs  --> u
    A(i+N,2)   = -(1 + preTime((2*i-1)+2*N))/(2*Gamma*C*preTime(2*i+2*N)*Pt_0(i));      % Power constraints for HWPDs  --> v
    A(i+2*N,1) =  -1/(2*Gamma*C*Ea_0);                                                  % Energy constraints for AWPDs --> u          
    A(i+2*N,2) =   1/(2*Gamma*C*Ea_0);                                                  % Energy constraints for AWPDs --> v
    A(i+3*N,1) = -(1 - preTime(2*(i-1)-N))/(2*C*preTime(2*i-N)*Eh_0);                   % Energy constraints for HWPDs --> u 
    A(i+3*N,2) =  (1 + preTime(2*(i-1)-N))/(2*C*preTime(2*i-N)*Eh_0);                   % Energy constraints for HWPDs --> v
end

A(4*N+1,1) =  1/(2*C*E0_src);           % Energy constraint for RF Energy source --> u
A(4*N+1,2) = -1/(2*C*E0_src);           % Energy constraint for RF Energy source --> u

%%
%Construct the vector B of optimizaiton
for i = 1:N
    b(i)     =  1;
    b(i+N)   =  1;
    b(i+2*N) = -1;
    b(i+3*N) = -1;
end

b(4*N+1) = 1; 

%%
%Construct other arguments
lb = [0, 0];
ub = [];
Aeq =[];
beq = [];
nonlincon = [];
obj_func = @CCCP_ObjFunc;   % using the transformed objective func
options = optioptions(@fmincon, 'Algorithm', 'interior-point');

[optOmega] = fmincon(obj_func, iniOmega, A, b, Aeq, beq, lb, ub, nonlincon, options);

for i = 1:N
    sum1 = sum1 + w1(i)*log2(1 + w2(i)*(optOmega(1) - optOmega(2)));
    sum2 = sum2 + w3(i)*log2(1 + w6(i)*optOmega(1) - w7(i)*optOmega(2));
    sum3 = ;
end

G = p_r*();
end

