function angle = rad_to_servo(q)

angle = mod(mod(q, 2*pi)/pi + 0.5, 2);
angle(angle > 1) = 1;