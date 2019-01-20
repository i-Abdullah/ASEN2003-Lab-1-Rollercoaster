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

%% segment 1: circles 

raudis = 1;



