function Eday = objective_Eday(x)
h = x(1); % altitude (km)
focal = x(2); % focal length (m)
D = x(3); % antenna diameter (m)
Pt = x(4); % transmit power (dBm)
m = x(5); % satellite mass (kg)
% ---- Payload power model (W) ----
% Approx: 5 W base + 2 W per meter of focal length
Ppayload = 5 + 2*focal;
% ---- Imaging time per day (s) ----
% Approx: more time if resolution is high (focal large)
ton = 300 + 200*focal; % 5 min base + extra depending on focal
% ---- Daily data volume (bits/day) ----
% Approx: proportional to resolution (focal)
Vdata = 2e9 * (1 + 0.5*focal); % 2 Gbit base
% ---- Link rate model (bits/s) ----
% Function of antenna diameter, power and altitude
Rlink = 1e6 * D * (10^(Pt/40)) / (1 + h/500); % simplified link model
% ---- Communication duration (s) ----
tcomm = Vdata / Rlink;
% ---- RF transmit power conversion ----
Pcomm = 10^((Pt - 30)/10); % dBm →W
% ---- Satellite bus power estimate (W) ----
Pbus = 2 + 0.1*m; % 2 W base + mass scaling
% ---- Total daily energy consumption (J) ----
Econs = Ppayload*ton + Pcomm*tcomm + Pbus*24*3600;
% ---- Solar energy availability model (J/day) ----
% 30% eclipse assumed for LEO, solar panel 20 W baseline
Psun = 20 * (1 - 0.3); % average power considering eclipse
Esolar = Psun * 86400;
% ---- Final objective: minimize deficit ----
Eday = Econs - Esolar;
end
