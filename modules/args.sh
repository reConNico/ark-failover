#!/usr/bin/env bash

#==============================================================================
# description     : This script is parsing the incoming arguments.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

# =====================
# @param command $1
# @param argument $2
# =====================
parse_args()
{
    case "$1" in
        install)
            app_install
        ;;
        start)
            app_start
        ;;
        stop)
            app_stop
        ;;
        restart)
            app_restart
        ;;
        test)
            app_test
        ;;
        switch)
            app_switch
        ;;
        rebuild)
            app_rebuild $2
        ;;
        update)
            app_update
        ;;
        nodes)
            app_nodes
        ;;
        monitor)
            monitor
        ;;
        status)
            app_status
        ;;
        log)
            app_log
        ;;
        alias)
            app_alias
        ;;
        help|*)
            app_help

            exit 1
        ;;
    esac
}