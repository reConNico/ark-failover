#!/usr/bin/env bash

#==============================================================================
# description     : Set or reset secret for the ark node.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

# =====================
# @param node $1
# @param secret $2
# =====================
set_secret()
{
    QUOTE_ARGS=''
    INDEX=0
    for ARG in "$@"
    do
        if [ ${INDEX} == 0 ]
            then
                relay=${ARG}
                let INDEX=${INDEX}+1
                continue
        fi

        QUOTE_ARGS="${QUOTE_ARGS}\ ${ARG}"
        let INDEX=${INDEX}+1
    done

    ssh ${relay} network=${network} secret=${QUOTE_ARGS:2} 'bash -s' <<'ENDSSH'
    cd `locate -b '\ark-node'`
    jq -r ".forging.secret = [\"${secret}\"]" config.${network}.json > config.${network}.tmp && mv config.${network}.tmp config.${network}.json
ENDSSH
}