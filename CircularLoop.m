function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ] = CircularLoop(V0, t0, r, x0, y0, z0,RollerHeight)
% ASEN 2003: Dynamics, Lab 1, Roller Coaster
%
%{
This function is one segment of a roller coaster, it attempts to module a
Circular Loop, where the user will determine the ramp specifications, and
initial conditions, and the function will return the end status. 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


Inputs:

1- V0 : Initial velocity (Total magnitude).

2- t0 : initial time relative to the whole roller coaster when
the cart started going on the Loop.

3- r : raduis of the loop.

4- TimeIn: AccelrX : initial time relative to the whole roller coaster when
the cart started going on the ramp.

5- y_init : 125 m in this case.

5- RampAngle: relative to horizon, in degrees.

6- Length: hypotenuse of the ramp.

7 - InitialHeight: Initial Height ramp starts from. 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Outputs: 

1- TimeElapsed : time just spend on this segment.

2- VelocFinal: In this case all of it will be in direction of +x (read
note), and assuming no friction it's only function of heignt, and thus all
of it will transfer after the ramp.

3- AccelerationFinal: accelration at the end of the ramp. In this case all
of it will be in direction of +x (read note).

4- PositionFinalX: Y location, or distance covered in Y direction in
cartesian coordinates system.

5- PositionFinalY:  X location, or distance covered in x direction in
cartesian coordinates system.

6- G: How many G's felt (relative to Earth's accelration).

%}


%% using Normal tangent coordinate system.

% we can know our height based on our simple geometry.

thetaStep = 0:0.1:360;
g = 9.81;


%syms theta_current 

currentHeight = y0 + (r - r*cosd(thetaStep));
currentX = x0 + r*sind(thetaStep);

%
%syms currentHeight
v = sqrt ( 2 * g * (RollerHeight - (y0 + r - r*cosd(thetaStep)))) ; 

% get value for  accelration 

an = (v.^2)/r; %normal accelration
at = g*sind(thetaStep); %tangential accelration

Normal = (an) + g*cosd(thetaStep) ; % normal force (N divided by m, so later you can just multiply by 1/g!) to get g's.

% Normal force will make the 


%% prepare outputs

zf = 1; %final z position, will assume it's one because cart needs to go into the page to finish the loop.

% sub in thetas to get current points:

OutputY = currentHeight;
OutputX = currentX;
OutputZ = linspace(z0,zf,length(OutputX));


G = double(Normal./9.81);

%% write outputs

Outputs_G = [ G ] ;
Outputs_Loc = [ OutputX ; OutputY ; OutputZ ] ;
Outputs_Velocity = [ v ] ;

TimeElapsed = 0 ;

end