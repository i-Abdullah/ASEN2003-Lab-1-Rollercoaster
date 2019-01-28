function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity] = RampDown(v0, t0, RampAngle, Length, y0, x0, z0, RollerHeight )
% 
% ASEN 2003: Dynamics, Lab 1, Roller Coaster
%
%{

Done by:
- Abdullah AlMugirun
- Mohamed Aichiouene
- Aufa Amirullah
- Abdulla AlAmeri

This function is one segment of a roller coaster, it attempts to module a
ramp down, where the user will determine the ramp specifications, and
initial conditions, and the function will return the end status. 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

note: here all x and y is tilted, so that +x is pointing with the heading
vector, i.e where the rider is looking.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Inputs:
1- v0 : Initial velocity (Total magnitude).

2-  t0: initial time relative to the whole roller coaster when
the cart started going on the ramp.

3- RampAngle: relative to horizon, in degrees.

4- Length: hypotenuse of the ramp.

5- y0: initial y position.

6- x0: initial x position.

7- z0: initial z position.

8- RollerHeight: Roller coaster maximum height.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


Outputs: 

1- TimeElapsed : time just spent on this segment.

2- Outputs_G: G's at eaxh (x,y,z) coordinate.

3- Outputs_Loc: [ 3 x n ], where each column is one point in (x,y,z).

4- Outputs_Velocity: Velocity at each point on the rollercoaster.


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


%}

%% Define constants


g = 9.81;

%% accelerations 

ax = g * sind ( RampAngle ) ;
ay = 0 ;

AccelerationFinal = ax;

%% velocity: since acceleration is constant, we can go ahead and use kinematick equations.

% get final velocity based on height.
syms h
v(h) = sqrt ( 2 * g * (RollerHeight - h)) ; 



%% position 

%{ we can also get it from the height, which is inputted by the user. 

RampHeight = Length * sind ( RampAngle );
RampWidth = Length * cosd ( RampAngle );

%evaluate veloc function defined above.
VelocFinal = double(v(y0 - RampHeight));

% store as output
PositionFinalX = x0 + RampWidth;
PositionFinalY = y0 - RampHeight;


%% time spent: since acceleration is constant, we can go ahead and use kinematic equations.

% here all velocity will be in the x direction, thus we can get time from
% kinematic equations that uses velocity and acceler will be used.

% ( ( v - v0 ) / a0 ) + t0 = t , where all of these in x since ay is 0.
% Again the coordinate system is tilted, but the time should be the same.


TimeElapsed =  ( (VelocFinal - v0) / ax ) + t0 ;



%% G's felt.

G =  cosd(RampAngle) ; 
fprintf('The ramp down generates a maximum magnitude of: %6.2f %12.8f \n ', abs(max(G)))
fprintf(' G, forward and upward. \n ' );

%% write outputs

% All G's here are forward.
Outputs = [ PositionFinalX ; PositionFinalY ; z0 ; G  ] ;

Outputs_G = [G];
Outputs_Loc = [ PositionFinalX ; PositionFinalY ; z0 ];
Outputs_Velocity = [ VelocFinal ] ;
