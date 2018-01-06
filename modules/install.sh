#!/usr/bin/env bash

#==============================================================================
# description     : Installations script for the application.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

app_install()
{
    ## TODO: Test installation on blank system

    info "Starting Installation..."

    if [[ -z $(command -v npm) ]]; then
        info "Installing nodejs..."
        sudo apt-get install nodejs >> ${app_log} 2>&1
        success "nodejs succesfully installed!"
    else
        info "nodejs already exists..."
    fi

    if [[ -z $(command -v npm) ]]; then
        info "Installing npm..."
        sudo apt-get install npm >> ${app_log} 2>&1
        success "npm succesfully installed!"
    else
        info "npm already exists..."
    fi

    if [[ -z $(command -v pm2) ]]; then
        info "Installing pm2..."
        npm install pm2 -g >> ${app_log} 2>&1
        success "pm2 succesfully installed!"
    else
        info "pm2 already exists..."
    fi

    success "Installation complete!"
}