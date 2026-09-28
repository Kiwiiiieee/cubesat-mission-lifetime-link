clc,clear,clear all
% --- Load table (preserve original names) ---
data = readtable('OrbitResults.xlsx','VariableNamingRule','preserve');

% --- Epoch in MJD (days) ---
epochMJD = data.("DefaultSC.A1ModJulian");

% --- GMAT lifetime directly from CSV ---
mjd_start = epochMJD(1);
mjd_final = epochMJD(end);
lifetime_days_gmat = mjd_final - mjd_start;          % days
lifetime_years_gmat = lifetime_days_gmat / 365.2422; 

fprintf('GMAT lifetime: %.8f days (%.10f years)\n', lifetime_days_gmat, lifetime_years_gmat);
