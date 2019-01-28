function [TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity] = BreakAndStop(x0,y0,z0)
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
breaking and stop section.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Inputs:

1- x0: initial x position.

2- y0: initial y position.

3- z0: initial z position.

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






%% g's
upGs = 1;
backGs = 3.9;
N = sqrt(upGs^2 + backGs^2);

%% initial velocity
VelocFinal = sqrt(2 * g * (125 - y0));

%% give final position based on velocity
PositionFinalX = x0 - VelocFinal^2/(2 * backGs * 9.81);
PositionFinalY = y0;
PositionFinalZ = z0;

%track length
LengthOfTrack = VelocFinal^2/(2 * backGs * 9.81);

%% write outputs

Outputs = [ PositionFinalX ; PositionFinalY ; z0] ;
TimeElapsed = [];
Outputs_G = [upGs];
Outputs_Loc = [ PositionFinalX ; PositionFinalY ; z0 ];
Outputs_Velocity = [ VelocFinal ] ;

end

