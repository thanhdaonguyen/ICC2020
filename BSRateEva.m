function BSRateEva(count, N, RfEngMax, HarvEngMax, PT_src)
% This function is to evaluate the proposed system with three types of WPDs
% (each type has N devices, e.g. N = 3 (3 PWPDs, 3 AWPDs, 3 HWPDs) when the backscatter rate is varied.
% In addition, it compares the integration mode and other modes:
% 1. HTT mode only: there are only AWPDs and HWPDs devices which operate in this mode 
%(N transmission time variables-AWPDs and N transmission time variables-HWPDs.
% 2. Backscatter mode only: there are only PWPDs and HWPDs devices which operate in this mode
%(N backscatter time variables of PWPDs, N backscatter time variables of HWPDs).

%%
% Load setup parameters
InputParameters;
CallParameters;

%%
% Compute the phi values at each AWPD or HWPD (data transmission)
dist = 20*ones(1, 2*N);         % there are only 2*N devices (N AWPDs and N HWPDs) in transmission sub-frame.

phi_vec = Gamma*delta*TransGain*RecGain./(((4*pi/lambda).*dist).^2);

%%
% Convert scalar values to vectors
PtMax_vec = zeros(1, 2*N);                  % Declare the vector of maximum power transmission of AWPDs, HWPDs.
HarvEngMin_vec = zeros(1, 2*N);             % Declare the vector of minimum harvested energy of AWPDs, HWPDs.
for i = 1:2*N
    PtMax_vec(i) = PtMax;                   % N elements of P_a^0 and N elements of P_h^0
    HarvEngMin_vec(i) = EnergyMin;          % N elements of E_a^0 and N elements of E_h^0
end

backscatRate_vec = zeros(1, count);
for i = 1:count
    backscatRate_vec(i) =  i*IniBackscatRate;  % X-asis
end


%%
% Initialize vectors to store evaluation results
IntegrationSol = zeros(1, count);
Rate_backsc = zeros(1, count);
Rate_trans = zeros(1, count);
INTx = zeros(1, 4*N);              % \theta_p, \nu_a, \tau_h, \mu_h
TDMASol = zeros(1, count);
optXita = [0.5, 0.01, ones(1, 4*N)/(4*N)]; 
%%
% Main loop
for i = 1:count
    
%     temp(1) = N;
%     temp(2:2*N+1) = phi_vec;
%     temp(2*N+2) = RfEngMax;
%     temp(2*N+3) = backscatRate_vec(i);
%     save('fileData.mat', 'temp');       % transfer input values to Objfunc
%     
    optXita = BCD(iniXita, );
    %%
    %===============================================================================================
    % The Intergrated mode
    IntOutput = IntOptimFunc(N, backscatRate_vec(i), phi_vec, kappa, PtMax_vec, HarvEngMax, HarvEngMin_vec, RfEngMax, Gamma, PT_src);
    
    if IntOutput(1) < i*IniBackscatRate
        IntegrationSol(i) = i*IniBackscatRate;
        Rate_backsc(i) = i*IniBackscatRate;
        Rate_trans(i) = 0;
    else
        IntegrationSol(i) = IntOutput(1);
        Rate_backsc(i) = IntOutput(2);
        Rate_trans(i) = IntOutput(3);
    end
    
    for j = 1:4*N
        INTx(j) = IntOutput(j+3);
    end
    disp('Optimal points of the proposed system in Integration mode:');
    disp(INTx);
    

    TDMA = TDMA_Func(N, backscatRate_vec(i), phi_vec, kappa, Gamma, HarvEngMax, RfEngMax);
    TDMASol(i) = TDMA(1);
    TDMA_backsc = TDMA(2);
    TDMA_trans = TDMA(3);
%     if IntOutput(1) < i*IniBackscatRate
%         PT = IntOutput(4*N+5);
%         TDMASol(i) = TDMA_transPriority(N, backscatRate_vec(i), phi_vec, kappa, PT);
%     else
%         PT = IntOutput(4*N+5);
%         TDMASol(i) = TDMA_backscPriority(N, backscatRate_vec(i), phi_vec, kappa, PT);
%     end
%     
    
    
    delete('fileData.mat');
end

%%

% The HTT mode only (This mode is transparent to backscatter rate -> run one time).
%%
HTTSol = zeros(1, count);   
HTTx = zeros(1, 2*N);

temp(1) = N;
temp(2:2*N+1) = phi_vec;
temp(2*N+2) = RfEngMax;
temp(2*N+3) = 0;
temp(2*N+4) = HarvEngMax;
save('fileData.mat', 'temp');

HttOutput = HttOptimFunc(N, phi_vec, kappa, HarvEngMax, RfEngMax, Gamma, PT_src);

HTTSol = HttOutput(1)*ones(1, count);
for i = 1:2*N
    HTTx(i) = HttOutput(i+1);
end
disp('Optimal points of the proposed system in HTT mode:');
disp(HTTx);
delete('fileData.mat');


%%
%===============================================================================================
% The Backscatter mode only
BSMode = backscatRate_vec;           

%%
% Creating display vector on x-asis (backscatter rate)
IntegrationSol = IntegrationSol/1000
HTTSol = HTTSol/1000
Rate_backsc = Rate_backsc/1000
Rate_trans = Rate_trans/1000
BSMode = BSMode/1000;
TDMASol = TDMASol/1000;
backscatRate_vec = backscatRate_vec/1000;
% max(IntegrationSol/HTTSol)
% max(IntegrationSol/BSMode)
% max(IntegrationSol-HTTSol)
% max(IntegrationSol-BSMode)
%Draw the results
plot(backscatRate_vec, IntegrationSol, '-r*', backscatRate_vec, BSMode, '-bs', backscatRate_vec, HTTSol, '-kd', backscatRate_vec, TDMASol, '-m>','LineWidth', 1.5, 'MarkerSize', 10);
hold on;

plot(backscatRate_vec, Rate_backsc, '-.y+', backscatRate_vec, Rate_trans, '--go', 'LineWidth', 1.0, 'MarkerSize', 8);
fig_legend = legend('Proposed solution','BCM','HTTCM', 'TDMA');
grid on;

set(fig_legend, 'FontSize', 12);
ylabel('Overall Throughput (Kb per time frame)');
xlabel('Backscatter Rate (Kbps)');
end

