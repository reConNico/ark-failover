#!/usr/bin/env bash

#==============================================================================
# description     : Rebuild for the ark node using noah.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

# =====================
# @param node $1
# =====================
rebuild()
{
    ssh -o ConnectTimeout=10 $1 export_path=${export_path} 'bash -s' <<'ENDSSH'
        PATH=${export_path}:$PATH
        export PATH
        cd ~/noah
        ls -la
        bash noah.sh rebuild
ENDSSH
}
