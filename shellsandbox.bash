#!/bin/bash
# Sandbox where I get to fuck around with the bash shell with impunity.
#
# Copyright 2022 Nick Morgan
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# fun: shellsandbox
# txt: Print a message to the shell
# use: shellsandbox "shell message"
# use: shellsandbox -f "forced shell message"
function shellsandbox() {

	# if the force option is passed, then print the message
    local OPTIND o a
    while getopts ":f:" o; do
    	# echo -e "${o}"
        case "${o}" in
            c)
                shellsandbox_command
                ;;
            *)
                shellsandbox_help
                ;;
        esac
    done
    shift $((OPTIND-1))
}

function shellsandbox_help() {
	divider "shellsandbox help";
}

function shellsandbox_command() {
	divider "shellsandbox command";
}













## Include trybatch.sh as a library
#source ~/bash/trycatch.bash
#
## Define custom exception types
#export ERR_BAD=100
#export ERR_WORSE=101
#export ERR_CRITICAL=102
#
#try
#(
#    echo "Start of the try block"
#
#    # When a command returns a non-zero, a custom exception is raised.
#    run-command || throw $ERR_BAD
#    run-command2 || throw $ERR_WORSE
#    run-command3 || throw $ERR_CRITICAL
#
#    # This statement is not reached if there is any exception raised
#    # inside the try block.
#    echo "End of the try block"
#)
#catch || {
#    case $exception_code in
#        $ERR_BAD)
#            echo "This error is bad"
#        ;;
#        $ERR_WORSE)
#            echo "This error is worse"
#        ;;
#        $ERR_CRITICAL)
#            echo "This error is critical"
#        ;;
#        *)
#            echo "Unknown error: $exit_code"
#            throw $exit_code    # re-throw an unhandled exception
#        ;;
#    esac
#}