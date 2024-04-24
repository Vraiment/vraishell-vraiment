#!/bin/sh

if [ -e "$HOME"/.cargo/env ]; then
    # shellcheck disable=SC1091
    . "$HOME"/.cargo/env
fi
