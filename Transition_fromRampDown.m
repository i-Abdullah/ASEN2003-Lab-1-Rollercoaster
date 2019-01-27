function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ArcLength ] = Transition_fromRampDown(t0,x0, y0, z0,theta, r)

g = 9.81;

%% begin calculations of position

ArcLength = theta * pi / 180 * r;

ThetaRange = (360 - theta : 360)';

CurrentY = y0 + r * cosd(360 - theta) - r * cosd(ThetaRange); %height as a function of theta

CurrentX = x0 - r * sind(360 - theta) + r * sind(ThetaRange);

CurrentZ = z0 * ones(length(ThetaRange),1);

CurrentV = sqrt(2 * g * (125 - CurrentY)); %velocity due to change in height

Normal = - g * cosd(ThetaRange) + CurrentV.^2/r; % Normal force / m

G = Normal/g;

fprintf('The transition out of the ramp generates a maximum magnitude of: %6.2f %12.8f \n ', abs(max(G)))
fprintf(' G, forward and upward. \n ' );

%% write output

TimeElapsed = [];
ArcLength = [ArcLength];  
Outputs_G = [ G' ] ;
Outputs_Loc = [ CurrentX' ; CurrentY' ; CurrentZ' ];
Outputs_Velocity = [ CurrentV' ] ;

end