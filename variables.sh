#!/usr/bin/env bash

#==============================================================================
# description     : Variables of the application.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

# =====================
# Network
# =====================

network='devnet' ## mainnet
if [[ $network == 'devnet' ]]
    then
        network_port=4001
    else
        network_port=4001
fi

# =====================
# Monitor
# =====================
monitor_sleep=120
monitor_interval=7

# =====================
# Path
# =====================
export_path='/home/$USER/.nvm/versions/node/v6.9.5/bin'
