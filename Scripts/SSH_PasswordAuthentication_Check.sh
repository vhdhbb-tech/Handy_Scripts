#!/bin/bash

config_file="/etc/ssh/sshd_config"

# Check if the config file exists
if [ -f "$config_file" ]; then
    # Search for the PasswordAuthentication line and extract the value
    password_auth=$(grep -E "^PasswordAuthentication" "$config_file" | awk '{print $2}')

    # Check if the value is "yes" or "no"
    if [ "$password_auth" = "yes" ]; then
        echo "PasswordAuthentication is set to yes"
    elif [ "$password_auth" = "no" ]; then
        echo "PasswordAuthentication is set to no"
    else
        echo "Unable to determine the value of PasswordAuthentication"
    fi
else
    echo "Config file $config_file does not exist"
fi