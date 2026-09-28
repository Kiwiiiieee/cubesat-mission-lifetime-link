function gsd = compute_GSD(h, focal)
    pixel = 5e-6; % 5 micron pixel size
    gsd = (h * pixel) / focal;
end