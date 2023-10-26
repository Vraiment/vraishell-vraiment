#!/bin/sh

# NVM is a bunch of functions rather than a $PATH entry
# but is the best place I can think to place this
if [ -s "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"

    if [ -s "$NVM_DIR/nvm.sh" ]; then
        # shellcheck disable=SC1091
        . "$NVM_DIR/nvm.sh"
    fi
fi
