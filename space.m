x = [];
y = [];

l = [0.13, 0.149, 0.149, 0.14]';
m = [0.05;0.011;0.011];
n = [0.09;0.09;0.09;0];
max_torque = 0.3044;

ds = 0.04;
for i=0:ds:1
    for j=0:ds:1
        for k=0:ds:1
            q = servo_to_rad([i,j,k])';
            p = endpos(q,l);
            if all(abs(torques(q, m, n, l)) < max_torque)
                x(end+1) = p(1);
                y(end+1) = p(2);
            end
        end
    end
end

figure('Position', [300,300,500,500])
plot(x,y,'.')
xlim([-0.5,0.5])
ylim([-0.3,0.7])
hold on

N = 50;
x = -0.18 + 0.1*cos(2*pi*linspace(0,N/2,N)/N);
y = 0.35 + 0.1*sin(2*pi*linspace(0,N/2,N)/N);
%plot(x,y,'r', 'LineWidth', 2);
draw_arm([-0.1,0.3,0.4], l)
hold off
axis equal
