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
        network_port=4002
        db="ark_devnet"
    else
        network_port=4001
        db="ark_mainnet"
fi

# =====================
# Monitor
# =====================
monitor_sleep=180
monitor_interval=7

# =====================
# Path
# =====================
export_path='/home/$USER/.nvm/versions/node/v6.9.5/bin'
ark_path='/home/$USER/ark-node/'
