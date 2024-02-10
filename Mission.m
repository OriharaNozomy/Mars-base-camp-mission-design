%% Assumsions
%Earth parking orbit :300 km perigii
%Houhmann transfere orbit : 300 km perigee, 310326310 apogee


%% Parameters
tof=258.8; %time of flight from earth to mars
T_mars=343.4; %orbit of Mars
R_earth=6378; % Radius of Earth
R_mars=3389.5;
L_apogee_E=300+R_earth; % Launch Apogee
L_perigee=0+R_earth; % Launch perigee
mu=398600; % G*M Earth
mu_sun=1.3271*10^11; %G*M sun
mu_mars= 4.283*10^4 ;%G*M mars
Radius_E=149.6*10^6; % Distance from earth to sun
Radius_M=227.9*10^6; % Distance from Mars to Sun
E_to_M= 310.33*10^6; %Distance from Mars to earth
L_apogee_H=310326310; % apogee of transfere orbit
L_Mars_Prking=300+R_mars; %Landing apogee
L_Mars_Perigee=0+R_mars; %Landing perigee
year=2031; %year of launching
month=8; %month of launching
day=11; %day of launching

%% When to launch
alpha=180-tof*180/(T_mars);
j0=367*year-round((7*(year+round((month+9)/12,0))/4),0)+round(275*month/9)+day+1721013.5;
jo_1=j0+tof;
disp("Time of launch")
datetime(j0,'convertfrom','juliandate')
disp("Time of arrival")
datetime(jo_1,'convertfrom','juliandate')

% Launch calculations (first burn)
e_launch=(L_apogee_E-L_perigee)/(L_apogee_E+L_perigee); % orbit ecentricity
h=sqrt(mu*L_perigee*(1-e_launch)); % angular momentum
delta_v1=h/L_perigee; % velocity difference
disp("Delta v needed for launching the angle a 300km orbit (Km/sec)")
disp(delta_v1);

%% Circulizing parking orbit (secound burn)
v_apogee=h/L_apogee_E ;% velocity at apogee before circulization
v_apogee2=sqrt(mu/(L_apogee_E)); % velocity after circulization
delta_v2=v_apogee2-v_apogee; % delta v needed for entering parking orbit
disp("Delta v for completing circular orbit (km/sec)")
disp(delta_v2)

%% Parking orbit to Hohmann transfer (Third burn)
v_infinity=sqrt(mu_sun/Radius_E)*(sqrt(2*Radius_M/(Radius_E+Radius_M))-1);
delta_v3=v_apogee2-v_infinity;
disp("Delta v for putting the probe in a Hohmann transfer orbit to Mars (Km/sec)")
disp(delta_v3)

%% Hohmann transfer Mars Parking orbit (Fourth burn)
v_infinity2=sqrt(mu_sun/Radius_M)*(1-sqrt(2*Radius_E/(Radius_E+Radius_M)));% velocity at apogee of transfere orbit
v_mars_parking=sqrt(mu_mars/Radius_M);%velocity at the intrabce of parking orbit
delta_v4=v_infinity2-v_mars_parking;
disp("Delta v for leaving Hohmann transfer orbit to Mars parking orbit (Km/sec)")
disp(delta_v4);

%% Landing
e_landing=(L_Mars_Prking-L_Mars_Perigee)/(L_Mars_Perigee+L_Mars_Prking); % orbit ecentricity
h=sqrt(mu_mars*L_Mars_Perigee*(1-e_landing)); % angular momentum
delta_v5=h/L_Mars_Perigee-v_mars_parking; % velocity difference
disp("Delta v needed for landing (Km/sec)");
disp(delta_v5);


disp("Total Delta v for the mission")
disp(delta_v1+delta_v2+delta_v3+delta_v4+delta_v5)