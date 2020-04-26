#!/bin/bash

sudo apt > /dev/null 2>&1

json=$(curl -s "https://explorer.ark.io/api/peers?page=1")

if [ -z $json ]; then
  echo "API Offline!"
  exit 1
fi

pages=$(jq -n $json | jq .meta.pageCount)
page=1
declare -a ips=()

while [ $page -le $pages ]; do
  if [ "$page" -gt 1 ]; then
    json=$(curl -s "https://explorer.ark.io/api/peers?page=$page")
  fi
  count=$(jq -n $json | jq .meta.count)
  for (( c=1; c<=$count; c++ )) do
    ip=$(jq -n $json | jq .data[$c].ip)
    if [ "$ip" != "null" ]; then
      ips+=( $ip )
    fi
  done
  ((page++))
done

if [ "${#ips[@]}" -lt 51 ]; then
  echo "Not Enough Peers!"
  exit 1
fi

sudo ufw delete allow 4001 > /dev/null 2>&1
sudo ufw delete allow 4001/tcp > /dev/null 2>&1
sudo sed -i '/4001/d' /etc/ufw/before.rules

for index in ${!ips[@]}; do
  ip=$(echo "${ips[index]}" | tr -d '"')
  sudo sed -i "/^COMMIT/i -A ufw-before-input -p tcp --dport 4001 -s $ip -j ACCEPT" /etc/ufw/before.rules
done

sleep 1
sudo ufw reload
