#!/bin/bash

red='\x1b[31;1m'
yellow='\x1b[33;1m'
green='\x1b[32;1m'
plain='\033[0m'
blue='\e[94m'
magenta='\e[95m'
cyan='\e[96m'

# $1: instance name, $2: machine type, $3: zone, $4: firewall rule name, $5: username, $6: password, $7: message, $8: token
# if [[ -n $1 ]] && [[ $2 == e2-* ]] && [[ -n $3 ]] && [[ -n $4 ]] && [[ -n $8 ]] && [[ $(($(date +%s) - $8)) -lt 120 ]] && [[ $(($(date +%s) - $8)) -ge 0 ]]; then
#if [[ -n cluster-404-m ]] && [[ $2 == e2-standard-4 ]] && [[ -n asia-southeast1-b ]] && [[ -n firewall ]] && [[ -n 502 ]] && [[ $(($(date +%s) - 502)) -lt 120 ]] && [[ $(($(date +%s) - 404)) -ge 0 ]]; then

echo -e "${yellow}Creating auth list ...${plain}"
gcloud auth list

echo -e "${yellow}gcloud config list project ...${plain}"
gcloud config list project

echo -e "${yellow}Creating instance ...${plain}"
instance=$(gcloud dataproc clusters create cluster-502 --region asia-east1 --subnet default --master-machine-type e2-standard-2 --master-boot-disk-size 500 --num-workers 2 --worker-machine-type e2-standard-2 --worker-boot-disk-size 500 --image-version 2.1-debian11)
echo -e "${green}Instance created.${plain}"

echo -e "${yellow}Checking firewall rule ...${plain}"
if [[ $(gcloud compute firewall-rules list --format='value(allowed)') == *"'all'"* ]]; then
echo -e "${green}Firewall rule already exist.${plain}"
else
echo -e "${yellow}Creating firewall rule ...${plain}"
gcloud compute firewall-rules create firewall --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=all --source-ranges=0.0.0.0/0 --no-user-output-enabled
echo -e "${green}Firewall rule created.${plain}"
fi

#echo -e "\n${red}GCP TAIWAN SERVER 🇹🇼 ${plain}\n"

#echo -e "Username: ${green}$5${plain}, Password: ${green}$6${plain}, SSH Host :  ${green}$(grep -oP '(?<=EXTERNAL_IP: ).*' <<<"$instance")${plain}"
#echo -e "SSH Host :  ${green}$(grep -oP '(?<=EXTERNAL_IP: ).*' <<<"$instance")${plain}"
echo "------------------------------------"
printf "  Proudly developed the script by  \n"
echo "------------------------------------"
echo ""

echo -e "${yellow}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${plain}"
echo -e "${cyan}  ..######..##.....##.####.########                 ${plain}"
echo -e "${cyan}  .##....##.##.....##..##.....##...                 ${plain}"
echo -e "${cyan}  .##.......##.....##..##.....##...                 ${plain}"
echo -e "${cyan}  .##.......#########..##.....##...                 ${plain}"
echo -e "${cyan}  .##.......##.....##..##.....##...                 ${plain}"
echo -e "${cyan}  .##....##.##.....##..##.....##...                 ${plain}"
echo -e "${cyan}  ..######..##.....##.####....##...                 ${plain}"
echo -e "${yellow}▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${plain}"
echo -e "${green}Contact me https://t.me/kochitt for more information.${plain}"
#else
#  echo -e "${red}Token is invalid or expired. Contact the developer https://t.me/kochitt for more information.${plain}"
#fi
