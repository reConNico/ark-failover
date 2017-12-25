#!/usr/bin/env bash

#==============================================================================
# description     : Styling of the application.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

red=$(tput setaf 1)
green=$(tput setaf 2)
lila=$(tput setaf 4)

bg_black=$(tput setab 8)

bold=$(tput bold)
reset=$(tput sgr0)

# =====================
# @param message $1
# =====================
info()
{
    echo "${bg_black}${lila}==>${reset}${bg_black}${bold} $1${reset}"
}

# =====================
# @param message $1
# =====================
success()
{
    echo "${bg_black}${green}==>${bold} $1${reset}"
}

# =====================
# @param message $1
# =====================
error()
{
    echo "${bg_black}${red}==>${bold} $1${reset}"
}