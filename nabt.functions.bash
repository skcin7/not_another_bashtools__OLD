#!/bin/bash
# Not Another BashTools!
# A set of tools and utilities to be used within a bash shell.

#######################################
# Write a verbose message to stdout.
# ARGUMENTS:
#   Message to print
# OUTPUTS:
#   Writes verbose messages to stdout
# RETURN:
#   0
#######################################
nabt__message() {
    # Only if verbose mode is turned on.
    if [ $NABT__VERBOSE -eq 1 ]; then
        printf "$1\n";
    fi

    NABT__RETURN_CODE=0
    return 0
}

#######################################
# Execute the bootstrapper.
# ARGUMENTS:
#   (none)
# OUTPUTS:
#   Writes verbose messages to stdout
# RETURN:
#   0 if bootstrapper succeeds; non-zero on error
#######################################
nabt__execute_bootstrap() {
    figlet "Not Another: BashTools!"
    nabt__message "Bootstrapping..."


    # Export variables to be enabled throughout the entire environment.
    # `bin` and `sh` directories, so those binaries/scripts may be used.
    export PATH=$PATH:"${NABT__PATH}/bin"
    export PATH=$PATH:"${NABT__PATH}/sh"
    export NABT__VERBOSE=${NABT__VERBOSE}

    # Load aliases.
    alias "code=${NABT__CODE_COMMAND}"
    alias "hosts=code /etc/hosts"
    alias "ll=ls -lashG"

    # Load utilities
    for utility in ${NABT__UTILITIES[@]}; do
        source "${NABT__PATH}/utilities/${utility}.bash"
        nabt__message "\tLoaded Utility: ${utility}";
    done

    nabt__message "Bootstrapped."
    NABT__RETURN_CODE=0
    return 0;
}

#######################################
# Manually run the bootstrapper.
# ARGUMENTS:
#   (none)
# OUTPUTS:
#   Writes verbose messages to stdout
# RETURN:
#   0 if bootstrapper succeeds; non-zero on error
#######################################
nabt__bootstrap() {
#    nabt__message "Not Another BashTools! - Bootstrapping..."
    nabt__execute_bootstrap

#    if [ ${NABT__RETURN_CODE} -eq 0 ]; then
#        nabt__message "Not Another BashTools! - Bootstrapped!"
#    fi
}