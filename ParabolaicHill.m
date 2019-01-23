function [ time Outputs ] = ParabolaicHill(t0, y0, x0, z0, theta, a0, v)

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

syms t % time, all equations will be depnding on it.

vy(t) = -g*t + v*sind(theta);
y(t) = -(1/2)* g * t^2 + v*sind(theta) * t + y0 ;
x(t) = vx*t + x0;


% place holders

CurrentX = [];
CurrentY = [];
CurrentVy = [];
CurrentVx = [];


% there's no way we will start from height == 0, so we will make it as 
% inital condition just to start the loop.

y_loop = y0+1 ;
i = 0 ; % time counter
time = i;
Outputs = [ CurrentX ; CurrentY ; CurrentVy ; CurrentVx ] ;

while y0<=y_loop
    
    CurrentX = [ CurrentX ; double(x(i)) ] ;
    CurrentY = [ CurrentY ; double(y(i)) ] ;
    CurrentVy = [ CurrentVy ; double(vy(i)) ] ;
    CurrentVx = [ CurrentVx ; vx ] ;
    time = [ time ; i ] ;    
    y_loop = double(y(i));
        i = i + 0.001;



    
end

    Outputs = [ CurrentX' ; CurrentY' ; CurrentVy' ; CurrentVx' ] ;


end