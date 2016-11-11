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

s=arduino();

% Initialise servos
sv1 = servo(s, 'D3', 'MinPulseDuration', minPulse1, 'MaxPulseDuration', maxPulse1);
sv2 = servo(s, 'D5', 'MinPulseDuration', minPulse2, 'MaxPulseDuration', maxPulse2);
sv3 = servo(s, 'D6', 'MinPulseDuration', minPulse3, 'MaxPulseDuration', maxPulse3);
servo = [sv1, sv2, sv3]';
pause(2)

q = [0.1; 0.1; 0.1]; % In radians

x_target = endpos(q,l);

figure
dx = [-0.03; -0.02];
for i=1:100
    
    % Move the target
    if mod(i, 10) == 0
        dx = -dx;
    end
    x_target = x_target + dx;

    % IK
    for j=1:5
        q = q + pinv(J(q, l)) * (x_target - endpos(q, l));
    end
    q = mod(q, 2*pi);
    
    moveServos(servo, q);

    % Draw stuff
    draw_arm(q, l);
    hold on
    plot(x_target(1), x_target(2), 'r+')
    hold off
    pause(0)
end




