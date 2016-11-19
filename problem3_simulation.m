% Problem 3 _ Simulation
clear all;
close all

% Motor paramters
minPulse1 = 400*10^-6;
maxPulse1 = 2200*10^-6;
minPulse2 = 400*10^-6;
maxPulse2 = 2200*10^-6;
minPulse3 = 270*10^-6;
maxPulse3 = 2050*10^-6;

% Arm lengths
l = [0.13, 0.149, 0.149, 0.14]';

q = [pi/2; 0.1; pi/2]; % In radians

x_target = endpos(q,l);

counter = 0;
xtargets = []; 
for x = 0:0.0005:0.07
    counter = counter+1;
    xtargets(:,counter) = [x;-x^2+0.07*x];
end
    
xtargets(1,:) = xtargets(1,:) - 0.3;
xtargets(2,:) = xtargets(2,:)*50;

figure
dx = [-0.03; -0.02];
for i=1:141
    
    
    % Move the target
    if mod(i, 10) == 0
        dx = -dx;
    end
    %x_target = x_target + dx;
    x_target = xtargets(:,i);
    % IK
    for j=1:5
        q = q + pinv(J(q, l)) * (x_target - endpos(q, l));
    end
    q = mod(q, 2*pi);
    q
    % Draw stuff
    draw_arm(q, l);
    hold on
    plot(x_target(1), x_target(2), 'r+')
    hold off
    pause(0.001)
end

% reverse l values to change end effector
% templ = l;
% tempq = q;
% for i = 1:4
%     l(i) = templ(5-i);
%     q(i) = tempq(5-i);
% end
% define new traj
x = endpos(q)
% follow traj

