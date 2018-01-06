#!/usr/bin/env bash

#==============================================================================
# description     : Lock the application while rebuilding to prevent errors.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

lock_create()
{
    touch ${app_dir}/app.lock
    info "created lock file..."
}

lock_remove()
{
    rm ${app_dir}/app.lock
    info "removed lock file..."
}

lock_check()
{
    info "Checking lock file..."
    while [ -f ${app_dir}/app.lock ]
    do
        info "Please wait and don't interrupt! Lock file is still there. Sleeping for 2 seconds..."
        sleep 2
    done
    info "Lock file isn't there! Continue..."
}