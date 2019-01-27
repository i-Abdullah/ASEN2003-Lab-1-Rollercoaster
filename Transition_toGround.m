function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ArcLength] = Transition_toGround(x0, y0, z0,theta, radius)

g = 9.81;

%% begin calculations of position

ArcLength = theta * pi / 180 * radius;

ThetaRange = (theta:-1:0)';

% get location
CurrentY = y0 + radius * cosd(theta) - radius * cosd(ThetaRange); %height as a function of theta

CurrentX = x0 - radius * sind(theta) + radius * sind(ThetaRange);

CurrentZ = z0 * ones(length(ThetaRange),1);

CurrentV = sqrt(2 * g * (125 - CurrentY)); %velocity due to change in height

Normal = g * cosd(ThetaRange) + CurrentV.^2/radius; % Normal force / m

G = Normal/g;

fprintf('The transition to ground generates a maximum magnitude of: %6.2f %12.8f \n ', abs(max(G)))
fprintf(' G, forward and backward. \n ' );

%% write output

TimeElapsed = [];
ArcLength = [ArcLength];
Outputs_G = [ G' ] ;
Outputs_Loc = [ CurrentX' ; CurrentY' ; CurrentZ' ];
Outputs_Velocity = [ CurrentV' ] ;

end
