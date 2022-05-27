#!/bin/bash
# Not Another BashTools!
# A set of tools and utilities to be used within a bash shell.
#
# About nabt.ini.bash
# #####################################
# Not Another BashTools! initialization file, is responsible for
# configuring many of the aspects of YABT's behavior.
#
# This initialization is sourced in the bootstrapper, and any
# variables within this initialization will over-ride the
# default ones in the bootstrapper.
#

#
# Automatically run bootstrapper in a new bash session.
#
NABT__AUTOBOOTSTRAP=1

#
# Verbose mode for messages.
#
NABT__VERBOSE=1

#
# Program for editing code. This should be a text editor.
#
NABT__CODE_COMMAND=subl

#
# List of utilities to be included in the bootstrapper.
#
NABT__UTILITIES=(
    "nginxhelpers"
    "parse_git_branch"
    "phphelpers"
)