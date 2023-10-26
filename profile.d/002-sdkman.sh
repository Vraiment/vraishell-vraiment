#!/bin/sh

# Initialize sdkman
SDKMAN_DIR="$HOME/.sdkman"
if [ -d "$SDKMAN_DIR" ]; then
    export SDKMAN_DIR
    # shellcheck disable=SC1091
    [ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ] && . "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi
