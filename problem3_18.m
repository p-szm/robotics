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
l = [0.13, 0.149, 0.149, 0.14]';

s=arduino();

%% Initialise servos
sv1 = servo(s, 'D3', 'MinPulseDuration', minPulse1, 'MaxPulseDuration', maxPulse1);
sv2 = servo(s, 'D5', 'MinPulseDuration', minPulse2, 'MaxPulseDuration', maxPulse2);
sv3 = servo(s, 'D6', 'MinPulseDuration', minPulse3, 'MaxPulseDuration', maxPulse3);
servo = [sv1, sv2, sv3]';
pause(2)

q = [-pi/2; -0.3; -pi/2]; % In radians
% x_target = endpos(q,l);
moveServos(servo, q);
pause(1)


dx = [-0.03; -0.02];
%% Define Trajectory
counter = 0;
xtargets = []; 
for x = 0:0.0005:0.07
    y = -x^2+0.07*x;
    counter = counter+1;
    xtargets(counter, :) = [x y];
end

%% Moving the robot
x_target = [0 0]';
for i=1:length(xtargets(:,1))
    i
    % Move the target
%     if mod(i, 10) == 0
%         dx = -dx;
%     end
%     
    % x_target loop here
    x_target = xtargets(i, :)';
    % x_target = x_target + dx;

    % IK
    for j=1:5
        q = q + pinv(J(q, l)) * (x_target - endpos(q, l));
    end
    q = mod(q, 2*pi);
    
    moveServos(servo, q);

%     % Draw stuff
%     draw_arm(q, l);
%     hold on
%     plot(x_target(1), x_target(2), 'r+')
%     hold off
    pause(0)
end

















% x_target = endpos(q,l);
% 
% counter = 0;
% x_target = []; 
% for x = 0:0.0005:0.07
%     counter = counter+1;
%     x_target(:,counter) = [x;-x^2+0.07*x];
% end
%     
% 
% 
% dx = [0; -0.005];
% for x = 0:0.0005:0.07
%     
% %     % Move the target
% %     if mod(i, 20) == 0
% %         dx = -dx;
% %     end
% %     
%     x_target = -x^2+0.07*x;
%     x_target = x_target + dx;
% 
%     % IK
%     for j=1:5
%         q = q + pinv(J(q, l)) * (x_target - endpos(q, l));
%     end
%     q = mod(q, 2*pi);
%     
%     moveServos(servo, q);
% 
%     % Draw stuff
%     draw_arm(q, l);
%     hold on
%     plot(x_target(1), x_target(2), 'r+')
%     hold off
%     pause(0.1)
% end
% 
% 
% 

