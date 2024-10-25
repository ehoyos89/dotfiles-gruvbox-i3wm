#!/bin/bash

# Encuentra el archivo de brillo correcto
kbd_backlight=$(find /sys/class/leds -name "*kbd_backlight" | head -n 1)
brightness_file="$kbd_backlight/brightness"
max_file="$kbd_backlight/max_brightness"

# Lee el brillo actual y máximo
current=$(cat $brightness_file)
max=$(cat $max_file)

# Ajusta el brillo
if [ "$1" = "up" ]; then
  new=$((current + 1))
elif [ "$1" = "down" ]; then
  new=$((current - 1))
else
  echo "Usage: $0 up|down"
  exit 1
fi

# Asegúrate de que el nuevo valor esté dentro del rango permitido
new=$(( new < 0 ? 0 : new > max ? max : new ))

# Escribe el nuevo valor
echo $new | sudo tee $brightness_file
