#!/usr/bin/env bash

#==============================================================================
# description     : Monitors the current forging node.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

monitor()
{
    info "Starting Monitor..."

    get_nodes

    log "[monitor] started..."
    log "[monitor] forging: ${node_forging}"
    log "[monitor] relay: ${node_relay}"

    while true; do
        monitor_node ${node_forging}
    done

    info "Closing Monitor..."
}

# =====================
# @param node $1
# =====================
monitor_node()
{
    ## TODO: check if server is reachable and rebuild if not
    if ssh -n $1 tail -2 ark-node/logs/ark.log | grep -q "Blockchain not ready to receive block";
    then
        SECONDS=0
        log "[switch] ${node_forging} -> ${node_relay}"

        ## set secret on relay
        set_secret ${node_relay} ${secret}
        log "[set secret on relay] finished!"

        ## reset secret on forging node
        set_secret ${node_forging}
        log "[reset secret on forging] finished!"

        ## rebuild database and reset secret on forging
        log "[rebuild] starting..."
        rebuild ${node_forging}
        log "[rebuild] finished!"

        ## set nodes.txt
        set_nodes ${node_relay} ${node_forging}
        log "[set nodes] finished!"

        # sleep and restart application
        log "[monitor] sleep for ${monitor_sleep} seconds..."
        sleep ${monitor_sleep}
        log "[monitor] restarting..."
        app_restart
    fi
}