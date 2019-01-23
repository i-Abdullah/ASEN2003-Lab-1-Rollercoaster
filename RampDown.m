function [ TimeElapsed Outputs ] = RampDown(VelocIn,AccelrX, AccelrY, TimeIn, RampAngle, Length, y0, x0, z0, RollerHeight )
% 
% ASEN 2003: Dynamics, Lab 1, Roller Coaster
%
%{

This function is one segment of a roller coaster, it attempts to module a
ramp down, where the user will determine the ramp specifications, and
initial conditions, and the function will return the end status. 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

note: here all x and y is tilted, so that +x is pointing with the heading
vector, i.e where the rider is looking.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


Inputs:

1- VelocIn : Initial velocity (Total magnitude).

2- AccelrX : initial accelration in x direction.

3- AccelrY : initial accelration in y direction.

4- TimeIn: AccelrX : initial time relative to the whole roller coaster when
the cart started going on the ramp.

5- RampAngle: relative to horizon, in degrees.

6- Length: hypotenuse of the ramp.

7 - y_init: Initial y location of ramp. 

8 - x_init: Initial x location of ramp.

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

7- RollerHeight: height of roller coaster total.
%}

%% Define constants


g = 9.81;

%% accelerations 

ax = g * sind ( RampAngle ) ;
ay = 0 ;

AccelerationFinal = ax;

%% velocity: since acceleration is constant, we can go ahead and use kinematick equations.

%{ we can also get it from the height, which is inputted by the user. 

RampHeight = Length * sind ( RampAngle );
RampWidth = Length * cosd ( RampAngle );

% store as output
PositionFinalX = x0 + RampWidth;
PositionFinalY = y0 - RampHeight;

% get final velocity based on height.
syms h
v(h) = sqrt ( 2 * g * (RollerHeight - h)) ; 


%evaluate veloc function defined above.
VelocFinal = double(v(y0 - RampHeight));


%% time spent: since acceleration is constant, we can go ahead and use kinematic equations.

% here all velocity will be in the x direction, thus we can get time from
% kinematic equations that uses velocity and acceler will be used.

% ( ( v - v0 ) / a0 ) + t0 = t , where all of these in x since ay is 0.
% Again the coordinate system is tilted, but the time should be the same.


TimeElapsed =  ( (VelocFinal - VelocIn) / ax ) * TimeIn ;



%% G's felt.

G =  cosd(theta) ; 
fprintf('The Ramp down will make you feel: %6.2f %12.8f \n ', G)
fprintf(' G, forward. \n ' );

%% write outputs

% All G's here are forward.
Outputs = [ PositionFinalX ; PositionFinalY ; z0 ; G  ] ;


end