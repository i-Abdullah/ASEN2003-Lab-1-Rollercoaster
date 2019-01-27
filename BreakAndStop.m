function [TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity] = BreakAndStop(x0,y0,z0)

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

