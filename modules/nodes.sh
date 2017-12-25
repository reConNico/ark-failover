#!/usr/bin/env bash

#==============================================================================
# description     : Set and get related nodes indicated by forging and relay.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

# =====================
# @param forging $1
# @param relay $2
# =====================
set_nodes()
{
    echo "$1;$2" > ${app_dir}/nodes.txt
}

get_nodes()
{
    nodes=$(<nodes.txt)
    node_forging="$(cut -d';' -f1 <<<${nodes})"
    node_relay="$(cut -d';' -f2 <<<${nodes})"
}