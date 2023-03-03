#!/bin/bash

CURRENT_POLYBAR=$(pgrep polybar)
kill $CURRENT_POLYBAR

polybar bar

# Terminate already running bar instances
#killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit



# Startup programs

# POLYBAR
#killall polybar || true && polybar bar

# POLYBAR APPLETS
# killall nm-applet || true && nm-applet

# Launch Polybar, using default config location ~/.config/polybar/config.ini
#polybar bar 2>&1 | tee -a /tmp/polybar.log & disown
