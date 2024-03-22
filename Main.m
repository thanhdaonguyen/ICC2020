%%
% This scenario (Scenario 1) considers the system in the case of having the same number of devices for each type.

clc;
clear;
close all;

%%
%Evaluation of the system performance when the backscatter rate is varied
% BSRateEva(numbOfSteps, numbOfSTs, E_S^0, EnergyMax, PT_src)  
%BSRateEva(10, 10, 0.6, 10e-6, 1.6);
   

%%
%Evaluation of the system performance when the power of RF energy source is varied
% PowerRFmaxEva(numbOfSteps, numbOfSTs, BackscRate, EnergyMax)
EnergyRFmaxEva(7, 3, 5e3, 1.1e-6);
