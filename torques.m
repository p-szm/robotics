function tqs = torques(q, m, n, l)

if size(q,1) ~= 3
    error('Wrong q');
elseif size(m,1) ~= 3
    error('Wrong m');
elseif size(n,1) ~= 4
    error('Wrong n');
elseif size(l,1) ~= 4
    error('Wrong l');
end

g = -9.81;

pos = endpos(q, l, -1); % Position of nodes
pos = pos(:,1); % Only x coord matter
mid_pos = 0.5*[pos(1)+pos(2); pos(2)+pos(3); pos(3)+pos(4)]; % Mid-positions of links

t1 = sum(pos .* n * g) + sum(mid_pos .* m * g);
t2 = sum([0;1;1;1].*(pos-pos(2)) .* n * g) + sum([0;1;1].*(mid_pos-pos(2)) .* m * g);
t3 = sum([0;0;1;1].*(pos-pos(3)) .* n * g) + sum([0;0;1].*(mid_pos-pos(3)) .* m * g);

tqs = -[t1;t2;t3];