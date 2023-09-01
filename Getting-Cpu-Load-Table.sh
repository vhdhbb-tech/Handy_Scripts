#!/bin/bash

# Dialog settings
dialog_title="CPU Load Average Monitor"
table_height=10
table_width=50

while true; do
    # Get the 1-minute load average using the 'uptime' command
    load_avg=$(uptime | awk -F 'load average:' '{print $2}' | awk '{print $1}')

    # Create the dialog table data
    table_data=("Timestamp|Load Average"
                "$(date)|$load_avg")

    # Display the dialog table
    dialog --title "$dialog_title" \
           --ascii-lines \
           --no-shadow \
           --extra-button --extra-label "Exit" \
           --begin 3 10 \
           --keep-tite \
           --ok-label "Refresh" \
           --tailbox "$table_data" $table_height $table_width

    # Break the loop if the user chooses to exit
    if [ $? -eq 3 ]; then
        break
    fi

    # Adjust the refresh interval as needed (in seconds)
    sleep 5
done
