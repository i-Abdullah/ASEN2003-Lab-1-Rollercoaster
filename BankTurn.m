function [ Time Outputs_G Outputs_Loc ] = BankTurn(BankAngle,raduis,x0,y0,z0, RollerCoasterHeight,g )
%% info


%% code

% height is fixed, thus velocity is.
v = sqrt ( 2 * g * (RollerCoasterHeight - z0)) ; 
% this normal force is devided by m.
Normal = (((v^2 )/raduis ) * sind(BankAngle)) + g*cosd(BankAngle) ;
% Lateral force
Lateral = -sind(BankAngle )*( g - (((v^2 )/raduis )*cosd(BankAngle ))) ;

% Gs felt in the direction normal to ramp
Normal_G = Normal / 9.81 ;

% Gs felt in the direction lateral to ramp
Lateral_G = Lateral / 9.81 ; 

% Symbolic function for position 
syms alpha1

% alpha is the current angel from the horizontal that the particle is @
CurrentZ = z0 - raduis*sind(alpha1);
CurrentX = x0 - raduis*cosd(alpha1);
CurrentY = y0 ; 

alphaRange = 0:0.01:180 ;

CurrentZ = [ z0 ; subs(CurrentZ,alphaRange)' ];
CurrentX = [ x0 ; subs(CurrentX,alphaRange)' ];
CurrentY = [ y0 ; ones(1,length(alphaRange))'*y0 ] ;

Outputs_G = [ Normal_G ; Lateral_G ];
Outputs_Loc = [ CurrentX  ; CurrentY ; CurrentZ ] ;


end