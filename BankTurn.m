function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ArcLength] = BankTurn(Banktheta,t,raduis,x0,y0,z0, RollerCoasterHeight )
%% info

g = 9.81;

%% code
% Arc length
ArcLength = Banktheta * pi / 180 * raduis;
% height is fixed, thus velocity is.
v = sqrt ( 2 * g * (RollerCoasterHeight - y0)) ; 

% this normal force is devided by m.
Normal = (((v^2 )/raduis ) * sind(Banktheta)) + g*cosd(Banktheta) ;

% Lateral force
Lateral = -sind(Banktheta )*( g - (((v^2 )/raduis )*cosd(Banktheta ))) ;

% Gs felt in the direction normal to ramp
Normal_G = Normal / 9.81 ;

% Gs felt in the direction lateral to ramp
Lateral_G = Lateral / 9.81 ; 

%substuite from theta = 0 degrees to 180, the whole bank turn.
alphaRange = 0:.01:180 ;


% use the range of the angles in the equations for the postion in the x, y
% and z
CurrentZ = z0 - raduis + raduis*cosd(alphaRange);
CurrentX = x0 + raduis*sind(alphaRange);
CurrentY = y0 * ones(length(alphaRange),1) ; 

% write outputs
Outputs_G = [ Normal_G*ones(1,length(CurrentX)) ; Lateral_G*ones(1,length(CurrentX)) ];
ArcLength = [ArcLength];
Outputs_Loc = [ CurrentX  ; CurrentY' ; CurrentZ ] ;
Outputs_Velocity = [ ones(1,length(alphaRange))'*v ] ;
TimeElapsed = [];
fprintf('The banked turn generates a maximum magnitude of: %6.2f %12.8f and %6.2f %12.8f\n',Normal_G,Lateral_G )
fprintf(' G, normal and lateral, respectively. \n ' );




end