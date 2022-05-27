#!/bin/bash
# Bash profile bootstrapper file. Source this from .bash_profile or .bashrc
#
# Copyright 2022 Nick Morgan

BASHPROFILE__DEBUGMODE=1
NOT_ANOTHER_BASHTOOLS__VERBOSE=1
BASHPROFILE__SOURCES=(
    ~/not_another_bashtools/functions.bash
    ~/not_another_bashtools/shellhelpers.bash
#    ~/not_another_bashtools/nginxhelpers.bash
    ~/not_another_bashtools/phphelpers.bash
#    ~/not_another_bashtools/shellsandbox.bash
#    ~/not_another_bashtools/shellsandbox_testutility.bash
    ~/not_another_bashtools/colors.bash
    ~/not_another_bashtools/getopt.bash
    $HOME/not_another_bashtools/parse_git_branch.bash
)
NOT_ANOTHER_BASHTOOLS__AUTOENABLED=1
NOT_ANOTHER_BASHTOOLS__RETURN_CODE=0












#
# Aliases
#
#BASHPROFILE__ALIASES=(
#    \"ll=ls -lashG\"
##    alias hosts="subl /etc/hosts"
##    alias code="subl"
##    alias which="which -a"
#)
## Load the Bash sources:
#for t in ${BASHPROFILE__ALIASES[@]}; do
##    alias $t
#    echo "${t}"
#done





# Print a message (only if verbose mode is on)
bash__verbosem() {
    if [ $NOT_ANOTHER_BASHTOOLS__VERBOSE -eq 1 ]; then
        echo "$1";
    fi
}


bash__load_source() {
    source "$1";
#    bash__verbosem "Sourced: $1";
}

bash__load_alias() {
    alias "$1=$2";
    bash__verbosem "Loaded Bash Alias: $1=$2";
}



# Execute the Bash bootstrapper.
not_another_bashtools__bootstrap() {
    local FUNCTION_RETURN_CODE=0

    bash__verbosem "Bootstrapping Yet Another BashTools..."

    export PATH=$PATH:"${NOT_ANOTHER_BASHTOOLS_DIRECTORY}/bin"
    export PATH=$PATH:"${NOT_ANOTHER_BASHTOOLS_DIRECTORY}/sh"

    #
    # Aliases:
    #
    bash__verbosem "Loading Bash Aliases..."
    bash__load_alias "code" "subl"
    bash__load_alias "hosts" "code /etc/hosts"
    bash__load_alias "ll" "ls -lashG"
    bash__verbosem ""
#    alias code="subl"
#    alias hosts="subl /etc/hosts"
#    alias ll="ls -lashG"


    #alias which="which -a"
    #alias sshconfig="subl ~/.ssh/config"
    #alias www="cd ~/www"
    #alias nick="cd ~/www/nicholas-morgan/"
    #alias vgdb="cd ~/www/vgdb/"
    #alias serve="php artisan serve"
    #alias bashprofile="subl ~/.bash_profile"
    #alias bashp="bashprofile"
    #mkcd() { mkdir -p "$@" && cd "$@"; }


    # Load the Bash sources:
    bash__verbosem "Loading Bash Sources..."
    for t in ${BASHPROFILE__SOURCES[@]}; do
        bash__load_source $t
        bash__verbosem "Sourced: $t";
    done
    bash__verbosem ""


    local BASHPROFILE__UTILITIES=(
        nginxhelpers.bash
        testutility.bash
    )
    bash__verbosem "Bash Utilities:"
    for t in ${BASHPROFILE__UTILITIES[@]}; do
        bash__verbosem $t;
        bash__load_source "$HOME/not_another_bashtools/utilities/$t"
    done
    bash__verbosem ""






    # Export variables that may be checked in other Bash sources.
#    export BASHPROFILE__DEBUGMODE=$BASHPROFILE__DEBUGMODE
    export NOT_ANOTHER_BASHTOOLS__VERBOSE=$NOT_ANOTHER_BASHTOOLS__VERBOSE


    bash__verbosem "Yet Another BashTools Bootstrapped."

    NOT_ANOTHER_BASHTOOLS__RETURN_CODE=${FUNCTION_RETURN_CODE}
    return ${FUNCTION_RETURN_CODE};
}
#alias bootstrap="not_another_bashtools__bootstrap"
alias bashtools__bootstrap="not_another_bashtools__bootstrap"
#alias bash_bootstrap="bashtools__bootstrap"


# Automatically run the bootstrapper if auto-enabled, otherwise, it must be enabled with the 'bootstrap' command.
if [ $NOT_ANOTHER_BASHTOOLS__AUTOENABLED -eq 1 ]; then
    res=$(not_another_bashtools__bootstrap)
    echo $?

    not_another_bashtools__bootstrap
fi