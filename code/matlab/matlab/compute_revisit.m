function t = compute_revisit(h, i, lat, lon)
    Re = 6378e3;
    n = sqrt(3.986e14/(Re+h)^3);
    t = (2*pi/n) * (1/abs(cosd(i))); % rough revisit proxy
end