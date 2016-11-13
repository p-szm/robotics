x = [];
y = [];
l = [0.13, 0.149, 0.149, 0.14]';

for i=0:0.05:1
    for j=0:0.05:1
        for k=0:0.05:1
            p = endpos(servo_to_rad([i,j,k])',l);
            x(end+1) = p(1);
            y(end+1) = p(2);
        end
    end
end

plot(x,y,'.')
xlim([-1,1])
ylim([-1,1])