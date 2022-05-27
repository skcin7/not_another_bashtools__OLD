#!/bin/bash
# Mimic the behavior of try/catch/throw in bash shell.
# https://www.xmodulo.com/catch-handle-errors-bash.html
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

function try() {
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function throw() {
    exit $1
}

function catch() {
    export exception_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $exception_code
}