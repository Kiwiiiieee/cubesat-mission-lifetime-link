c = 299792458;
f = 8e9; % or 8e9 for X-band
lambda = c / f;
eta = 0.6; % aperture efficiency
Gr = 12; % ground gain in dBi
d=1600e3;
FSPL = 20*log10(4*pi*d*f/c);
Lsys = 3.6;
Psens = -108; M0 = 3; % dB

% mass model constants (example)
m0 = 0.05; % kg
k = 0.5;   % kg/m^2

% bounds
Dmin = 0.02; Dmax = 0.5; % m
Pt_min = 0; Pt_max = 40; % dBm

obj = @(x) m0 + k * (pi*(x(1)^2)/4); % x(1)=D (m), x(2)=Pt (dBm)

nonlcon = @(x) deal([], Psens + M0 - (x(2) + 10*log10(eta*(pi*x(1)/lambda)^2) + Gr - FSPL - Lsys));
% inequality: nonlcon <= 0 satisfied => link ok

x0 = [0.1, 33]; % initial guess [D, Pt]
options = optimoptions('fmincon','Display','iter');
[xopt, fval] = fmincon(obj, x0, [], [], [], [], [Dmin, Pt_min], [Dmax, Pt_max], nonlcon, options);

D_opt = xopt(1);
Pt_opt = xopt(2);
Gopt_dBi = 10*log10(eta*(pi*D_opt/lambda)^2);


fprintf('\n----- OPTIMIZED ANTENNA RESULTS -----\n')
fprintf('Optimal Diameter: %.3f m (%.1f cm)\n', D_opt, D_opt*100)
fprintf('Optimal Tx Power: %.2f dBm (%.2f W)\n', Pt_opt, 10^((Pt_opt-30)/10))
fprintf('Achieved Antenna Gain: %.2f dBi\n', Gopt_dBi)
fprintf('Resulting Link Margin >= %.1f dB ensured\n', M0)