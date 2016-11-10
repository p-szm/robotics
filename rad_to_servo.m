function angle = rad_to_servo(q)

angle = mod(q, 2*pi)/pi + 0.5;