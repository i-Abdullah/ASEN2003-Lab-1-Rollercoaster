function [TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ArcLength] = Transition_into(t0,x0, y0, z0,theta, Raduis)
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
theta. This's a transition into something, something above you.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Inputs:

1-  t0: initial time relative to the whole roller coaster when
the cart started going on the ramp.


2- x0: initial x position.

3- y0: initial y position.

4- z0: initial z position.

5- theta: imagine the transition is a circle, starting from 0, how many degrees
should it run too? That's your theta.

6- Raduis: Raduis of the circle.



% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


Outputs: 

1- TimeElapsed : time just spent on this segment.

2- Outputs_G: G's at eaxh (x,y,z) coordinate.

3- Outputs_Loc: [ 3 x n ], where each column is one point in (x,y,z).

4- Outputs_Velocity: Velocity at each point on the rollercoaster.

5- ArcLength: which is equivalent to the total distance covered

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


%}

%% Gravity
g = 9.81;
%% Tangent normal coordinate CurrentYstem

ArcLength = theta * pi / 180 * Raduis;

ThetaRange = (0:(theta))';

% Location
CurrentY = y0 + (Raduis - Raduis * cosd(ThetaRange)); 

CurrentX = x0 + Raduis * sind(ThetaRange);

CurrentZ = z0 * ones(length(ThetaRange),1);


CurrentV = sqrt(2 * g * (125 - CurrentY)); 

Normal = g * cosd(ThetaRange) + CurrentV.^2/Raduis; % Normal force / m

G = Normal/g; % G force

fprintf('The transition into the parabolic hill generates a maximum magnitude of: %6.2f %12.8f \n ', abs(max(G)))
fprintf(' G, forward and upward. \n ' );

%% write output
ArcLength = [ArcLength];
TimeElapsed = [];
Outputs_G = [ G' ] ;
Outputs_Loc = [ CurrentX' ; CurrentY' ; CurrentZ' ];
Outputs_Velocity = [ CurrentV' ] ;


end