function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ] = BankTurn(Banktheta,raduis,x0,y0,z0, RollerCoasterHeight,g )
%% info


%% code

% height is fixed, thus velocity is.
v = sqrt ( 2 * g * (RollerCoasterHeight - z0)) ; 

% this normal force is devided by m.
Normal = (((v^2 )/raduis ) * sind(Banktheta)) + g*cosd(Banktheta) ;

% Lateral force
Lateral = -sind(Banktheta )*( g - (((v^2 )/raduis )*cosd(Banktheta ))) ;

% Gs felt in the direction normal to ramp
Normal_G = Normal / 9.81 ;

% Gs felt in the direction lateral to ramp
Lateral_G = Lateral / 9.81 ; 

% Symbolic function for position 
syms CurrentTheta

% alpha is the current angel from the horizontal that the particle is @
CurrentZ = z0 - raduis*sind(CurrentTheta);
CurrentX = x0 - raduis*cosd(CurrentTheta);
CurrentY = y0 ; 


%substuite from theta = 0 degrees to 180, the whole bank turn.
alphaRange = 0:0.01:180 ;

CurrentZ = [ z0 ; subs(CurrentZ,alphaRange)' ];
CurrentX = [ x0 ; subs(CurrentX,alphaRange)' ];
CurrentY = [ y0 ; ones(1,length(alphaRange))'*y0 ] ;

% write outputs
Outputs_G = [ Normal_G ; Lateral_G ];
Outputs_Loc = [ CurrentX  ; CurrentY ; CurrentZ ] ;
Outputs_Velocity = [ ones(1,length(alphaRange))'*v ] ;

end