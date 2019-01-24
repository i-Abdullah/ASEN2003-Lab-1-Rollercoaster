function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ] = Transition_out(t0,x0, y0, z0,theta, Raduis,Direction)
%%
% make transition to down, or into something that's below you.

% Direction : 1 == clock wise exist
%             0 == counter-clock wise exist
%% Gravity
g = 9.81;
%% Tangent normal coordinate system
ArceLength = theta * pi / 180 * Raduis;

ThetaRange = (180:(180 + theta))';


% if both + + after y0, you'll start from the bottom.
% if both - - after y0, you'll start from the top.

CurrentY = y0 + Raduis + Raduis * cosd(ThetaRange); %height as a function of theta

if Direction == 1 % if 1 you'll start @ 270 deg. and go cc-wise, from bottom
CurrentX = x0 - Raduis * sind(ThetaRange);
else Direction == 0 % if 0 you'll start @ 270 deg, and go c-wise, from bottom
CurrentX = x0 + Raduis * sind(ThetaRange);
end

CurrentV = sqrt(2 * g * (125 - CurrentY)); %velocity due to change in height

Normal = CurrentV.^2/Raduis - g .* cosd(ThetaRange); % Normal force / m

G = Normal/g;

downG = G;

CurrentZ = z0 * ones(length(ThetaRange),1);

%% write outputs 

TimeElapsed = [];
Outputs_G = [ G' ] ;
Outputs_Loc = [ CurrentX' ; CurrentY' ; CurrentZ' ];
Outputs_Velocity = [ CurrentV' ] ;



end