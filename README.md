#USB Fan control

Устройство контроля оборотов кулеров с USB интерфейсом. Имеются три независимых ШИМ канала, управление осуществляется текстовыми командами отправляемыми в виртуальный COM порт. Формат команды 'set X Y Z\r', где X Y Z  десятичные числа в интервале 20-100 представляющие собой степень заполнения ШИМ сигнала на выходах O1, O2, O3 микросхемы U2. Команда должна заканчиваться на `\r`.

Тк порт виртуальный, битрейт и чётность значения не имеют, поэтому отпровлять команду можно просто с помощью echo, добавление себя в группу `uucp` избавит от необходимости повышения привелегий.
  
1. $sudo usermod -aG uucp user
2. $echo -n "set X Y Z\r" >> /dev/ttyACM0

Скрипт temp_control.sh пример автоматического контроля оборотов вентиляторов в зависимости от температуры процессора. Перед использованием надо проверить и при необходимости исправить строку 9, под ваш вывод $sensors.

##Сборка
 1. $sudo pacman -S openocd arm-none-eabi-binutils arm-none-eabi-gcc arm-none-eabi-newlib arm-none-eabi-gdb
 2. $git clone https://github.com/5881/usb_fan_control.git
 3. $cd usb_fan_control
 4. $git submodule update --init # (Only needed once)
 5. $TARGETS=stm32/f1 make -C libopencm3 # (Only needed once)
 6. $make 
 7. $make flash

Candidum 2024
