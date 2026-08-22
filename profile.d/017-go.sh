#!/bin/sh

if [ -e "$HOME"/.local/opt/go/bin ]; then
    pathprepend "$HOME"/.local/opt/go/bin
    export GOROOT="$(go env GOROOT)"
fi
