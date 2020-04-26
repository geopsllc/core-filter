# P2P Port Filter

## Installation

Basic install:
```sh
sudo apt install jq
git clone https://github.com/geopsllc/core-filter
cd core-filter
bash filter.sh # To Enable The Filter
bash restore.sh # To Restore The Allow From Any
```

- The list of IPs is taken from the official ARK API.
- Requires UFW to be active/enabled. Works on Ubuntu 16.04 and 18.04.
- The peer IP for the ARK API node we got the info from will not be added to the allowed list.
- If you want to cron this script you should use filter-root.sh and run it as root and/or add to system cron.
