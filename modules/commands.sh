#!/usr/bin/env bash

#==============================================================================
# description     : Commands of the application.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

app_start()
{
    info "Starting application..."
    pm2 start ${app_dir}/apps.json >> ${app_log} 2>&1
    success "Start complete!"
}

app_stop()
{
    info "Stopping application..."
    lock_check
    pm2 stop ${app_dir}/apps.json >> ${app_log} 2>&1
    success "Stop complete!"
}

app_restart()
{
    info "Restarting application..."
    lock_check
    pm2 restart ${app_dir}/apps.json >> ${app_log} 2>&1
    success "Restart complete!"
}

app_test()
{
    get_nodes

    test_run
}

app_switch()
{
    switch
}

# =====================
# @param node $1
# =====================
app_rebuild()
{
    rebuild $1
}

app_update()
{
    cd ${app_dir}

    git remote update

    local remote_version=$(git rev-parse origin/master)
    local local_version=$(git rev-parse HEAD)

    if [[ $remote_version == $local_version ]]
        then
            info 'You are already using the latest version.'
        else
            read -p 'There is an update available. Do you want to install it? [y/N] :' input

            if [[ ${input} =~ ^(yes|y) ]]; then
                app_stop

                info "Starting Update..."
                git reset --hard >> ${app_log} 2>&1
                git pull >> ${app_log} 2>&1
                success 'Update finished!'

                app_start
            fi
    fi
}

app_nodes()
{
    get_nodes
    block_height ${node_forging}
    info "Forging node: ${node_forging} (${blockheight_node}/${blockheight_net})"
    block_height ${node_relay}
    info "Relay node: ${node_relay} (${blockheight_node}/${blockheight_net})"
}

app_status()
{
    pm2 list
}

app_log()
{
    tail -f `/bin/ls -1td ${log_dir}/*| /usr/bin/head -n1`
}

app_alias()
{
    info "Installing alias..."
    echo "alias failover='bash ${app_dir}/failover.sh'" | tee -a ${HOME}/.bashrc
    source ${HOME}/.bashrc
    success "Installation complete!"
}

app_help()
{
    cat << EOF
Usage: $app [options]
options:
    help                      Show help information.
    install                   Install the application.
    start                     Start the application.
    stop                      Stop the application.
    restart                   Restart the application.
    test                      Test the application.
    switch                    Switch the forging node.
    rebuild [node]            Rebuild a node using noah.
    update                    Update the application to the latest version.
    nodes                     Display current nodes information.
    status                    Display the status of the application.
    log                       Show log information.
    alias                     Create a bash alias for failover.
EOF
}