% Initialize common input parameters for the simulation

%========================================================================== 
% RF energy source information
global BandWidth;
BandWidth = 10*10^6;                     %Unit: Hz (10MHz)

%global RfTransPow;
%RfTransPow = 1.78;

global IniRfEngmax;
IniRfEngmax = 0.1;

global freq;
freq = 2.4*10^9;                         %Unit: Hz

global InitBeta;
InitBeta = 0.2;

priGain = 6;                             %Unit: dBi
secondGain = 6;                          %Unit: dBi

global TransGain;
TransGain = 10^(priGain/10);              

global RecGain;
RecGain = 10^(secondGain/10);            

global lambda;
lambda = 3*10^8/freq;                    %Unit: meter

global C;
C = 2e-6;                                   %second-ordered factor of power functions

global D;
D = 2e-3;                                   %first-ordered factor of power function

global p_r;
p_r = 0.15;
%==========================================================================
% Wireless-Powered Devices information
global IniNumbOfST;
IniNumbOfST = 5;

global IniBackscatRate;
IniBackscatRate = 5*10^3;                  %Unit: bps

global varphi;
varphi = 0.6;                             %Data transmission efficiency 

global delta;
delta = 0.5;                             %Energy harvesting efficiency

global Noise;
Noise = 1.3*10^(-9);                     %Noise in transmission of secondary transmitter

global NoisePow;                            
NoisePow = Noise*BandWidth;

global Gamma;                               
Gamma = 1/NoisePow;


global kappa;
kappa = varphi*BandWidth;

global PtMax;
PtMax = 5*10^(-5);              % Transmit Power threshold of the devices (P_a,h^0).

global EnergyMin;
EnergyMin = 10^(-7);                % E_a,h^0

% global EnergyMax;
% EnergyMax = 1.1*10^(-6);                % E_a,h^0