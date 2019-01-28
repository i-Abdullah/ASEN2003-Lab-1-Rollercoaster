%% info
% comments needs to be added.
%% housekeeping

clear;
clc;
close all;

%% define constants

% define all inital conditions for the first segment
g = 9.81;
h0 = 125 ; %initial height in meters

% velocity function
syms h
v(h) = sqrt ( 2 * g * (h0 - h)) ; 

Vi = double(v(h0)); %initial velocity
Ti = 0; %time in s
Xi = 0; % in m
Yi = h0; % in m
Zi = 0; % in m
a0x = 0;
angle = 60;
r = 20;
t0 = 0;

[TimeNew GNew LocaNew VelocNew DistanceCovered] = TransitionToDownRamp(r,angle,Xi,Yi,Zi);

 % concatate:
 TotalDistanceCovered = DistanceCovered;
 G = cat(1,1,GNew');
 xPosit = cat(1,0,LocaNew(1,:)');
 yPosit = cat(1,h0,LocaNew(2,:)');
 zPosit = cat(1,0,LocaNew(3,:)');
 xVeloc = cat(1,Vi,VelocNew');
 %t = cat(1,0,TimeNew(1));

 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 Coordinate_i = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 
 
%% ramp down

Ramptheta = 60 ;
Length2 = 60;
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 [ TimeNew GNew LocaNew VelocNew] = RampDown(Vi,0, Ramptheta,Length2, y0, x0, z0, h0 );
   G = cat(1,G,GNew');
   TotalDistanceCovered = cat(1,TotalDistanceCovered,Length2);
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate_i,CoordinateNew);
 
 %t = cat(1,t,TimeNew);
 %% transition off rampCurvture
 
 Curvture = 50; % Choosen arbitrary.
  
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 [ TimeNew GNew LocaNew VelocNew DistanceCovered] = Transition_fromRampDown(t0,x0, y0, z0,Ramptheta,Curvture);

 
  G = cat(1,G,GNew');
  TotalDistanceCovered = cat(1,TotalDistanceCovered,DistanceCovered);
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

% t = cat(1,t,TimeNew);

 %% Linear section: transition, For 5 meters
 
 distance = 60; %Linear distance
 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 GNew = 1;
  G = cat(1,G,GNew');
  TotalDistanceCovered = cat(1,TotalDistanceCovered,distance);
 xPosit = cat(1,xPosit,x0+distance);
 yPosit = cat(1,yPosit,y0);
 zPosit = cat(1,zPosit,z0);
 xVeloc = cat(1,xVeloc,VelocNew');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

% t = cat(1,t,TimeNew); 
 %% circular loop:
 
 % initial info.
 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 r = 37; %loop Raduis
 t=0;
 [ TimeNew GNew LocaNew VelocNew DistanceCovered ] = CircularLoop(xVeloc, t, r, x0, y0, z0,h0);
 
  G = cat(1,G,GNew');
 TotalDistanceCovered = cat(1,TotalDistanceCovered,DistanceCovered);
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 
% get coordinate of a point in the middle of the segment so it can be
% named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

% t = cat(1,t,TimeNew);

 %% Linear section: transition, For 5 meters
 
 distance = 50; %Linear distance
 
  x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

  GNew = 1;
  G = cat(1,G,GNew');
   TotalDistanceCovered = cat(1,TotalDistanceCovered,distance);
 xPosit = cat(1,xPosit,x0+distance);
 yPosit = cat(1,yPosit,y0);
 zPosit = cat(1,zPosit,z0);
 xVeloc = cat(1,xVeloc,VelocNew');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

% t = cat(1,t,TimeNew); 

  %% transition into hill
 
 Curvture = 60; % Choosen arbitrary.
  
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 [ TimeNew GNew LocaNew VelocNew DistanceCovered ] = Transition_into(t0,x0, y0, z0,Ramptheta,Curvture);

 
  G = cat(1,G,GNew');
     TotalDistanceCovered = cat(1,TotalDistanceCovered,DistanceCovered);
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

 %t = cat(1,t,TimeNew);

 
 %% parabolic hill:
 
 
x0 = xPosit(length(xPosit));
y0 = yPosit(length(yPosit));
z0 = zPosit(length(zPosit));
theta = 45;
a0 = 0;
v = double(v(y0));
t0 = 0;

 [ TimeNew GNew LocaNew VelocNew DistanceCovered] = ParabolaicHill(t0, y0, x0, z0, theta, a0, v);
 
  G = cat(1,G,GNew');
  TotalDistanceCovered = cat(1,TotalDistanceCovered,DistanceCovered);
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew(1,:)');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

 %t = cat(1,t,TimeNew);

 %% transition off the hill.
  
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;
Ramptheta = 50;

 [ TimeNew GNew LocaNew VelocNew DistanceCovered] = Transition_out(t0,x0, y0, z0,Ramptheta,Curvture);

 
  G = cat(1,G,GNew');
  TotalDistanceCovered = cat(1,TotalDistanceCovered,DistanceCovered);
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

% t = cat(1,t,TimeNew);

 
 %% Linear section: transition, For 5 meters
 
 distance = 5; %Linear distance
 
  x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 GNew = 1;
  G = cat(1,G,GNew');
  TotalDistanceCovered = cat(1,TotalDistanceCovered,distance);
 xPosit = cat(1,xPosit,x0+distance);
 yPosit = cat(1,yPosit,y0);
 zPosit = cat(1,zPosit,z0);
 xVeloc = cat(1,xVeloc,VelocNew');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

% t = cat(1,t,TimeNew); 
 
  %% circular loop:
 
 % initial info.
 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 r = 35; %loop Raduis
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

 
 %% 
 [ TimeNew GNew LocaNew VelocNew DistanceCovered] = CircularLoop(xVeloc, t, r, x0, y0, z0,h0);

 
 G = cat(1,G,GNew');
 TotalDistanceCovered = cat(1,TotalDistanceCovered,DistanceCovered);
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

 %t = cat(1,Time,TimeNew);
 %% Linear section: transition, For 5 meters
 
 distance = 10; %Linear distance
 
  x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 GNew = 1;
  G = cat(1,G,GNew');
   TotalDistanceCovered = cat(1,TotalDistanceCovered,distance);
 xPosit = cat(1,xPosit,x0+distance);
 yPosit = cat(1,yPosit,y0);
 zPosit = cat(1,zPosit,z0);
 xVeloc = cat(1,xVeloc,VelocNew');
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

% t = cat(1,t,TimeNew); 
 
 
 
%% Banked Turn 

 % initial info.
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 r = 39; %loop Raduis
 BankAngle = 50;
 
 [ TimeNew GNew LocaNew VelocNew DistanceCovered] = BankTurn(BankAngle, t, r, x0, y0, z0,h0);
  G = cat(1,G,GNew(1,:)');
  TotalDistanceCovered = cat(1,TotalDistanceCovered,DistanceCovered);
 xPosit = cat(1,xPosit,double(LocaNew(1,:)'));
 yPosit = cat(1,yPosit,double(LocaNew(2,:)'));
 zPosit = cat(1,zPosit,double(LocaNew(3,:)'));
 xVeloc = cat(1,xVeloc,VelocNew);
 
 % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

 
  %% Linear section: transition, For 5 meters
 
 distance = 10; %Linear distance
 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 GNew = 1;
  G = cat(1,G,GNew);
    TotalDistanceCovered = cat(1,TotalDistanceCovered,distance);
 xPosit = cat(1,xPosit,x0-distance);
 yPosit = cat(1,yPosit,y0);
 zPosit = cat(1,zPosit,z0);
 xVeloc = cat(1,xVeloc,VelocNew);
 
  % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.
 
 CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

 
% t = cat(1,t,TimeNew); 
 
 %% ramp down but in opposite direction to the other ramp
 %% ramp down

  Curvture = 30; % Choosen arbitrary.
  Ramptheta = 20;
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;

 [ TimeNew GNew LocaNew VelocNew DistanceCovered ] = Transition_fromBankedTurn(t0,x0, y0, z0,Ramptheta,Curvture);

  G = cat(1,G,GNew');
  TotalDistanceCovered = cat(1,TotalDistanceCovered,DistanceCovered);
 xPosit = cat(1,xPosit,LocaNew(1,:)');
 yPosit = cat(1,yPosit,LocaNew(2,:)');
 zPosit = cat(1,zPosit,LocaNew(3,:)');
 xVeloc = cat(1,xVeloc,VelocNew');
% t = cat(1,t,TimeNew);

 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;
Ramptheta = 25.1 ;
length1 = 86.6;
[ TimeNew GNew LocaNew VelocNew] = RampDownOpposite(t0,Ramptheta,length1,y0, x0, z0 );

  G = cat(1,G,GNew');
   TotalDistanceCovered = cat(1,TotalDistanceCovered,length1);
 xPosit = cat(1,xPosit,double(LocaNew(1,:)'));
 yPosit = cat(1,yPosit,double(LocaNew(2,:)'));
 zPosit = cat(1,zPosit,double(LocaNew(3,:)'));
 xVeloc = cat(1,xVeloc,VelocNew');
 
   % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.

  CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

 
 
 %% Transition to ground
 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;
 r = 60;
 curvature = 30;
 [ TimeNew GNew LocaNew VelocNew DistanceCovered] = Transition_toGround(x0, y0, z0,curvature, r);
 
 G = cat(1,G,GNew');
 TotalDistanceCovered = cat(1,TotalDistanceCovered,DistanceCovered);
 xPosit = cat(1,xPosit,double(LocaNew(1,:)'));
 yPosit = cat(1,yPosit,double(LocaNew(2,:)'));
 zPosit = cat(1,zPosit,double(LocaNew(3,:)'));
 xVeloc = cat(1,xVeloc,VelocNew');
 
 
    % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.

  CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

   %% Linear section: transition, For 5 meters
 
 distance = 20; %Linear distance
 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;
 
 GNew = 1;
 G = cat(1,G,GNew');
 TotalDistanceCovered = cat(1,TotalDistanceCovered,distance);
 xPosit = cat(1,xPosit,x0-distance);
 yPosit = cat(1,yPosit,y0);
 zPosit = cat(1,zPosit,z0);
 xVeloc = cat(1,xVeloc,VelocNew');
% t = cat(1,t,TimeNew); 
 
 
 %% Braking and stopping

 
 x0 = xPosit(length(xPosit));
 y0 = yPosit(length(yPosit));
 z0 = zPosit(length(zPosit));
 t0 = 0;
 [TimeNew GNew LocaNew VelocNew] = BreakAndStop(x0,y0,z0);
 
  G = cat(1,G,GNew');
 xPosit = cat(1,xPosit,double(LocaNew(1,:)'));
 yPosit = cat(1,yPosit,double(LocaNew(2,:)'));
 zPosit = cat(1,zPosit,double(LocaNew(3,:)'));
 xVeloc = cat(1,xVeloc,VelocNew');
 
    % get coordinate of a point in the middle of the segment so it can be
 % named on the plot at that point.

  CoordinateNew = [ LocaNew(1,(floor(length(LocaNew)/2)));  LocaNew(2,(floor(length(LocaNew)/2))) ; LocaNew(3,(floor(length(LocaNew)/2))) ];
 Coordinate = cat(3,Coordinate,CoordinateNew);

 
 %% All velocities = 
 syms h
v = @(h) sqrt ( 2 * g * (h0 - h)) ; 

AllV = v(yPosit);
AllV(end) = 0;

%% print total distance

fprintf('\n ' );
fprintf('Total distance covered: %6.2f %12.8f \n ',sum(TotalDistanceCovered))
fprintf(' meters. \n ' );

 %% plot
 
 figure(1);
 
 color_line3(xPosit,yPosit,zPosit,AllV,'LineWidth',2.5);
 colormap spring;
 c = colorbar;
 c.Label.String = 'Velocity in m/s';
 grid minor;
 title('Velocities in the rollercoaster');
 xlabel('Location in x (right and left) (m)');
 ylabel('Location in y (up and down) (m)');
 zlabel('Location in z (inside and outside) (m)');
view([-18 80]) 

%put texts on the graph to label segments.
text(Coordinate(1,1,1)-45,Coordinate(2,1,2),Coordinate(3,1,3),' Transition \rightarrow');

text(Coordinate(1,1,4)-45,Coordinate(2,1,5),Coordinate(3,1,6),'\leftarrow Ramp');

text(Coordinate(1,1,7)-40,Coordinate(2,1,8),Coordinate(3,1,9),'\leftarrow Circular loop');

text(Coordinate(1,1,10)-40,Coordinate(2,1,11)+40,Coordinate(3,1,12),'\leftarrow Parabolic Hill');


text(Coordinate(1,1,13)-80,Coordinate(2,1,14),Coordinate(3,1,15),'Bank turn \rightarrow');

text(Coordinate(1,1,16)-240,Coordinate(2,1,17)+30,Coordinate(3,1,18),'Transition from ramp to braking \rightarrow');


saveas(gcf,'Gforce.jpg')


% name the sections

% -__- !!

  figure(2);
 
 colormap winter;
 color_line3(xPosit,yPosit,zPosit,G,'LineWidth',2.5);
 c = colorbar;
 c.Label.String = 'G force';
 grid minor;
 title('Totatl G force over the track of the rollercoaster');
 xlabel('Location in x (right and left) (m)');
 ylabel('Location in y (up and down) (m)');
 zlabel('Location in z (inside and outside) (m)');
 view([-18 80])
 
 %put texts on the graph to label segments.
text(Coordinate(1,1,1)-45,Coordinate(2,1,2),Coordinate(3,1,3),' Transition \rightarrow');

text(Coordinate(1,1,4)-45,Coordinate(2,1,5),Coordinate(3,1,6),'\leftarrow Ramp');

text(Coordinate(1,1,7)-40,Coordinate(2,1,8),Coordinate(3,1,9),'\leftarrow Circular loop');

text(Coordinate(1,1,10)-40,Coordinate(2,1,11)+40,Coordinate(3,1,12),'\leftarrow Parabolic Hill');


text(Coordinate(1,1,13)-80,Coordinate(2,1,14),Coordinate(3,1,15),'Bank turn \rightarrow');

text(Coordinate(1,1,16)-240,Coordinate(2,1,17)+30,Coordinate(3,1,18),'Transition from ramp to braking \rightarrow');

 saveas(gcf,'Velocity.jpg')


 