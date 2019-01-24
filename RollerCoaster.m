%% info

%% housekeeping

clear;
clc;
close all;

%% define constants

% define all inital conditions for the first segment
g = 9.81;
h0 = 124 ; %initial height in meters

% velocity function
syms h
v(h) = sqrt ( 2 * g * (h0 - h)) ; 

Vi = double(v(h0)); %initial velocity
Ti = 0; %time in s
Xi = 0; % in m
Yi = h0; % in m
Zi = 0; % in m
a0x = 0;



%% ramp down

 [ Time G Loca Veloc ] = RampDown(Vi,0, g, 0, 60, 60, h0, Xi, Zi, h0 );
 
 % concatate:
 
 G = cat(1,1,G);
 xPosit = cat(1,0,Loca(1));
 yPosit = cat(1,h0,Loca(2));
 zPosit = cat(1,0,Loca(3));
 xVeloc = cat(1,Vi,Veloc(1)');
 t = cat(1,0,Time(1));

 %% Linear section: transition, For 5 meters
 
 distance = 5; %Linear distance
 
 G = cat(1,G,1);
 xPosit = cat(1,xPosit,Loca(1,:)+distance);
 yPosit = cat(1,yPosit,Loca(2,:));
 zPosit = cat(1,zPosit,Loca(3,:));
 xVeloc = Veloc;
 t = cat(1,0,Time(1)); % needs to be fixed.
 
 
 %% circular loop:
 
 % initial info.
 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 r = 5; %loop Raduis
 
 [ TimeNew GNew LocaNew VelocNew ] = CircularLoop(xVeloc, t, r, x0, y0, z0,h0);

 
 G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 t = cat(1,Time,TimeNew);

 %% linear segment: transition for 5 meters
 
 distance = 10; %Linear distance
 
 [ r c ] = size(LocaNew);
 
 G = cat(1,G,1);
 xPosit = cat(1,xPosit,LocaNew(1,c)+distance);
 yPosit = cat(1,yPosit,LocaNew(2,c));
 zPosit = cat(1,zPosit,LocaNew(3,c));
 
 xVeloc = Veloc;
 t = cat(1,0,Time(1)); % needs to be fixed.

 %% parabolic hill:
 
 
x0 = xPosit(length(xPosit));
y0 = yPosit(length(yPosit));
z0 = zPosit(length(zPosit));
theta = 60;
a0 = 0;
v = double(v(y0));
t0 = 0;

 [ TimeNew GNew LocaNew VelocNew ] = ParabolaicHill(t0, y0, x0, z0, theta, a0, v)
 
  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew(2,:)');
 t = cat(1,Time,TimeNew);

  %% linear segment: transition for 5 meters
 
 distance = 10; %Linear distance
 
 [ r c ] = size(LocaNew);
 
 G = cat(1,G,1);
 xPosit = cat(1,xPosit,LocaNew(1,c)+distance);
 yPosit = cat(1,yPosit,LocaNew(2,c));
 zPosit = cat(1,zPosit,LocaNew(3,c));
 
 xVeloc = Veloc;
 t = cat(1,0,Time(1)); % needs to be fixed.

  %% circular loop:
 
 % initial info.
 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 r = 5; %loop Raduis
 
 [ TimeNew GNew LocaNew VelocNew ] = CircularLoop(xVeloc, t, r, x0, y0, z0,h0);

 
 G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 t = cat(1,Time,TimeNew);
