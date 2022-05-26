#!/bin/bash
# Bash profile bootstrapper file. Source this from .bash_profile or .bashrc
#
# Copyright 2022 Nick Morgan

BASHPROFILE__DEBUGMODE=1
BASHPROFILE__VERBOSE=1
BASHPROFILE__SOURCES=(
    ~/bash/functions.bash
    ~/bash/shellhelpers.bash
#    ~/bash/nginxhelpers.bash
    ~/bash/phphelpers.bash
#    ~/bash/shellsandbox.bash
#    ~/bash/shellsandbox_testutility.bash
    ~/bash/colors.bash
    ~/bash/getopt.bash
    $HOME/bash/parse_git_branch.bash
)
BASHPROFILE__BIN_DIRECTORY=$HOME/bash/bin
BASHPROFILE__SH_DIRECTORY=$HOME/bash/sh
BASHPROFILE__AUTOENABLED=1












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
    if [ $BASHPROFILE__VERBOSE -eq 1 ]; then
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
bash__execute_bootstrapper() {
    bash__verbosem "Bootstrapping Bash..."

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
        bash__load_source "$HOME/bash/utilities/$t"
    done
    bash__verbosem ""



    bash__verbosem "Directories:"
    export PATH=$PATH:$BASHPROFILE__BIN_DIRECTORY
    bash__verbosem "bin: $BASHPROFILE__BIN_DIRECTORY"
    export PATH=$PATH:$BASHPROFILE__SH_DIRECTORY
    bash__verbosem "sh: $BASHPROFILE__SH_DIRECTORY"
    bash__verbosem ""


    # Export variables that may be checked in other Bash sources.
    export BASHPROFILE__DEBUGMODE=$BASHPROFILE__DEBUGMODE
    export BASHPROFILE__VERBOSE=$BASHPROFILE__VERBOSE


    bash__verbosem "Bash Bootstrapped."
}
alias bootstrap="bash__execute_bootstrapper"


# Automatically run the bootstrapper if auto-enabled, otherwise, it must be enabled with the 'bootstrap' command.
if [ $BASHPROFILE__AUTOENABLED -eq 1 ]; then
    bootstrap
fi