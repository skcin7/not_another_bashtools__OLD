#!/bin/bash
# Not Another BashTools!
# A set of tools and utilities to be used within a bash shell.
#
# Author: Nick Morgan
# Contact: nick@nicholas-morgan.com
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


# Default NABT configuration.
NABT__AUTOBOOTSTRAP=1
NABT__VERBOSE=1
NABT__CODE_COMMAND=nano
NABT__UTILITIES=(
    "nginxhelpers"
    "parse_git_branch"
    "phphelpers"
)
NABT__RETURN_CODE=0
NABT__PATH=${NABT_PATH}


# Source the NABT initialization, which over-rides default YATB
# configuration for any values present in the initialization
source "${NABT__PATH}/nabt.ini.bash"


# Source the NABT functions
source "${NABT__PATH}/nabt.functions.bash"



alias bootstrap="nabt__bootstrap"

# Automatically bootstrap for a new bash session.
#Otherwise, bootstrapping must be done manually.
if [ ${NABT__AUTOBOOTSTRAP} -eq 1 ]; then
#    # All this does is return the value (it doesn't echo)
#    res=$(nabt__execute_bootstrap)
#    echo $?

#    nabt__message "Auto-Bootstrapping..."
    nabt__execute_bootstrap
#    if [ ${NABT__RETURN_CODE} -eq 0 ]; then
#        nabt__message "Auto-Bootstrapped!"
#    fi
fi