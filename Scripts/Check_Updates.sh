#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${YELLOW}Checking The updates...${RESET}"
echo ""

if [ -f /etc/debian_version ]; then
    echo -e "${GREEN}OS: Debian/Ubuntu${RESET}"
    sudo apt update -qq > /dev/null

    echo -e "\n${YELLOW}This is the list of packages that can be upgraded!:${RESET}"
    echo -e "${GREEN}Package's name             Current Version             New Version${RESET}"
    echo "---------------------------------------------------------------"

    apt list --upgradable 2>/dev/null | grep -v "Listing..." | while IFS= read -r line; do
        pkg=$(echo "$line" | cut -d/ -f1)
        current=$(dpkg -s "$pkg" 2>/dev/null | grep '^Version:' | awk '{print $2}')
        new=$(echo "$line" | awk '{print $2}')
        printf "%-20s %-22s %-22s\n" "$pkg" "$current" "$new"
    done

elif [ -f /etc/redhat-release ]; then
    echo -e "${GREEN}OS: RHEL/CentOS/AlmaLinux${RESET}"
    echo -e "\n${YELLOW}This is the list of packages that can be upgraded!:${RESET}"
    echo -e "${GREEN}Package Name             Current Version             New Version${RESET}"
    echo "---------------------------------------------------------------"

    yum check-update | awk 'NF==3 && $2 ~ /^[0-9]/ {print $1, $2, $3}' | while read pkg new_repo; do
        current=$(rpm -q --qf "%{VERSION}-%{RELEASE}\n" "$pkg" 2>/dev/null)
        printf "%-20s %-22s %-22s\n" "$pkg" "$current" "$new_repo"
    done

else
    echo -e "${RED}The OS don't support${RESET}"
    exit 1
fi
