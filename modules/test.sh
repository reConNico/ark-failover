#!/usr/bin/env bash

#==============================================================================
# description     : Testing needed functionalities.
# @author		  : Nico Allers <info@reconnico.com>
#==============================================================================

test_run()
{
    test_ssh ${node_forging}
    test_ssh ${node_relay}
    test_noah ${node_forging}
    test_noah ${node_relay}
    #test_secret
}

# =====================
# @param node $1
# =====================
test_ssh()
{
    ssh -q $1 exit

    if [ $? == 255 ]
        then
            error "Can't connect to $1 via ssh! Please check your ssh settings."
    fi
}

# =====================
# @param node $1
# =====================
test_noah()
{
    ssh $1 "bash noah/noah.sh test test || exit 12"

    if [[ $? = 12 ]]; then
        error "Noah isn't installed correctly on $1! Please make sure that noah runs correctly on your nodes."
    fi
}

test_secret()
{
    ## TODO: implement secret check
    error "Secret is not correct! Please check your configuration."
}