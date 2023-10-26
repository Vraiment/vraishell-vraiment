#!/bin/sh

# Forces things like git to use vim if vim is available
if type vim > /dev/null 2>&1; then
    export EDITOR=vim
fi

# Variables per operating system
case "$(uname -s)" in
    Darwin*)
        # Makes so "ls" output is colored
        export CLICOLOR=1
        export BASH_SILENCE_DEPRECATION_WARNING=1
        ;;
esac

# WSL specific environment variables
if uname -a | grep -i microsoft > /dev/null; then
    evarappend WIN_PATH "/mnt/c/Windows/System32"
    evarappend WIN_PATH "/mnt/c/Windows"
    evarappend WIN_PATH "/mnt/c/Program Files/dotnet" # For having the dotnet cli
    export WIN_PATH
fi

# Set the colors for LS
export LS_COLORS="di=34:ln=35:so=31:pi=36:ex=32:bd=30;46:cd=30;46:su=32:sg=32:tw=34;46:ow=34"

# Ensure the history size is huge
export HISTSIZE=10000

# Protect against the log4j nonsense
export JAVA_TOOL_OPTIONS="-Dlog4j2.formatMsgNoLookups=true ${JAVA_TOOL_OPTIONS}"

# For automatically managing the SSH agent
if command -v keychain > /dev/null; then
    keychain -q --nogui "$HOME/.ssh/id_rsa"
    # The following sourced file has the env variables for the SSH agent
    if [ -f "$HOME/.keychain/$(hostname)-sh" ]; then
        # shellcheck disable=SC1090
        . "$HOME/.keychain/$(hostname)-sh"
    fi
fi
