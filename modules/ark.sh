#!/usr/bin/env bash

#==============================================================================
# description     : Provides functions that are needed for the ark node.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

# =====================
# @param node $1
# =====================
ark_start()
{
    ## TODO: test when ark process is not running
    ssh $1 network=${network} export_path=${export_path} 'bash -s' <<'ENDSSH'
    PATH=${export_path}:$PATH
    export PATH
    node=`pgrep -a "node" | grep ark-node | awk '{print $1}'`
    forever_process=`forever --plain list | grep ${node} | sed -nr 's/.*\[(.*)\].*/\1/p'`

    if [ "${node}" != "" ] && [ "${node}" != "0" ]; then
        forever restart ${forever_process} >&- 2>&-
    else
        forever start app.js --genesis genesisBlock.${network}.json --config config.${network}.json >&- 2>&-
    fi
ENDSSH
}

# =====================
# @param node $1
# =====================
ark_stop()
{
    ssh $1 export_path=${export_path} 'bash -s' <<'ENDSSH'
    PATH=${export_path}:$PATH
    export PATH
    forever stopall
ENDSSH
}

# =====================
# @param node $1
# =====================
block_height()
{
    blockheight_node=$(ssh $1 'echo $(psql -d ark_mainnet -t -c "SELECT height FROM blocks ORDER BY HEIGHT DESC LIMIT 1;" | xargs)')
    blockheight_net=$(ssh $1 'heights=$(curl -s "http://localhost:4001/api/peers" | jq -r ".peers[] | .height") && echo $(echo "${heights[*]}" | sort -nr | head -n1)')
}