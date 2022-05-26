#!/bin/bash
# Helper functions for the shell.
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



# use: shell verbosity determines whether or not basic messages are printed to the shell, and it can be turned on or off.
SHELL_VERBOSITY=0

# fun: shellverbosity
# txt: Change the shell verbosity level
# use: shellverbosity 1
# use: shellverbosity 0
function shellverbosity() {
	if [[ "${1}" == 1 ]]; then
		SHELL_VERBOSITY=1
		shellmessage "The shell verbosity has been turned on."
	elif [[ "${1}" == 0 ]]; then
		SHELL_VERBOSITY=0
		shellmessage -f "The shell verbosity has been turned off."
	else
		# not a valid shell verbosity level
		shellmessage -f "The current shell verbosity level is ${SHELL_VERBOSITY}."
		shellmessage -f "The shell verbosity has not been updated."
	fi
}



# fun: shellreload
# txt: Reload the current shell configuration
function shellreload() {
	. ~/.bash_profile
	shellmessage "The shell has been reloaded."
}



# fun: shellmessage
# txt: Print a message to the shell
# use: shellmessage "shell message"
# use: shellmessage -f "forced shell message"
function shellmessage() {
	# the message is printed conditionally based on the verbosity level, or if an option is set to force it to be printed
	local PRINT_THE_MESSAGE=false
	local THE_MESSAGE=''

	# if the verbosity level is true, then print the message
	if [[ "${SHELL_VERBOSITY}" -eq 1 ]]; then
		PRINT_THE_MESSAGE=true
		THE_MESSAGE="${1}"
	fi

	# if the force option is passed, then print the message
    local OPTIND o a
    while getopts ":f:" o; do
    	# echo -e "${o}"
        case "${o}" in
            f)
                # a="${OPTARG}"
                # echo "FORCED"
                # echo -e ${OPTARG}
                PRINT_THE_MESSAGE=true
                THE_MESSAGE=${OPTARG}
                ;;
            *)
                # invalid option
                ;;
        esac
    done
    shift $((OPTIND-1))

    # print the message
	if [[ "${PRINT_THE_MESSAGE}" = true ]]; then
		echo -e ${THE_MESSAGE}
	fi
}








SHELL_WIDTH=0
# fun: shellwidth
# txt: get the width (number of columns) of the shell
function shellwidth() {
	# tput cols

	SHELL_WIDTH=${COLUMNS}
	echo ${SHELL_WIDTH}
}

SHELL_HEIGHT=0
# fun: shellheight
# txt: get the height (number of lines) of the shell
function shellheight() {
	# tput lines

	SHELL_HEIGHT=${LINES}
	echo ${SHELL_HEIGHT}
}

# fun: shelldimensions
# txt: get the dimensions (WIDTHxHEIGHT) of the shell
function shelldimensions() {
	echo "$(shellwidth)x$(shellheight)"
}






function newLine() {
	shellmessage "";
}





function divider() {
	# local HEADING_TEXT=${1}
	# local DIVIDER_CHARACTER=${2} # '='
	# local DOUBLE=${3}

	local HEADING_TEXT=""
	local DIVIDER_CHARACTER="="
	local DOUBLE=false

	if [[ "$1" ]]; then
		HEADING_TEXT=${1}
	fi

	if [[ "$2" ]]; then
		DIVIDER_CHARACTER=${2}
	fi

	if [[ "$3" ]]; then
		DOUBLE=true
	fi

	# # echo ${HEADING_TEXT}
	# local HEADING_TEXT_SIZE=${#HEADING_TEXT}
	# echo ${HEADING_TEXT_SIZE}

	local WIDTH=$(shellwidth)


	if [[ "${DOUBLE}" = true ]]; then
		local PADDING_SIZE=2

		local HEADING_TEXT_WITH_PADDING="$(repeatcharacterntimes '_' ${PADDING_SIZE})${HEADING_TEXT}$(repeatcharacterntimes '_' ${PADDING_SIZE})"

		echo -e $(repeatcharacterntimes "${DIVIDER_CHARACTER}" ${WIDTH})
		echo -e $(padstring "${HEADING_TEXT_WITH_PADDING}" ${WIDTH} "~" center)
		echo -e $(repeatcharacterntimes "${DIVIDER_CHARACTER}" ${WIDTH})
		return
	fi

	if [ ${#HEADING_TEXT} -gt 0 ]; then
		echo -e $(padstring "${HEADING_TEXT}" ${WIDTH} "${DIVIDER_CHARACTER}" center)
	else
		echo -e $(repeatcharacterntimes "${DIVIDER_CHARACTER}" ${WIDTH})
	fi
}






################################################
## EVERYTHING BELOW IS JUST ME FUCKING AROUND ##
################################################



# check_terminal_size () {
# 	# echo -e "CHECKING_TERMINAL_SIZE"
# 	# echo -e "Resized To: ${COLUMNS}x${LINES}"
# 	# echo -e "Resized To: $(shellwidth)x$(shellheight)";
# 	# echo -e "Resized To: $(shelldimensions)";
# 	echo -e "$(shelldimensions)";

#     # if [[ "$LINES $COLUMNS" != "$previous_lines $previous_columns" ]]; then
#     #     # fce_exitus
#     #     echo "";
#     # fi
#     # previous_lines=$LINES
#     # previous_columns=$COLUMNS
#     # exit;
#     # return;
#     # return 0
# }
# # trap 'check_terminal_size' SIGWINCH
# trap 'shellmessage $(shelldimensions);' SIGWINCH



# fun: shelltest
# txt: me fucking around to learn how the shell works
# use: shelltest
function shelltest() {
	# shellreload
	# echo -e "FULL INPUT: ${*}"
	# echo -e "NUMBER OF ARGUMENTS: ${#}"

	# echo -e "${0}"
	# echo -e "${1}"
	# echo -e "${2}"
	# echo -e "${3}"
	echo ""
}





function shellargs() {
	# local OPTIND (or OPTIND=1) needs to be set as shell does not reset OPTIND automatically between multiple calls to getopts (man bash).
	local OPTIND




	echo -e "INPUT: ${*}"
	echo ""

	getopts "a:" OPTION
	echo -e $OPTION
	echo -e $OPTARG

	# local OPTIND
	# getopts "a:" OPTION
	# echo Input: ${*}, OPTION: ${OPTION}, OPTARG: ${OPTARG}
	# # echo ${OPTARG}


    # shellargs_usage() { echo "shellargs: [-a <arg>]" 1>&2; exit; }

    # local OPTIND o a
    # while getopts ":a:" o; do
    #     case "${o}" in
    #         a)
    #             a="${OPTARG}"
    #             ;;
    #         *)
    #             shellargs_usage
    #             ;;
    #     esac
    # done
    # shift $((OPTIND-1))

    # echo "a: [${a}], non-option arguments: $*"
}

# shellargs
# shellargs -a bc bar quux
# shellargs -x