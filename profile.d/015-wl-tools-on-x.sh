#!/bin/bash

if [ -n "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && command -v xclip > /dev/null; then
    alias wl-copy='xclip -selection clipboard'
    alias wl-paste='xclip -selection clipboard -out'
fi
