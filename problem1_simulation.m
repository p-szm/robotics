close all;
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

x = [];
y = [];
for i=0:0.05:1
    for j=0:0.05:1
        for k=0:0.05:1
            p = endpos(servo_to_rad([i,j,k])',l);
            x(end+1) = p(1);
            y(end+1) = p(2);
        end
    end
end

q = [0.1; 0.1; 0.1]; % In radians

x_target = endpos(q,l);

pen = @(q) 4/pi^2 * atan2(sin(q),cos(q)).^3;
cost = zeros(1,0);

iters = 200;
for i=1:iters
    
    % Move the target
    if i == 1
        dx = [0.015; -0.01];
    elseif i == 20
        dx = [-0.015; 0];
    elseif i == 40
        dx = [0.01; 0.02];
    elseif i == 46
        dx = [0; -0.01];
    elseif i == 60
        dx = [-0.01; 0];
    elseif i == 80
        dx = [0; -0.01];
    elseif i == 110
        dx = [-0.01; 0];
    elseif i == 120
        dx = [0.002; 0.01];
    elseif i == 150
        dx = [0.01; 0];
    end
    x_target = x_target + dx;

    % IK
    q_prev = q;
    for j=1:10
        q = q + 0.1*pinv(J(q, l)) * (x_target - endpos(q, l)) + 0.1*(pinv(J(q,l))*J(q,l)-eye(3))*pen(q);
    end
    cost(1,end+1) = 0.5*norm(q - q_prev + pen(q))^2;
    
    figure(2)
    plot(cost, '-')
    title('Cost')
    xlim([0,iters])
    ylim([0,3])

    % Draw stuff
    figure(1)
    plot(x,y,'.','Color',[0.9,0.9,0.9])
    hold on
    draw_arm(q, l);
    hold on
    plot(x_target(1), x_target(2), 'r+')
    hold off
    axis equal
    pause(0.1)
end