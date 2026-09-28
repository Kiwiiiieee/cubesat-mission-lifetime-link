function L = compute_lifetime(h, m, Cd, A)
    rho = 3e-12; % rough atmospheric density at 500km
    V = 7.6e3;   % orbital velocity m/s
    a_drag = 0.5 * Cd * A * rho * V^2 / m;
    L = h / (a_drag * 86400); % lifetime in days approximation
end