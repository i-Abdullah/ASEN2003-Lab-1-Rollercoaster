function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity ] = ParabolaicHill(t0, y0, x0, z0, theta, a0, v)

%{ This function is to describe the motion of the cart on a parabolic hill. Using 
% Physics we know that this thing will be under projectile motion
% conditions (assuming no friction or air resistance). This means the cart
% will experience 0 G's the whole time. Paramtrize equations will be used to 
% 
%
%
%
%
%
%
%
%

g = 9.81;

vx = v*cosd(theta);

% time, all equations will be depnding on it.
vy = @(t) -g*t + v*sind(theta);
y = @(t) -(1/2)* g * t^2 + v*sind(theta) * t + y0 ;
x = @(t) vx*t + x0;


% place holders

CurrentX = [];
CurrentY = [];
CurrentZ = [];
CurrentVy = [];
CurrentVx = [];


% there's no way we will start from height == 0, so we will make it as 
% inital condition just to start the loop.

y_loop = y0+1 ;
i = 0 ; % time counter
TimeElapsed = i;
Outputs = [ CurrentX ; CurrentY ; CurrentVy ; CurrentVx ] ;

while y0<=y_loop
    
    CurrentX = [ CurrentX ; x(i) ] ;
    CurrentY = [ CurrentY ; y(i) ] ;
    CurrentZ = [ CurrentZ ; z0 ];
    CurrentVy = [ CurrentVy ; vy(i) ] ;
    CurrentVx = [ CurrentVx ; vx ] ;
    TimeElapsed = [ TimeElapsed ; i ] ;    
    y_loop = double(subs(y,i));
        i = i + 0.01;



    
end

%% write outputs 

    Outputs_Loc = [ CurrentX' ; CurrentY' ; CurrentZ' ] ;
    Outputs_Velocity = [ CurrentVy' ; CurrentVx' ] ;
    Outputs_G = [ zeros(1,length(CurrentX)) ] ;  


end