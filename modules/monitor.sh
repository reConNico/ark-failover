#!/usr/bin/env bash

#==============================================================================
# description     : Monitors the blockheight of the nodes.
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
        monitor_nodes
    done

    info "Closing Monitor..."
}

monitor_nodes()
{
    ## check block height of forging node
    block_height ${node_forging}

    if [ -z ${blockheight_net} ] || [ $((${blockheight_net} - ${blockheight_node})) -gt 15 ]; then
        ## forging is out of sync
        log "Forging node ${node_forging} is out of sync..."

        SECONDS=0
        lock_create
        log "[switch: ${node_forging}] ${node_forging} -> ${node_relay}"

        ## set secret on relay
        set_secret ${node_relay} ${secret}
        ark_start ${node_relay}
        log "[set secret on relay: ${node_forging}] finished!"

        log "[blockheight: ${node_forging}] ${blockheight_node}/${blockheight_net} (node/net)"

        ## reset secret on forging node
        set_secret ${node_forging}
        log "[reset secret on forging] finished!"

        ## rebuild database and reset secret on forging
        log "[rebuild: ${node_forging}] starting..."
        rebuild ${node_forging}
        ## todo: if rebuild fails (server being down) don't show bellow message, show an error
        log "[rebuild: ${node_forging}] finished!"

        ## set nodes.txt
        set_nodes ${node_relay} ${node_forging}
        log "[set nodes: ${node_forging}] finished!"

        monitor_finish
    fi

    ## check block height of relay node
    block_height ${node_relay}

    if [ -z ${blockheight_net} ] || [ $((${blockheight_net} - ${blockheight_node})) -gt 15 ]; then
        ## relay is out of sync
        log "Relay node ${node_relay} is out of sync..."
        SECONDS=0
        lock_create
        log "[rebuild ${node_relay}] starting..."
        log "[blockheight ${node_relay}] ${blockheight_node}/${blockheight_net} (node/net)"
        rebuild ${node_relay}
        ## todo: if rebuild fails (server being down) don't show bellow message, show an error
        log "[rebuild ${node_relay}] finished!"

        monitor_finish
    fi

    sleep ${monitor_interval}
}

monitor_finish()
{
    # sleep and restart application
    log "[monitor] sleep for ${monitor_sleep} seconds..."
    sleep ${monitor_sleep}
    log "[monitor] restarting..."
    lock_remove
    app_restart
    exit
}
