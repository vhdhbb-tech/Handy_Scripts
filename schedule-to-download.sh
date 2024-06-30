#!/bin/bash


read -p " Enter the date in the format of just HH:  " hour
read -p "Enter the date in the format of just MM:  " minute

system_hour=$(date +%H)
system_minute=$(date +%M)

#Converting the user input to minutes
user_input_in_minutes=$((hour * 60 + minute))
#Converting the system time to minutes
system_time_in_minutes=$((system_hour * 60 + system_minute))

#checking if the user input is equal to the system time
while  [ $user_input_in_minutes -ne $system_time_in_minutes ]; do
    echo "The time is not yet $hour:$minute"
    sleep 5
    system_hour=$(date +%H)
    system_minute=$(date +%M)
    system_time_in_minutes=$((system_hour * 60 + system_minute))
done

# Download a Link from Youtube
# youtube-dl -f bestvideo+bestaudio --merge-output-format mp4 https://www.youtube.com/***********
youtube-dl -f bestvideo+bestaudio --merge-output-format mp4 https://www.youtube.com/*********


