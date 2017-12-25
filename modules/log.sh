#!/usr/bin/env bash

#==============================================================================
# description     : Logger
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

# =====================
# @param message $1
# =====================
log()
{
    echo "# `date '+%Y-%m-%d %H:%M:%S'` (${SECONDS}s): $1" >> ${log_dir}/`date +%Y-%m-%d`.log 2>&1
}