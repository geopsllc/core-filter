# Core-Filter
Apply UFW filter for port 4001 to allow only access from current network nodes. The list of IPs is taken from the official ARK API.
Requires UFW to be active/enabled and apt package jq to be installed. Works on Ubuntu 16.04 and 18.04.
Note: The peer IP for the ARK API node we got the info from will not be added to the allowed list.
