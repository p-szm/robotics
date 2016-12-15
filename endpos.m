function pos = endpos(q, l, varargin)

numvarargs = length(varargin);
if numvarargs > 1
    error('endpos:too many inputs');
elseif numvarargs == 1
    k = cell2mat(varargin(1));
else
    k = 4; % End effector
end

p0 = l(1) * [0; 1];
p1 = l(2) * [-sin(q(1)); cos(q(1))];
p2 = l(3) * [-sin(q(1)+q(2)); cos(q(1)+q(2))];
p3 = l(4) * [-sin(q(1)+q(2)+q(3)); cos(q(1)+q(2)+q(3))];

if k == 0
    pos = [0, 0]';
elseif k == 1
    pos = p0;
elseif k == 2
    pos = p0 + p1;
elseif k == 3
    pos = p0 + p1 + p2;
elseif k == 4
    pos = p0 + p1 + p2 + p3;
elseif k == -1
    pos = [p0, p0+p1, p0+p1+p2, p0+p1+p2+p3]';
else
    error('endpos:k should be between 0 and 4');
end