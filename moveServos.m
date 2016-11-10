function moveServos(servo,q)
%MOVESERVOS Takes target angles and sends commands to servos

writePosition(servo(1), rad_to_servo(q(1)))
writePosition(servo(2), rad_to_servo(q(2)))
writePosition(servo(3), rad_to_servo(q(3)))

end