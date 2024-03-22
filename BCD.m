function [optXita] = BCD(iniXita, phi, )
%BCD Summary of this function goes here
%   Detailed explanation goes here
InputParameters;
CallParameters;

n = 1;
tol1 = e-3;
x_0 = iniXita(1:2);                   %\beta, p_l
y_0 = iniXita(3:(4*N + 2));           %\theta, \tau, \nu, \mu for 4*N variables (N-PWBD, N-AWPD, N-HWPD)

sum1 = 0;
sum2 = 0;
sum3 = 0;
for i = 1:2*N
    if rem(i,2) == 0
        sum2 = sum2 + y_0(i)*kappa*log2(1 + phi(i/2)*(1 - x_0(1))*(x_0(2) - D)/(2*y_0(i)*C));
    else
        sum1 = sum1 + bsRate*y_0(i);
    end
end
for i = 2*N+1:4*N
    if rem(i,2) == 0
        sum3 = sum3 + bsRate*y_0(i-1) + y_0(i)*kappa*log2(1 + phi(i/1)*(1 - x_0(1) - y_0(i-1))*(x_0(2) - D)/(2*y_0(i)*C));
    end
end

ledUtility_0 = p_r*(sum1 + sum2 + sum3) - x_0(2)*(1 - x_0(1))*(x_0(2) - D)/2C;
ledUtility = [];

%%
%===========================================================================
%Denote q(1) = (1 - x(1))(x(2) - D); q(2) = (x(2) - D)
%Denote z(1) = (w(1) + w(2))/2; z(2) = (w(1) - w(2))/2
q_0 = [(1 - x_0(1))*(x_0(2) - D), (x_0(2) - D)];
z_0 = [(q_0(1) + q_0(2))/2, (q_0(1) - q_0(2))/2];

%The CCCP algorithm
z = CCCP();



end

