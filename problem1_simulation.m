clear all;

% Motor paramters
minPulse1 = 400*10^-6;
maxPulse1 = 2200*10^-6;
minPulse2 = 400*10^-6;
maxPulse2 = 2200*10^-6;
minPulse3 = 270*10^-6;
maxPulse3 = 2050*10^-6;

% Arm lengths
l = [0.13, 0.149, 0.149, 0.14]';

q = [0; 0; 0]; % In radians

x_target = endpos(q,l);

figure
dx = [-0.004; -0.004];
for i=1:1000
    
    % Move the target
    if mod(i, 100) == 0
        dx = -dx;
    end
    x_target = x_target + dx;

    % IK
    for j=1:5
        q = q + pinv(J(q, l)) * (x_target - endpos(q, l));
    end
    q = mod(q, 2*pi);

    % Draw stuff
    draw_arm(q, l);
    hold on
    plot(x_target(1), x_target(2), 'r+')
    hold off
    pause(0.1)
end