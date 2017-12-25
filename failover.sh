#!/usr/bin/env bash

#==============================================================================
# description     : This script is parsing the incoming arguments.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

# =====================
# Variables
# =====================

app=$(basename "$0")
app_dir="`locate -b "\ark-scripts"`"
app_log="${app_dir}/failover.log"
log_dir="${app_dir}/logs_monitor"
. "${app_dir}/variables.sh"

# =====================
# Modules
# =====================

. "${app_dir}/modules/args.sh"
. "${app_dir}/modules/ark.sh"
. "${app_dir}/modules/commands.sh"
. "${app_dir}/modules/install.sh"
. "${app_dir}/modules/log.sh"
. "${app_dir}/modules/monitor.sh"
. "${app_dir}/modules/nodes.sh"
. "${app_dir}/modules/rebuild.sh"
. "${app_dir}/modules/secret.sh"
. "${app_dir}/modules/style.sh"
. "${app_dir}/modules/switch.sh"
. "${app_dir}/modules/test.sh"

# =====================
# Start application
# =====================

main()
{
    #setup_environment
    #check_configuration

    parse_args "$@"

    #trap cleanup SIGINT SIGTERM SIGKILL
}

main "$@"
