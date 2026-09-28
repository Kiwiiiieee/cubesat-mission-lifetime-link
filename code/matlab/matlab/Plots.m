clc, clear, clear all

%% ================== LOAD GMAT DATA ==================
data = readtable('OrbitResults.xlsx','VariableNamingRule','preserve');

% Extract Time (GMAT gives epoch in Modified Julian Date)
epochMJD = data.("DefaultSC.A1ModJulian");

%% ================== EXTRACT ORBITAL PARAMETERS ==================
SMA = data.("DefaultSC.Earth.SMA")*1000;      % Semi-Major Axis (m)
ALT = data.("DefaultSC.Earth.Altitude")*1000; % Altitude (m)
INC = data.("DefaultSC.EarthMJ2000Eq.INC");   % Inclination (deg)
Energy = data.("DefaultSC.Earth.Energy");     % Orbital Energy

MJD_time = epochMJD;

%% ================== PLOTS ==================

% 1. Altitude vs Time (MJD)
figure;
plot(MJD_time, ALT/1000, 'LineWidth', 1.2);
xlabel('Time (MJD)');
ylabel('Altitude (km)');
title('Orbit Altitude vs Time');
grid on;

% 2. Inclination vs Time (MJD)
figure;
plot(MJD_time, INC, 'LineWidth', 1.2);
xlabel('Time (MJD)');
ylabel('Inclination (deg)');
title('Inclination vs Time');
grid on;

% 3. Orbital Energy vs Time (MJD)
figure;
plot(MJD_time, Energy, 'LineWidth', 1.2);
xlabel('Time (MJD)');
ylabel('Orbital Energy (m^2/s^2)');
title('Orbital Energy vs Time');
grid on;

% 4. Combined orbital parameters (MJD)
figure;
plot(MJD_time, SMA/1000, MJD_time, ALT/1000, MJD_time, INC);
xlabel('Time (MJD)');
ylabel('Value');
title('Orbital Parameters Over Time');
legend('SMA (km)','Altitude (km)','Inclination (deg)');
grid on;
