% Decision vector: x = [h, focal_len, D_a, Pt_dBm, mass]
% Units: h (m), focal_len (m), D_a (m), Pt_dBm (dBm), mass (kg)

% Bounds and initial guess
h_min = 350e3; h_max = 800e3;
focal_min = 0.05; focal_max = 0.6;
Dmin = 0.02; Dmax = 0.6;
Pt_min = 10; Pt_max = 43; % dBm
m_min = 2; m_max = 6; % kg

GSD_req = 15;          % meters
SNR_req = 10;         % dB
Cd = 2.2;
A = 0.03;
tau_req = 931;        % days          
revisit_req = 5400;   % seconds
i = 97.4;
ground_lat = 0;
ground_lon = 0;

x0 = [500e3, 0.25, 0.1, 40, 4];

lb = [h_min, focal_min, Dmin, Pt_min, m_min];
ub = [h_max, focal_max, Dmax, Pt_max, m_max];

% Objective: minimize E_day
obj = @(x) objective_Eday(x);

% Nonlinear constraints
nonlcon = @(x) constraints_energy(x, GSD_req, SNR_req, Cd, A, tau_req, Dmax, m_max, revisit_req, i, ground_lat, ground_lon);


options = optimoptions('fmincon','Display','iter','Algorithm','sqp');

fprintf('\n========= OPTIMIZATION RESULTS =========\n');
fprintf('Optimal Altitude (h)           : %.2f km\n', xopt(1)/1e3);
fprintf('Optimal Focal Length           : %.3f m\n', xopt(2));
fprintf('Optimal Antenna Diameter (D)   : %.3f m\n', xopt(3));
fprintf('Optimal Tx Power               : %.2f dBm (%.2f W)\n', xopt(4), 10^((xopt(4)-30)/10));
fprintf('Optimal CubeSat Mass           : %.2f kg\n', xopt(5));

% Recompute performance at optimum
GSD_opt  = compute_GSD(xopt(1), xopt(2));
SNR_opt  = compute_SNR(xopt(1), xopt(2), xopt(3), xopt(4));

fprintf('\n--- Performance at optimum ---\n');
fprintf('GSD achieved                  : %.2f m (req: %.2f m)\n', GSD_opt, GSD_req);
fprintf('SNR achieved                  : %.2f dB (req: %.2f dB)\n', SNR_opt, SNR_req);
fprintf('Daily Energy Objective (Eday) : %.3f (minimized value)\n', fval);
fprintf('========================================\n');



