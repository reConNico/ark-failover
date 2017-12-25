#!/usr/bin/env bash

#==============================================================================
# description     : Coammands of the application.
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
    pm2 stop ${app_dir}/apps.json >> ${app_log} 2>&1
    success "Stop complete!"
}

app_restart()
{
    info "Restarting application..."
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

    local remote_version=$(git rev-parse origin/master)
    local local_version=$(git rev-parse HEAD)

    if [[ $local_version == $remote_version ]]
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

app_status()
{
    pm2 list
}

app_log()
{
    if [ ! -e ${app_log} ]; then
        touch ${app_log}
    fi

    tail -f ${app_log}
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
    rebuild [node]            Rebuild a relay using noah.
    update                    Update the application to the latest version.
    status                    Display the status of the application.
    log                       Show log information.
    alias                     Create a bash alias for failover.
EOF
}