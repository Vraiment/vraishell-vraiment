#!/bin/sh

# Adds user's personal bin directory
if [ -d "$HOME/bin" ] ; then
    pathprepend "$HOME/bin"
fi

# Add users's personal local bin directory
if [ -d "$HOME/.local/bin" ] ; then
    pathprepend "$HOME/.local/bin"
fi

# Tools installed from DotNet CLI
if [ -d "$HOME/.dotnet/tools" ]; then
    pathprepend "$HOME/.dotnet/tools"
fi
