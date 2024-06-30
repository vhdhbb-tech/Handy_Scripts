#!/bin/bash

# Get the list of all users
all_users=$(cut -d: -f1 /etc/passwd)

# Header for the output
printf "%-20s %-20s %-20s\n" "Username" "Password Expiry Date" "Password Expiration Status"

# Loop through each user and get password expiration details
for user in $all_users; do
    # Check if the user has a shadow file entry
    if grep -q "^${user}:" /etc/shadow; then
        # Get password expiration information
        expiry_date=$(chage -l $user | grep "Password expires" | cut -d: -f2)
        status="Active"
        
        # Check if the password is set to never expire
        if [ "$expiry_date" == " never" ]; then
            expiry_date="Never"
            status="Never Expires"
        else
            # Convert the expiration date to a timestamp
            expiry_timestamp=$(date -d "$expiry_date" +%s)
            current_timestamp=$(date +%s)
            
            # Check if the password is expired
            if [ $expiry_timestamp -lt $current_timestamp ]; then
                status="Expired"
            fi
        fi
    else
        # If no shadow entry, the user is system account or the password is locked
        expiry_date="N/A"
        status="No Password Set / Locked"
    fi
    
    # Print user details
    printf "%-20s %-20s %-20s\n" "$user" "$expiry_date" "$status"
done
