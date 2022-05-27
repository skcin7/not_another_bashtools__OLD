#!/bin/bash
# Bash useful functions.
#
# Copyright 2022 Nick Morgan




# Touch a directory (Create directory and change into it)
touchd() {
    local DIRECTORY_NAME;

    # Use first parameter as the directory name if one is provided, or prompt for input.
    if [ $# -eq 0 ]; then
        read -p "Enter Directory Name: " DIRECTORY_NAME
    else
        DIRECTORY_NAME=${1}
    fi

    # If directory name is an empty string, disable directory from being created.
    if [ -z "$DIRECTORY_NAME" ]; then
        echo "No directory name provided. Directory was not created."
        return 1;
    fi

    mkdir -p "${DIRECTORY_NAME}"
    cd "${DIRECTORY_NAME}"
#    echo "Created and changed to directory: ${DIRECTORY_NAME}";
    verbosem "Created and changed to directory: ${DIRECTORY_NAME}";
    #mkdir -p "$@" && cd "$@";
    return 0;
}