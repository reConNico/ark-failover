# Changelog

You can find all related changes to the application here.

## 1.0.0 - 2018-01-14

- initial release

## 1.0.1 - 2018-03-19

- change block height check to greater than 9 for relay node

## 1.0.2 - 2018-04-29

- Fix passing variables. Variables in single-quotes are not evaluated, have to use double quotes.
- add nodes.txt, secret.txt to gitignore
- change readme typo
- modify ark_start(): Fix start node when process is running
- fix block_height() to pass variables correctly (see first point)
- new variables (network_port, db, ark_path)
- make it easier to switch between devnet/mainnet via config