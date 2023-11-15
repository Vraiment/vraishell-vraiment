#!/bin/sh

# Lists the entries in the variable with the name of the first argument
# ex: lsevar PATH
lsevar() {
    if [ $# -ne 1 ] || [ -z "$(eval echo \$"$1")" ]; then
        return 1
    fi

    eval echo \$"$1" | tr ':' "\n"
}

# Verifies if the second argument is in the variable with the name of the first argument
# ex: grepevar PATH /bin
grepevar() {
    if [ $# -ne 2 ]; then
        return 1
    fi

    lsevar "$1" | grep "^$2$"
}

# Adds a new entry in the environment variable at the beginning of the variable
# ex: evarprepend PATH $HOME/bin
evarprepend() {
    if [ $# -ne 2 ]; then
        return 1
    fi

    if [ -z "$(eval echo \$"$1")" ]; then
        eval "$1=\$2"
    else
        eval "$1=\$2:\"\$$1\""
    fi
}

# Adds a new entry in the environment variable at the beginning of the variable
# ex: evarappend PATH $HOME/bin
evarappend() {
    if [ $# -ne 2 ]; then
        return 1
    fi

    if [ -z "$(eval echo \$"$1")" ]; then
        eval "$1=\$2"
    else
        eval "$1=\"\$$1\":\$2"
    fi
}

# Removes all duplicate entries from the environment variable leaving the first appearance
# ex: uniqevar PATH
uniqevar() {
    if [ $# -ne 1 ] || [ -z "$(eval echo \$"$1")" ]; then
        return 1
    fi

    _entries=''
    for _entry in $(lsevar "$1"); do
        if (grepevar _entries "$_entry") > /dev/null; then
            continue
        fi

        evarappend _entries "$_entry"
    done
    unset _entry

    eval "$1=\$_entries"

    unset _entries
}

# PATH related commands

# Lists the entries in the PATH variable
# ex: lspath
lspath() {
    lsevar PATH
}

# Verifies if the second argument is in the PATH variable
# ex: greppath /bin
greppath() {
    grepevar PATH "$1"
}

# Removes all duplicate entries from the PATH environment variable leaving the first appearance
# ex: uniqpath
uniqpath() {
    uniqevar PATH
}

# Adds the first argument to the front of PATH if is not present
# ex: pathprepend $HOME/bin
pathprepend() {
    if [ $# -ne 1 ] || greppath "$1" > /dev/null; then
        return 1
    fi

    evarprepend PATH "$1"
}

# Adds the first argument to the back of PATH if is not present
# ex: pathappend /usr/local/bin
pathappend() {
    if [ $# -ne 1 ] || greppath "$1" > /dev/null; then
        return 1
    fi

    evarappend PATH "$1"
}
