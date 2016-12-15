function draw_arm(q, l)

p0 = endpos(q, l, 0);
p1 = endpos(q, l, 1);
p2 = endpos(q, l, 2);
p3 = endpos(q, l, 3);
p4 = endpos(q, l, 4);
plot([p0(1), p1(1), p2(1), p3(1), p4(1)], [p0(2), p1(2), p2(2), p3(2), p4(2)], 'r-', 'LineWidth', 1)
hold on
plot([p1(1), p2(1), p3(1)], [p1(2), p2(2), p3(2)], 'ro', 'LineWidth', 1)
plot([-0.05,0.05], [0,0], 'r-', 'LineWidth', 1)
hold off
xlim([-0.6,0.6])
ylim([-0.3,0.9])