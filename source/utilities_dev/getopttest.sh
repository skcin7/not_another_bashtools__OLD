#!/bin/bash
#
# [ and ] defines optional arguments
#

# location to getopts.sh file
source $HOME/bash/getopt.bash
USAGE="-c COMMAND [ -a START_DATE_TIME ]"
#echo ${USAGE}
#echo ${@}
getopt__usage ${USAGE}

#parse_options "${USAGE}" ${@}
#
#echo ${COMMAND}
#echo ${START_DATE_TIME}