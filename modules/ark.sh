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
    log "Starting/Restarting node: $1"
    ssh $1 network=${network} ark_path=${ark_path} export_path=${export_path} 'bash -s' <<'ENDSSH'
    PATH=${export_path}:$PATH
    export PATH
    forever stopall
    forever start --workingDir ${ark_path} ${ark_path}app.js --genesis genesisBlock.${network}.json --config config.${network}.json
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
    blockheight_node=$(ssh $1 "psql -d ${db} -t -c 'SELECT height FROM blocks ORDER BY HEIGHT DESC LIMIT 1;'")
    blockheight_net=$(ssh $1 network_port=${network_port} 'heights=$(curl -s "http://localhost:${network_port}/api/peers" | jq -r ".peers[] | .height") && echo $(echo "${heights[*]}" | sort -nr | head -n1)')
}

# =====================
# @param node $1
# =====================
is_forging()
{
    result=`ssh $1 pubkey=${pubkey} "curl -s --connect-timeout 1 http://localhost:{$network_port}/api/delegates/forging/status?publicKey=$pubkey 2>/dev/null | jq \".enabled\""`

    if [ $result = true ]; then
        echo $result
        return 1
    fi

    return 0
}
