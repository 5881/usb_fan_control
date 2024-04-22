#!/bin/zsh

OLDPWM=30
PWM=30

while [ true ]
do
#get temp
temp=$(sensors|grep "Package id 1:"|awk '{print $4}'|tr -d '+°C')
temp=${temp%.*} 
#get old pwm
if [ -e /tmp/old_pwm ]; then OLDPWM=$(head -1 /tmp/old_pwm); fi
#set new pwm
PWM=30
#if [ $temp -ge 40 ]; then PWM=30;fi
if [ $temp -ge 45 ]; then PWM=50;fi
if [ $temp -ge 50 ]; then PWM=70;fi
if [ $temp -ge 55 ]; then PWM=80;fi
if [ $temp -ge 60 ]; then PWM=90;fi
if [ $temp -ge 65 ]; then PWM=100;fi
#save new pwm as old
echo $PWM > /tmp/old_pwm
#if $PWM != $OLDPWM send command to device
if [ $PWM -ne $OLDPWM ]; then echo -n  "set $PWM $PWM $PWM\r" >> /dev/ttyACM0 ;fi
sleep 30
done

