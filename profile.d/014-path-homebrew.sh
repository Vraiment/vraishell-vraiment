#!/bin/sh

if [ -d "/opt/local/bin" ]; then
    pathprepend "/opt/local/bin"
fi

if [ -d "/opt/homebrew/bin" ]; then
    pathprepend "/opt/homebrew/bin"
fi
