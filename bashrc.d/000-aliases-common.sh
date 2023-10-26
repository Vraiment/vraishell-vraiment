#!/bin/sh

alias cls='clear'
# -p Forces vim to open files in tabs
alias vim='vim -p'
alias grep='grep --color'
alias grep='zgrep --color'

case "$(uname -s)" in
    Darwin*)
        # Easily reset the launchpad layout
        alias launchpad_reset='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
        ;;
    Linux*)
        # --color Adds colored output
        # -N Removes quotes from names with spaces
        alias ls='ls --color -N'

        # Makes it so you can open files with `open` in WSL
        if uname -r | grep -i microsoft > /dev/null; then
            alias open="cmd.exe /C start"
        fi
        ;;
esac
