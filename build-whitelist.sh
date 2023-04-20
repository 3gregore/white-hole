#!/bin/bash

echo "" > Pihole-Whitelist.sh

#Pi-Hole Community Whitelist
wget https://raw.githubusercontent.com/3gregore/white-hole/main/common_urls.txt
#Anudeep - Whitelist
wget https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/whitelist.txt
#Anudeep - Optional
wget https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/optional-list.txt
#Anudeep - Referral Sites
wget https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/referral-sites.txt

for f in $(ls)
do
	if [[ "$f" == *.txt ]]
	then
		sed '/^\s*$/d; /^#/!s/.*/&\nsleep 0.1/' $f >> Pihole-Whitelist.sh
		rm $f
	fi
done

printf "\npihole updateGravity" >> Pihole-Whitelist.sh

# Uncomment once dry run is complete:
# docker exec -i pihole bash < Pihole-Whitelist.sh