function [TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ArcLength] = TransitionToDownRamp(r,theta,x0,y0,z0)

g = 9.81;

%% begin calculations of position

ArcLength = [theta * pi / 180 * r];

ThetaRange = (180 : (theta + 180))';

CurrentY = y0 - r - r * cosd(ThetaRange); %height as a function of theta

CurrentX = x0 - r * sind(ThetaRange);

CurrentZ = z0 * ones(length(ThetaRange),1);

CurrentV = sqrt(2 * g * (125 - CurrentY)); %velocity due to change in height

Normal = - g * cosd(ThetaRange) + CurrentV.^2/r; % Normal force / m

G = Normal/g;

fprintf('The transition to the ramp generates a maximum magnitude of: %6.2f %12.8f \n ', abs(max(G)))
fprintf(' G, forward and upward. \n ' );


%% write outputs

% All G's here are forward.
ArcLength = [ArcLength];
TimeElapsed = [];
Outputs_G = [ G' ] ;
Outputs_Loc = [ CurrentX' ; CurrentY' ; CurrentZ' ];
Outputs_Velocity = [ CurrentV' ] ;
end

