function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity Circumference] = CircularLoop(V0, t0, r, x0, y0, z0,RollerHeight)
% 
% ASEN 2003: Dynamics, Lab 1, Roller Coaster
%
%{

Done by:
- Abdullah AlMugirun
- Mohamed Aichiouene
- Aufa Amirullah
- Abdulla AlAmeri

This function is one segment of a roller coaster, it attempts to module the
Circular loop with a fixed raduis.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Inputs:

Inputs:
1- v0 : Initial velocity (Total magnitude).

2-  t0: initial time relative to the whole roller coaster when
the cart started going on the ramp.

3- r: raduis of circle, which is equivalent to raduis of curvature in this case.

4- x0: initial x position.

5- y0: initial y position.

6- z0: initial z position.

7- RollerHeight: Roller coaster maximum height.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


Outputs: 

1- TimeElapsed : time just spent on this segment.

2- Outputs_G: G's at eaxh (x,y,z) coordinate.

3- Outputs_Loc: [ 3 x n ], where each column is one point in (x,y,z).

4- Outputs_Velocity: Velocity at each point on the rollercoaster.

5- Circumference : which is equivalent to the total distance covered. 


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


%}



%% using Normal tangent coordinate system.

% we can know our height based on our simple geometry.
Circumference = 2 * pi * r;
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

fprintf('The second loop generates a maximum magnitude of: %6.2f %12.8f \n ', abs(max(G)))
fprintf(' G, forward and upward. \n ' );

%% write outputs
Circumference = [Circumference];
Outputs_G = [ G ] ;
Outputs_Loc = [ OutputX ; OutputY ; OutputZ ] ;
Outputs_Velocity = [ v ] ;

TimeElapsed = 0 ;

end