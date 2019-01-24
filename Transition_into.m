function [TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity] = Transition_into(t0,x0, y0, z0,theta, Raduis)
%make transition to up, or into something that's above you.
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

%% write output

TimeElapsed = [];
Outputs_G = [ G' ] ;
Outputs_Loc = [ CurrentX' ; CurrentY' ; CurrentZ' ];
Outputs_Velocity = [ CurrentV' ] ;


end
