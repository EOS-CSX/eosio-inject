#!/bin/bash
INPUT_FILE=tlos_inject.csv
NAME_PREFIX=csxdrop

# Create aliases
shopt -s expand_aliases
source aliases.sh

function generate_key () {
  # generate keys
  cleos create key --to-console > key.txt
  priv_key=`awk 'NR==1{print $3}' key.txt`
  pub_key=`awk 'NR==2{print $3}' key.txt`
  name=${NAME_PREFIX}$1
  #echo $priv_key
  #echo $pub_key
  echo $name $priv_key $pub_key $liquid $cpu $bw >> $INPUT_FILE
  #`awk 'NR==2{print $3}' key.txt` + ' ' + `awk 'NR==1{print $3}' key.txt` >> keys.txt
}


function ProgressBar {
# 1.1 Input is currentState($1) and totalState($2)
# Process data
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
# Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:                           
# 1.2.1.1 Progress : [########################################] 100%
printf "\rProgress : [${_fill// /\#}${_empty// /-}] ${_progress}%%"

}

# Ask to reset key file
echo
read -p "Reset key file and remove all previously generated keys?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  rm $INPUT_FILE
fi

# Number of keys to generate
echo "Number of keypairs to generate?"
read num_keys
echo "Will generate $num_keys keys"

# Amount to transfer to new accounts
echo "Amount of liquid TELOS to transfer to new accounts?"
read liquid

echo "Amount of TELOS to transfer for cpu staking?"
read cpu

echo "Amount of TELOS to transfer for bandwidth staking (net)?"
read bw

# Loop to generate n keys
for (( i=1; i<=$num_keys; i++ ))
#for i in $(seq -f "%05g" 1 $num_keys)
do
  name_postfix=$(printf "%05g\n" $i)
  name_postfix=$(echo "$name_postfix" | tr 0 o)
  generate_key $name_postfix
  ProgressBar $i $num_keys
done

#echo "Complete\n"
echo
echo

