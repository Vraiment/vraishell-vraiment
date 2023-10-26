# Configure "rbenv", for version 1.1.2
if [ -d "$HOME/.rbenv/bin" ]; then
    export PATH="$HOME/.rbenv/bin:${PATH}"
fi

if [[ $(type -t rbenv) == "file" ]]; then
    export PATH="$HOME/.rbenv/shims:${PATH}"
    export RBENV_SHELL=bash

    command rbenv rehash 2>/dev/null

    rbenv() {
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
