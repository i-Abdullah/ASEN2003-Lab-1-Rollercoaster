function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ArcLength] = Transition_fromBankedTurn(t0,x0, y0, z0,theta, r)
% 
% ASEN 2003: Dynamics, Lab 1, Roller Coaster
%
%{

Done by:
- Abdullah AlMugirun
- Mohamed Aichiouene
- Aufa Amirullah
- Abdulla AlAmeri

This function is one segment of a roller coaster, it attempts to
module a transition from a segment. The segment is in the name of the
function. Most transitions are assumed to be circles that run to a certain
theta.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Inputs:

2-  t0: initial time relative to the whole roller coaster when
the cart started going on the ramp.


6- x0: initial x position.

5- y0: initial y position.

7- z0: initial z position.

3- theta: imagine the transition is a circle, starting from 0, how many degrees
should it run too? That's your theta.

4- r: Raduis of the circle.


8- RollerHeight: Roller coaster maximum height.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


Outputs: 

1- TimeElapsed : time just spent on this segment.

2- Outputs_G: G's at eaxh (x,y,z) coordinate.

3- Outputs_Loc: [ 3 x n ], where each column is one point in (x,y,z).

4- Outputs_Velocity: Velocity at each point on the rollercoaster.

5- ArcLength: which is equivalent to the total distance covered

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


%}
g = 9.81;

%% begin calculations of position

ArcLength = theta * pi / 180 * r;

ThetaRange = (180 : (180 + theta))';

% get location
CurrentY = y0 - r - r * cosd(ThetaRange); %height as a function of theta

CurrentX = x0 + r * sind(ThetaRange);

CurrentZ = z0 * ones(length(ThetaRange),1);

CurrentV = sqrt(2 * g * (125 - CurrentY)); %velocity due to change in height

Normal = g * cosd(ThetaRange) + CurrentV.^2/r; % Normal force / m

G = Normal/g;

fprintf('The transition out of the banked turn generates a maximum magnitude of: %6.2f %12.8f \n ', abs(max(G)))
fprintf(' G, forward and backward. \n ' );
%% write output

TimeElapsed = [];
ArcLength =[ArcLength];
Outputs_G = [ G' ] ;
Outputs_Loc = [ CurrentX' ; CurrentY' ; CurrentZ' ];
Outputs_Velocity = [ CurrentV' ] ;

end
