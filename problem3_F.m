% Problem 3
clear all;
clc

% Motor paramters
minPulse1 = 400*10^-6;
maxPulse1 = 2200*10^-6;
minPulse2 = 400*10^-6;
maxPulse2 = 2200*10^-6;
minPulse3 = 270*10^-6;
maxPulse3 = 2050*10^-6;

% Arm lengths
l = [0.14, 0.149, 0.149, 0.14]';

s=arduino();

%% Initialise servos
sv1 = servo(s, 'D3', 'MinPulseDuration', minPulse1, 'MaxPulseDuration', maxPulse1);
sv2 = servo(s, 'D5', 'MinPulseDuration', minPulse2, 'MaxPulseDuration', maxPulse2);
sv3 = servo(s, 'D6', 'MinPulseDuration', minPulse3, 'MaxPulseDuration', maxPulse3);
servo = [sv1, sv2, sv3]';
q = [pi/4; pi/2; pi/4]; % In radians
moveServos(servo, q);
pause(2)
%% Define Trajectory
counter = 0;
rel_pos = []; 
for x = 0:0.0005:0.07
    y = -x^2+0.07*x;
    counter = counter+1;
    rel_pos(counter, :) = [-x y];
end

%% Moving the robot
for i = 1:10


q = [pi/2; pi/2; -pi/2];
moveServos(servo, q);
draw_arm(q, l);
pause(0.5);
q = [pi/2; -pi/2; -pi/2];
moveServos(servo, q);
draw_arm(q, l);
pause(0.5);
q = [-pi/2; -pi/2; -pi/2];
moveServos(servo, q);
draw_arm(q, l);
pause(0.5);
q = [-pi/2; pi/2; -pi/2];
moveServos(servo, q);
draw_arm(q, l);
pause(0.5);

end

