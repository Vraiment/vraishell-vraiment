#!/bin/sh

# Custom/smart prompt with the following format:
#     {rc} [pwd]
#     dateTime user@host ?>
#
# Where:
#     rc = return code of the previous command
#     pwd = full path of the present working directory
#     dateTime = date and time in format YYYY/MM/DD@hh:mm:ssTZ
#     user = current user
#     host = the current host (cnan be personalized with $CUSTOM_PROMPT_HOST)
#
# The SC2034 warning is being disabled as the variables are kept for reference
__customGeneratePrompt() {
    _VRAI_SHELL_EXIT="$?"
    
    if [ -z "$CUSTOM_PROMPT_HOST" ]; then
        _VRAI_SHELL_HOST_NAME='\h'
    else
        _VRAI_SHELL_HOST_NAME="$CUSTOM_PROMPT_HOST"
    fi
    
    # shellcheck disable=SC2016
    _VRAI_SHELL_RED='\[$(tput setaf 1)\]'
    # shellcheck disable=SC2016
    _VRAI_SHELL_GREEN='\[$(tput setaf 2)\]'
    # shellcheck disable=SC2016,SC2034
    _VRAI_SHELL_BLUE='\[$(tput setaf 4)\]'

    # shellcheck disable=SC2016
    _VRAI_SHELL_CYAN='\[$(tput setaf 6)\]'
    # shellcheck disable=SC2016
    _VRAI_SHELL_YELLOW='\[$(tput setaf 3)\]'
    # shellcheck disable=SC2016
    _VRAI_SHELL_MAGENTA='\[$(tput setaf 5)\]'
    
    # shellcheck disable=SC2016,SC2034
    _VRAI_SHELL_BOLD='\[$(tput bold)\]'
    # shellcheck disable=SC2016
    _VRAI_SHELL_RESET='\[$(tput sgr0)\]'
    
    _VRAI_SHELL_CPWD="[$_VRAI_SHELL_YELLOW\$PWD$_VRAI_SHELL_RESET]"
    _VRAI_SHELL_DATE_TIME="$_VRAI_SHELL_MAGENTA\D{%G/%m/%d@%T%Z}$_VRAI_SHELL_RESET"
    _VRAI_SHELL_HOST_USER="$_VRAI_SHELL_CYAN\u@$_VRAI_SHELL_HOST_NAME$_VRAI_SHELL_RESET"
    
    if [ $_VRAI_SHELL_EXIT != 0 ]; then
        _VRAI_SHELL_RC="{$_VRAI_SHELL_RED$_VRAI_SHELL_EXIT$_VRAI_SHELL_RESET}"
    else
        _VRAI_SHELL_RC="{$_VRAI_SHELL_GREEN$_VRAI_SHELL_EXIT$_VRAI_SHELL_RESET}"
    fi
    
    export PS1="$_VRAI_SHELL_RC $_VRAI_SHELL_CPWD\n$_VRAI_SHELL_DATE_TIME $_VRAI_SHELL_HOST_USER \\$> "

    # This is to solve warning SC3043, /bin/sh does not support
    # `local` so I'm simulating that behavior here
    unset _VRAI_SHELL_BLUE _VRAI_SHELL_BOLD _VRAI_SHELL_CPWD _VRAI_SHELL_CYAN _VRAI_SHELL_DATE_TIME \
        _VRAI_SHELL_EXIT _VRAI_SHELL_GREEN _VRAI_SHELL_HOST_NAME _VRAI_SHELL_HOST_USER \
        _VRAI_SHELL_MAGENTA _VRAI_SHELL_RED _VRAI_SHELL_RESET _VRAI_SHELL_YELLOW
}
PROMPT_COMMAND=__customGeneratePrompt