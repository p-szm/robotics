function angle = servo_to_rad(q)

angle = mod(pi*(q - 0.5), 2*pi);