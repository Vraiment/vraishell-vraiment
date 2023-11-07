#!/bin/sh

# Configure "rbenv", for version 1.2.0
if [ -d "$HOME"/.rbenv/bin ]; then
    pathprepend "$HOME"/.rbenv/bin

    # The following `if` does two things:
    #   1. Attempt to detect if the `rbenv` function exists on a standard way
    #   2. Do so only for Bash and ZSh (because is the default on macOS)
    # Probably not a great idea to use $BASH_VERSION and $ZSH_VERSION to detect
    # the shell but is the simplest I can think of.
    if [ "$(command -v rbenv)" = "$HOME"/.rbenv/bin/rbenv ] && { [ -n "${BASH_VERSION+x}" ] || [ -n "${ZSH_VERSION+x}" ]; }; then
        pathprepend "$HOME"/.rbenv/shims

        # Set `RBENV_SHELL` based on `$BASH_VERSION`
        if [ -n "${BASH_VERSION+x}" ]; then
            export RBENV_SHELL=bash
        else
            export RBENV_SHELL=zsh
        fi

        command rbenv rehash 2> /dev/null

        rbenv() {
            # According to the ShellCheck documentation for this error, `local`
            # is formally not POSIX compliant but is pratically POSIX compliant,
            # both Bash and ZSh support it.
            # shellcheck disable=SC3043
            local command
            command="${1:-}"
            if [ "$#" -gt 0 ]; then
                shift
            fi

            case "$command" in
            rehash|shell)
                eval "$(rbenv "sh-$command" "$@")";;
            *)
                command rbenv "$command" "$@";;
            esac
        }
    fi
fi
