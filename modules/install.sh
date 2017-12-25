#!/usr/bin/env bash

#==============================================================================
# description     : Installations script for the application.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

app_install()
{
    info "Starting Installation..."

    if [[ -z $(command -v pm2) ]]; then
        info "Installing pm2..."
        npm install pm2 -g >> ${app_log} 2>&1
        success "Installation OK."
    else
        info "pm2 already exists..."
    fi

    success "Installation complete!"
}