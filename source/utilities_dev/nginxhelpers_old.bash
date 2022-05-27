#!/bin/bash
# NGINX Helpers! is a set of tools to manage NGINX within a bash linux shell.
#      This module adds useful helper utilities and commands
#      to make NGINX servers a lot easier to manage and
#      maintain in a local development environment
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

NGINXHELPERS__DIRECTORY="/opt/homebrew/etc/nginx";


# alias nginxwd="cd $NGINXHELPERS__DIRECTORY" #change to the NGINX working directory
# alias nginxd="nginxwd" #alias for nginxwd
# alias nginxreload="sudo brew services reload nginx" #reload NGINX (using homebrew services)
alias nginxreload="sudo nginx -s reload" #reload NGINX (without homebrew services)
alias nginxrestart="sudo brew services stop nginx && sudo brew services start nginx" #restart NGINX (with homebrew services)
alias nginxservers="cd $NGINXHELPERS__DIRECTORY/servers"
#alias nginxlist="ll /opt/homebrew/etc/nginx/servers"


# fun: nginxd
# txt: Show the NGINX directory (but don't change to it)
function nginxd() {
    echo "The NGINX directory is: ${NGINXHELPERS__DIRECTORY}"
}

# fun: nginxcd
# txt: Change to the NGINX directory
function nginxcd() {
    cd $NGINXHELPERS__DIRECTORY
    echo "Changed to NGINX directory: ${NGINXHELPERS__DIRECTORY}"
}


# fun: nginxlist
# txt: List all the NGINX servers
function nginxlist() {
    divider "NGINX List"
    echo -e "This is a list of all the NGINX servers."
    # echo "------------------"
    # echo "NGINX Servers List"
    # echo "------------------"
    echo ""
    ll "$NGINXHELPERS__DIRECTORY/servers/"
    echo ""
    echo "NGINX servers are stored in: $NGINXHELPERS__DIRECTORY/servers/."
    echo ""
}


# nginxcreate servername /Users/skcin7/www/servername/public

#######################################
# Create a NGINX server
# GLOBALS:
#   A_STRING_PREFIX
# ARGUMENTS:
#   String to print
# OUTPUTS:
#   Write String to stdout
# RETURN:
#   0 if print succeeds, non-zero on error.
#######################################
function nginxcreate() {
    # Retrieve the NGINX server config template and store it locally
    #wget https://gist.githubusercontent.com/kevindees/deb3e2bdef377bbf2ffacbc48dfa7574/raw/1d5dc055fe87319a7f247808c9f9ee14c6abd9cd/nginx-server-template-m1.conf -O /opt/homebrew/etc/nginx/servers/$1.conf
    # wget https://gist.githubusercontent.com/kevindees/deb3e2bdef377bbf2ffacbc48dfa7574/raw/1d5dc055fe87319a7f247808c9f9ee14c6abd9cd/nginx-server-template-m1.conf -O /opt/homebrew/etc/nginx/servers/$1.conf
    wget https://gist.githubusercontent.com/skcin7/5282712d00967972187aab5a6bd610e4/raw/59316ce6554ee25bde1a22da8acd09966fcd95d5/my-nginx-server-config-template.conf -O /opt/homebrew/etc/nginx/servers/$1.conf
    #wget https://gist.githubusercontent.com/skcin7/5282712d00967972187aab5a6bd610e4/raw/59316ce6554ee25bde1a22da8acd09966fcd95d5/my-nginx-server-config-template.conf -O /opt/homebrew/etc/nginx/servers/$1.conf

    local NAME=$1;



    # Update the host
    sed -i '' "s:{{host}}:$1:" /opt/homebrew/etc/nginx/servers/$1.conf

    # Update the server root.
    # If a 2nd input parameter exists, use that as the path instead of the default one.
    if [ "$2" ]; then
        sed  -i '' "s:{{root}}:$2:" /opt/homebrew/etc/nginx/servers/$1.conf
    else
        sed  -i '' "s:{{root}}:$HOME/www/$1:" /opt/homebrew/etc/nginx/servers/$1.conf
    fi

    # Add the SSL for the new server.
    nginxaddssl $1

    # Restart NGINX.
    nginxrestart

    # Open the server configuration for the newly created server.
    # At this point, make any changes to it as necessary, and restart NGINX afterwards.
    code /opt/homebrew/etc/nginx/servers/$1.conf
}

# nginxaddssl servername
function nginxaddssl() {
     openssl req \
        -x509 -sha256 -nodes -newkey rsa:2048 -days 3650 \
        -subj "/CN=$1" \
        -reqexts SAN \
        -extensions SAN \
        -config <(cat /System/Library/OpenSSL/openssl.cnf; printf "[SAN]\nsubjectAltName=DNS:$1") \
        -keyout /opt/homebrew/etc/nginx/ssl/$1.key \
        -out /opt/homebrew/etc/nginx/ssl/$1.crt

    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain /opt/homebrew/etc/nginx/ssl/$1.crt
}

# nginxedit servername
function nginxedit() {
    code /opt/homebrew/etc/nginx/servers/$1
}


# nginxremove text.development
function nginxremove() {
    divider "NGINX Remove"

    sudo security remove-trusted-cert -d /opt/homebrew/etc/nginx/ssl/$1.crt

    rm /opt/homebrew/etc/nginx/ssl/$1.crt
    rm /opt/homebrew/etc/nginx/ssl/$1.key

    rm /opt/homebrew/etc/nginx/servers/$1.conf

    nginxrestart

    echo -e "The NGINX server ${1} has been removed."
    #/opt/homebrew/etc/nginx/ssl/nespaperworkinserts.development.crt
    #/opt/homebrew/etc/nginx/ssl/nespaperworkinserts.development.key
    #
}