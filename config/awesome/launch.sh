#!/bin/bash

CURRENT_POLYBAR=$(pgrep polybar)
kill $CURRENT_POLYBAR

polybar bar

