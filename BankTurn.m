function [ Time Outputs_G Outputs_Loc ] = BankTurn(BankAngel,raduis, x0,y0,z0, RollerCoasterHeight,g )
%% info


%% code

% height is fixed, thus velocity is.

v = sqrt ( 2 * g * (RollerCoasterHeight - z0)) ; 
% this normal force is devided by m.
Normal = (((v^2 )/raduis ) * sind(BankAngel)) + g*cosd(BankAngel) ;
% Lateral force
Lateral = sind(theta)*( g - (((v^2 )/raduis )*cosd(theta))) ;


Normal_G = Normal / 9.81 ;

Lateral_G = Lateral / 9.81 ; 

syms alpha % alpha is the current angel from the horizontal that the particle is @

CurrentZ = z0 - raduis*sind(alpha);
CurrentX = x0 - r*cosd(alpha);
CurrentY = y0 ; 

alphaRange = 0:0.01:180 ;

CurrentZ = [ z0 ; double(CurrentZ(alphaRange)) ];
CurrentX = [ x0 ; double(CurrentX(alphaRange)) ];
CurrentY = [ y0 ; ones(length(alphaRange))*y0 ] ;

Outputs_G = [ Normal_G ; Lateral_G ];
Outputs_Loc = [ CurrentX  ; CurrentY ; CurrentZ ] ;


end