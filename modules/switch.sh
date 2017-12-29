#!/usr/bin/env bash

#==============================================================================
# description     : Switches the forging and relay node and restart the app.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

switch()
{
    info "Switching nodes..."

    app_stop
    lock_create
    get_nodes

    # set empty secret for forging node and restart forever process
    set_secret ${node_forging}
    ark_start ${node_forging}

    # set secret for relay and restart forever process
    set_secret ${node_relay} ${secret}
    ark_start ${node_relay}

    info "New forging node: ${node_relay}."
    info "New relay node: ${node_forging}."

    set_nodes ${node_relay} ${node_forging}

    # sleep and restart application
    info "sleep for ${monitor_sleep} seconds..."
    sleep ${monitor_sleep}
    info "restarting application..."
    lock_remove
    app_restart

    success "Switch complete!"
}