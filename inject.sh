#!/bin/bash
#
# Script by J.T. Buice - KainosBP.com
#
#SUM=0


# Create aliases
shopt -s expand_aliases
source aliases.sh

cleos="docker exec -i eoslocal_wallet cleos -u http://testnet.telos.eossweden.eu"
#cleos='cleos_testnet'
#cleos=$"cleos_testnet"
from_account=csxcommunity


INPUT=tlos_inject.csv
#OLDIFS=$IFS
#IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read to_account privkey pubkey liquid cpu bw 
do
        echo "##########  Create account $to_account and staking cpu and bandwidth" 
        echo $cleos system newaccount -x 100 --transfer --stake-cpu "\""$cpu TLOS"\"" --stake-net "\""$bw TLOS"\"" --buy-ram-kbytes 4 $from_account $to_account $pubkey -f | bash - 2>&1 | tee output.log
        #echo $?
        #$cleos system newaccount -x 100 --transfer --stake-cpu "\""$cpu TLOS"\"" --stake-net "\""$bw TLOS"\"" --buy-ram-kbytes 4 $from_account $to_account $pubkey -f
        echo $cleos transfer $from_account $to_account "\""$liquid TLOS"\"" | bash - 2>&1 | tee output.log
done < $INPUT
#IFS=$OLDIFS
