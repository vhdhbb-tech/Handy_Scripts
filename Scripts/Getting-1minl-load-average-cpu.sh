#!/bin/bash

while true; do
    # Get the 1-minute load average using the 'uptime' command
    load_avg=$(uptime | awk -F 'load average:' '{print $2}' | awk '{print $1}')

    echo "Current 1-minute load average: $load_avg"
    
    # Adjust the sleep interval as needed (in seconds)
    sleep 5
done

# Explanation of the script:
# The uptime command is used to retrieve system load averages.
# The awk command is used to extract the load average values from the uptime output.
# The script enters a loop to repeatedly fetch and display the 1-minute load average.
# The sleep command is used to control the interval between each check (in this case, 5 seconds).
# Keep in mind that this is a basic script. For more sophisticated monitoring, you might consider using tools like top, htop, or specialized monitoring solutions.
# If you're looking for more advanced monitoring and alerting, you could also consider using tools like sar, collectd, Prometheus, Grafana, or other monitoring systems to gather and visualize system performance data over time.