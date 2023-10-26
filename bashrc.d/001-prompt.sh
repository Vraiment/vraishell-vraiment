#!/bin/bash

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
function __customGeneratePrompt {
    local EXIT="$?"

    if [ -z "$CUSTOM_PROMPT_HOST" ]; then
        local HOST_NAME='\h'
    else
        local HOST_NAME="$CUSTOM_PROMPT_HOST"
    fi

    # shellcheck disable=SC2016
    local RED='\[$(tput setaf 1)\]'
    # shellcheck disable=SC2016
    local GREEN='\[$(tput setaf 2)\]'
    # shellcheck disable=SC2016,SC2034
    local BLUE='\[$(tput setaf 4)\]'

    # shellcheck disable=SC2016
    local CYAN='\[$(tput setaf 6)\]'
    # shellcheck disable=SC2016
    local YELLOW='\[$(tput setaf 3)\]'
    # shellcheck disable=SC2016
    local MAGENTA='\[$(tput setaf 5)\]'

    # shellcheck disable=SC2016,SC2034
    local BOLD='\[$(tput bold)\]'
    # shellcheck disable=SC2016
    local RESET='\[$(tput sgr0)\]'

    local CPWD="[$YELLOW\$PWD$RESET]"
    local DATE_TIME="$MAGENTA\D{%G/%m/%d@%T%Z}$RESET"
    local HOST_USER="$CYAN\u@$HOST_NAME$RESET"

    if [ $EXIT != 0 ]; then
        local RC="{$RED$EXIT$RESET}"
    else
        local RC="{$GREEN$EXIT$RESET}"
    fi

    export PS1="$RC $CPWD\n$DATE_TIME $HOST_USER \\$> "
}
PROMPT_COMMAND=__customGeneratePrompt
