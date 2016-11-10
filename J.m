function jac = J(q, l)

l1 = l(2);
l2 = l(3);
l3 = l(4);

jac = [-l3*cos(q(1)+q(2)+q(3))-l2*cos(q(1)+q(2))-l1*cos(q(1)),  -l3*cos(q(1)+q(2)+q(3))-l2*cos(q(1)+q(2)), -l3*cos(q(1)+q(2)+q(3));
       -l3*sin(q(1)+q(2)+q(3))-l2*sin(q(1)+q(2))-l1*sin(q(1)),  -l3*sin(q(1)+q(2)+q(3))-l2*sin(q(1)+q(2)), -l3*sin(q(1)+q(2)+q(3))];