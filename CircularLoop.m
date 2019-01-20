function [ TimeElapsed Veloc Acceleration Position ] = CircularLoop(VelocIn,AccelIn,PpsitionIn)
% 
% ASEN 2003: Dynamics, Lab 1, Roller Coaster
%
%{

This function is one segment of a roller coaster, it attempts to module a
Circular Loop, where the user will determine the ramp specifications, and
initial conditions, and the function will return the end status. 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


Inputs:

1- VelocIn : Initial velocity (Total magnitude).

2- AccelrX : initial accelration in x direction.

3- AccelrY : initial accelration in y direction.

4- TimeIn: AccelrX : initial time relative to the whole roller coaster when
the cart started going on the ramp.

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


%% info

%{

In circular loop the only acceleration is normal. which will be represented
by v^2/r , where r is the raduis. 






end