#!/bin/bash

# Create aliases
alias cleos='docker exec -i eoslocal_eosio cleos'
alias cleos_local='docker exec -i eoslocal_eosio cleos -u http://eosio:8888 --wallet-url http://wallet:8901'
alias cleos_wallet='docker exec -i eoslocal_wallet cleos -u http://eosio:8888 --wallet-url http://wallet:8901'
alias cleos_testnet='docker exec -i eoslocal_wallet cleos -u http://testnet.telos.eossweden.eu'
alias cleos_jungle='docker exec -i eoslocal_eosio cleos -u https://jungle.eosio.cr --wallet-url http://wallet:8901'
alias cleos_mainnet='docker exec -i eoslocal_eosio cleos -u https://api.eosio.cr --wallet-url http://wallet:8901'
alias eosio='docker exec -it eoslocal_eosio bash'
alias unlock_eoslocal='docker exec -i eoslocal_eosio ./scripts/unlock.sh'
alias dk='docker'
alias dc='docker-compose'
