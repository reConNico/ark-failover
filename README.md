# ARK-Failover

## DO NOT USE UNTIL THE STABLE RELEASE!
## Use at your own risk! Stable release will be published soon!

## Requirements

To run the failover script you need 3 standalone servers. For the documentation we used the following names: 

* master (runs the failover script with ssh connection to nodes)
* relay-1 (running ark-node who is currently forging)
* relay-2 (running ark-node who isn't forging right now. Node needs to be in sync!)

#### Tutorials
* [How to setup an ark node](https://blog.ark.io/how-to-setup-a-node-for-ark-and-a-basic-cheat-sheet-4f82910719da)
* [How to secure your ark node](https://blog.ark.io/how-to-secure-your-ark-node-541254028616)
* [How to set your nodes as ssh host on the master node](https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client)

**Both nodes (forging and relay) must have installed [noah](https://github.com/faustbrian/noah) correctly.**

The first relay needs to be the current forging delegate node. The second relay needs to be a running ark-node that doesn't forge.
The master node only need to run the failover script and have a functioning ssh connection to both nodes.

## Installation

* `git clone https://github.com/reconnico/ark-failover.git`
* `cd ~/ark-failover`
* `bash failover.sh install` (if the error `No such file or directory` occurs please run `sudo updatedb`)
* insert your secret in `secret.txt`
* edit `nodes.txt` and set your nodes `forging;relay` (use ssh host names of your nodes here)
* `bash failover.sh test` (If an error occur please repeat the last 2 steps and check your configuration)
* `bash failover.sh start`

## Commands

```bash
Usage: failover.sh [options]
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
```

## Testing on devnet

We recommend you to test the setup on a test environment first.

* change the network variable in `variables.sh` to `devnet`
* change your secret in `secret.txt` to your devnet delegate secret
* edit `nodes.txt` and set your nodes `forging;relay` (use ssh host names of your nodes here)

## Credits
* [Nico Allers](https://github.com/reconnico)
* [Brian Faust](https://github.com/faustbrian) Developer of [noah](https://github.com/faustbrian/noah)
* [Contributors](https://github.com/reconnico/ark-failover/graphs/contributors)

## License

[MIT](LICENSE) © Nico Allers
