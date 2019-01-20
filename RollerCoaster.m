%% info

%% housekeeping

clear;
clc;
close all;

%% define constants

g = 9.81;
h0 = 125 ; %initial height in meters
m = 70;

%% velc

syms h
v(h) = sqrt ( 2 * g * (h0 - h)) ; 


%% define all inital conditions for the first segment

Vi = double(v(h0)); %initial velocity
Ti = 0; %time in s
Xi = 0; % in m
Yi = h0; % in m



%% segment 1: circles 

raudis = 1;

%% Call ramp down function

% Initial conditions for ramp
ThetaRamp = 30; % in degree
LengthRamp = 10; % in m
a0 = g * sind( ThetaRamp );

[k1 k2 k3 k4 k5 k6] = RampDown(Vi,a0,0,Ti,ThetaRamp,LengthRamp,h0);
