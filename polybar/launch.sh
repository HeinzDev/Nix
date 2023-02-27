#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar mybar &

# Launch Polybar, using default config location ~/.config/polybar/config.ini
#polybar bar 2>&1 | tee -a /tmp/polybar.log & disown


