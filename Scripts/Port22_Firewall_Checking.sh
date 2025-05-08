#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root"
    exit 1
fi
# PLEASE CHECK THE FIREWALL STATUS
# Check the firewall status on both Ubuntu/Debian and CentOS/RHEL
# Ubuntu/Debian
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    if [[ $ID == "ubuntu" || $ID == "debian" ]]; then
        if [[ $(ufw status | grep -w "active" | wc -l) -gt 0 ]]; then
            echo "Firewall is active"
        else
            echo "Firewall is inactive"
        fi
    elif [[ $ID == "centos" || $ID == "rhel" ]]; then
        if [[ $(systemctl is-active firewalld | grep -w "active" | wc -l) -gt 0 ]]; then
            echo "Firewall is active"
        else
            echo "Firewall is inactive"
        fi
    else
        echo "Firewall status check not supported for this Linux distribution"
    fi
else
    echo "Unsupported Linux distribution"
fi




# Check the Linux distribution
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    distro=$ID
elif [[ -f /etc/lsb-release ]]; then
    source /etc/lsb-release
    distro=$DISTRIB_ID
elif [[ -f /etc/debian_version ]]; then
    distro="debian"
elif [[ -f /etc/redhat-release ]]; then
    distro="redhat"
else
    echo "Unsupported Linux distribution"
    exit 1
fi

# Check the firewall based on the Linux distribution
if [[ $distro == "ubuntu" || $distro == "debian" ]]; then
    if [[ $(ufw status | grep -w "22" | grep -w "ALLOW" | wc -l) -gt 0 ]]; then
        echo "Port 22 is open in the firewall"
    else
        echo "Port 22 is closed in the firewall"
    fi
elif [[ $distro == "centos" || $distro == "rhel" ]]; then
    if [[ $(firewall-cmd --list-ports | grep -w "22/tcp" | wc -l) -gt 0 ]]; then
        echo "Port 22 is open in the firewall"
    else
        echo "Port 22 is closed in the firewall"
    fi
else
    echo "Firewall check not supported for this Linux distribution"
fi