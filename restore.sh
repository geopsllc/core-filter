#!/bin/bash

sudo apt > /dev/null 2>&1

sudo sed -i '/4001/d' /etc/ufw/before.rules
sudo ufw allow 4001/tcp

sleep 1
sudo ufw reload
