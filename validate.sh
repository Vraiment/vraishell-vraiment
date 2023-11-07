#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Propagate exit code on a pipeline
set -x # Print commands and their arguments as they are executed.

function main() {
    ensure-shellcheck
    validate-files
}

function ensure-shellcheck() {
    if ! command -v shellcheck; then
        >&2 echo shellcheck not found
        exit 1
    fi
}

function validate-files() {
    local file_list files_path files

    file_list=(
        validate.sh # Validate first the validate script itself
        bash_profile.d/*
        bashrc.d/*
        profile.d/*
    )
    readonly file_list

    files_path=$(mktemp)
    readonly files_path

    # I need a mechanism to skip files and Bash, asinine as it is, requires a very convoluted
    # way to acomplish it, put them into a file skipping the ones I don't want and then use
    # that file as an argument list.
    printf "%s\n" "${file_list[@]}" \
        | grep -v '^profile.d/000-functions-for-environment-variables.sh$' \
        > "$files_path"

    readarray -t files < "$files_path"
    readonly files

    rm "$files_path"

    shellcheck "${files[@]}"
}

main "$@"
