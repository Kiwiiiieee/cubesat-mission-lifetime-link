function snr = compute_SNR(h, focal, D, Pt)
    lambda = 3e8 / 2.2e9;
    eta = 0.6;
    Gt = 10*log10(eta*(pi*D/lambda)^2);
    Gr = 12;
    FSPL = 20*log10(4*pi*h*(2.2e9)/3e8);
    Pr = Pt + Gt + Gr - FSPL - 3.6;
    snr = Pr + 108; % assuming noise floor
end