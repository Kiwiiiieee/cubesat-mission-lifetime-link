% --- Constraints function ---
function [c, ceq] = constraints_energy(x, GSD_req, SNR_req, Cd, A, tau_req, Dmax, m_max, revisit_req, i, ground_lat, ground_lon)
  h = x(1); focal = x(2); D = x(3); Pt = x(4); m = x(5);
  % inequality constraints c(x) <= 0
  c = [];
  % 1) GSD constraint
  GSD = compute_GSD(h, focal);
  c(end+1) = GSD - GSD_req;
  % 2) SNR constraint
  SNR = compute_SNR(h, focal, D, Pt);
  c(end+1) = SNR_req - SNR; % ensure SNR >= SNR_req
  % 3) lifetime constraint
  life = compute_lifetime(h, m, Cd, A);
  c(end+1) = (tau_req - life)/(24*3600*30); % life >= tau_req
  % 4) antenna size/mass constraints
  c(end+1) = D - Dmax;
  c(end+1) = m - m_max;
  % 5) revisit constraint (approx numeric)
  revisit = compute_revisit(h, i, ground_lat, ground_lon);
  
  ceq = []; % no equality constraints
end