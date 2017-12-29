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
        info "Lock file is still there. Sleeping for 5 seconds..."
        sleep 5
    done
    info "Lock file is not there! Continue..."
}