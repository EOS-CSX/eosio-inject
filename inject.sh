#!/bin/bash
#
# Script originally created by J.T. Buice - KainosBP.com
# Script modified by T.J. Bullock (educatedwarrior)  CSX.io
#SUM=0

api_url=http://api.telos.csx.io:8787

# Create aliases
shopt -s expand_aliases
source aliases.sh

cleos="docker exec -i telosdocker_keosd_prod_1 teclos -u $api_url"


echo "Name of account doing the injection?"
read from_account


INPUT=tlos_inject.csv
#OLDIFS=$IFS
#IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read id to_account privkey pubkey liquid cpu bw ram 
do
        echo "##########  Create account $to_account and staking cpu and bandwidth" 
        echo $cleos system newaccount -x 100 --transfer --stake-cpu "\""$cpu TLOS"\"" --stake-net "\""$bw TLOS"\"" --buy-ram-kbytes $ram $from_account $to_account $pubkey -f | bash - 2>&1 | tee output.log
        #echo $?
        #$cleos system newaccount -x 100 --transfer --stake-cpu "\""$cpu TLOS"\"" --stake-net "\""$bw TLOS"\"" --buy-ram-kbytes 4 $from_account $to_account $pubkey -f
        #echo $cleos transfer $from_account $to_account "\""$liquid TLOS"\"" | bash - 2>&1 | tee output.log
done < $INPUT
#IFS=$OLDIFS
