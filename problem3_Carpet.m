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

s=arduino('/dev/cu.usbmodem25', 'uno');

%% Initialise servos
sv1 = servo(s, 'D3', 'MinPulseDuration', minPulse1, 'MaxPulseDuration', maxPulse1);
sv2 = servo(s, 'D5', 'MinPulseDuration', minPulse2, 'MaxPulseDuration', maxPulse2);
sv3 = servo(s, 'D6', 'MinPulseDuration', minPulse3, 'MaxPulseDuration', maxPulse3);
servo = [sv1, sv2, sv3]';
q = [0; 0; 0]; % In radians
moveServos(servo, q);
pause(2)


n = 3;
qs = zeros(3, n);
for i=1:n
    qs(:,i) = unifrnd(-pi/2,pi/2,[3,1]);
end
qs % Display qs

%% Moving the robot
for i = 1:20
    for j = 1:n
        moveServos(servo, qs(:,j));
        pause(0.5);
    end
end

