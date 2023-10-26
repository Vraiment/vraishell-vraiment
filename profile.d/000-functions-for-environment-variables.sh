# -----------------------------------------------------------------------------#
#  Author: Vraiment                                                            #
#                                                                              #
# These are a set of useful shell functions/commands to manage environment     #
# variables that contain a list of things, the main example would be the $PATH #
# variable, but is not limited to that (ex: Java's $CLASSPATH)                 #
# -----------------------------------------------------------------------------#

# Lists the entries in the variable with the name of the first argument
# ex: lsevar PATH
function lsevar {
    if [[ $# -ne 1 || -z ${!1+x} ]]; then
        return "$(false)"
    fi

    echo "${!1}" | tr ':' "\n"
}

# Verifies if the second argument is in the variable with the name of the first argument
# ex: grepevar PATH /bin
function grepevar {
    if [ $# -ne 2 ]; then
        return "$(false)"
    fi

    lsevar "$1" | grep "^$2$"
}

# Adds a new entry in the environment variable at the beginning of the variable
# ex: evarprepend PATH $HOME/bin
function evarprepend {
    if [ $# -ne 2 ]; then
        return "$(false)"
    fi

    if [ -z "${!1}" ]; then
        eval "$1=\$2"
    else
        eval "$1=\$2:\${!1}"
    fi
}

# Adds a new entry in the environment variable at the beginning of the variable
# ex: evarappend PATH $HOME/bin
function evarappend {
    if [ $# -ne 2 ]; then
        return "$(false)"
    fi

    if [ -z "${!1}" ]; then
        eval "$1=\$2"
    else
        eval "$1=\${!1}:\$2"
    fi
}

# Removes all duplicate entries from the environment variable leaving the first appearance
# ex: uniqevar PATH
function uniqevar {
    if [[ $# -ne 1 || -z ${!1+x} ]]; then
        return "$(false)"
    fi

    local entries
    for entry in $(lsevar "$1"); do
        if (grepevar entries "$entry") > /dev/null; then
            continue
        fi

        evarappend entries "$entry"
    done

    eval "$1=\$entries"
}

# PATH related commands

# Lists the entries in the PATH variable
# ex: lspath
function lspath {
    lsevar PATH
}

# Verifies if the second argument is in the PATH variable
# ex: greppath /bin
function greppath {
    grepevar PATH "$1"
}

# Removes all duplicate entries from the PATH environment variable leaving the first appearance
# ex: uniqpath
function uniqpath {
    uniqevar PATH
}

# Adds the first argument to the front of PATH if is not present
# ex: pathprepend $HOME/bin
function pathprepend {
    if [[ $# -ne 1 || $(greppath "$1") ]]; then
        return 1
    fi

    evarprepend PATH "$1"
}

# Adds the first argument to the back of PATH if is not present
# ex: pathappend /usr/local/bin
function pathappend {
    if [[ $# -ne 1 || $(greppath "$1") ]]; then
        return 1
    fi

    evarappend PATH "$1"
}
