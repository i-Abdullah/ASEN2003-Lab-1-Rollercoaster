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

Ramptheta = 60 ;

 [ TimeNew GNew LocaNew VelocNew ] = RampDown(Vi,0, g, 0, 60, Ramptheta, h0, Xi, Zi, h0 );

 % concatate:
 
 G = cat(1,1,GNew);
 xPosit = cat(1,0,LocaNew(1));
 yPosit = cat(1,h0,LocaNew(2));
 zPosit = cat(1,0,LocaNew(3));
 xVeloc = cat(1,Vi,VelocNew(1)');
 t = cat(1,0,TimeNew(1));
 
 %% transition off rampCurvture
 
 Curvture = 5; % Choosen arbitrary.
  
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 [ TimeNew GNew LocaNew VelocNew ] = Transition_fromRampDown(t0,x0, y0, z0,Ramptheta,Curvture);

 
  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 t = cat(1,t,TimeNew);

 %% Linear section: transition, For 5 meters
 
 distance = 5; %Linear distance
 
  x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,x0+distance);
 yPosit = cat(1,yPosit,y0);
 zPosit = cat(1,zPosit,z0);
 xVeloc = cat(1,xVeloc,VelocNew');
 t = cat(1,t,TimeNew); 
 %% circular loop:
 
 % initial info.
 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 r = 7; %loop Raduis
 
 [ TimeNew GNew LocaNew VelocNew ] = CircularLoop(xVeloc, t, r, x0, y0, z0,h0);

 
  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 t = cat(1,t,TimeNew);

 %% Linear section: transition, For 5 meters
 
 distance = 5; %Linear distance
 
  x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,x0+distance);
 yPosit = cat(1,yPosit,y0);
 zPosit = cat(1,zPosit,z0);
 xVeloc = cat(1,xVeloc,VelocNew');
 t = cat(1,t,TimeNew); 

  %% transition into hill
 
 Curvture = 5; % Choosen arbitrary.
  
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 [ TimeNew GNew LocaNew VelocNew ] = Transition_into(t0,x0, y0, z0,Ramptheta,Curvture);

 
  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 t = cat(1,t,TimeNew);

 
 %% parabolic hill:
 
 
x0 = xPosit(length(xPosit));
y0 = yPosit(length(yPosit));
z0 = zPosit(length(zPosit));
theta = 45;
a0 = 0;
v = double(v(y0));
t0 = 0;

 [ TimeNew GNew LocaNew VelocNew ] = ParabolaicHill(t0, y0, x0, z0, theta, a0, v);
 
  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew(1,:)');
 t = cat(1,t,TimeNew);

 %% transition off the hill.
  
 Curvture = 20; % Choosen arbitrary.
  
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 [ TimeNew GNew LocaNew VelocNew ] = Transition_out(t0,x0, y0, z0,Ramptheta,Curvture,1);

 
  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 t = cat(1,t,TimeNew);

 
  %% linear segment: transition for 5 meters
 
 %% Linear section: transition, For 5 meters
 
 distance = 5; %Linear distance
 
  x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,x0+distance);
 yPosit = cat(1,yPosit,y0);
 zPosit = cat(1,zPosit,z0);
 xVeloc = cat(1,xVeloc,VelocNew');
 t = cat(1,t,TimeNew); 
 
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

 
 %% plot
 
 plot3(xPosit,yPosit,zPosit)