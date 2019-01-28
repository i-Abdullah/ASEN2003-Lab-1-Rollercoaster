function [ TimeElapsed Outputs_G Outputs_Loc Outputs_Velocity Arclength ] = ParabolaicHill(t0, y0, x0, z0, theta, a0, v)
% 
% ASEN 2003: Dynamics, Lab 1, Roller Coaster
%
%{

Done by:
- Abdullah AlMugirun
- Mohamed Aichiouene
- Aufa Amirullah
- Abdulla AlAmeri

This function is one segment of a roller coaster, it attempts to module the
Parabolaic Hill. This segment follows the free-fall conditions, and hence
the G's will be == 0 ;

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Inputs:

Inputs:

1-  t0: initial time relative to the whole roller coaster when
the cart started going on the ramp.

2- y0: initial y position.

3- x0: initial x position.

4- z0: initial y position.

5- theta: angel of initial object @ the beginning, just like lunching an
object from a cannon.

6- a0: inital accelration.

7- v: initial velocity. 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


Outputs: 

1- TimeElapsed : time just spent on this segment.

2- Outputs_G: G's at eaxh (x,y,z) coordinate.

3- Outputs_Loc: [ 3 x n ], where each column is one point in (x,y,z).

4- Outputs_Velocity: Velocity at each point on the rollercoaster.

5- Arclength : which is equivalent to the total distance covered. 


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


%}


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

%Calculate the arc length of the parabola
b = CurrentX(end) - x0;
a = max(CurrentY) - y0;
s = sqrt(b^2+(16*a^2));
Arclength = (s/2) + (b^2/(8*a)) * log(((4*a)+s)/b);
%% write outputs 
Arclength = [Arclength];
    Outputs_Loc = [ CurrentX' ; CurrentY' ; CurrentZ' ] ;
    Outputs_Velocity = [ CurrentVy' ; CurrentVx' ] ;
    Outputs_G = [ zeros(1,length(CurrentX)) ] ; 
    G = zeros(1,length(CurrentX));
fprintf('The parabolic hill generates a maximum magnitude of: %6.2f %12.8f \n ', abs(max(G)))
fprintf(' G, forward and upward. \n ' );


end