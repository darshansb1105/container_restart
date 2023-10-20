#!/bin/bash

#Remote Machine credentials
USERNAME="darshansb"
REMOTE_SERVER="192.168.1.2"
# Get machine name and username
MACHINE_NAME=$(uname -n)
USERNAME=$(whoami)

mkdir -p /home/$USERNAME/logs
touch /home/$USERNAME/logs/Restart_log.log
cd /home/$USERNAME/logs
chmod 755 ./Restart_log.log

# Remote destination folder
REMOTE_DESTINATION="/home/$USERNAME/logs"

# Log file location on the remote machine
LOG_FILE="/home/$USERNAME/Restart_log.log"

# Check if container names are provided as arguments
if [ $# -eq 0 ]; then
  echo "Usage: $0 <container_name1> <container_name2> ..."
  exit 1
fi

# Function to get the current date and time
get_current_datetime() {
  date +"%Y-%m-%d %H:%M:%S"
}

# Log machine name, username, and current date/time
echo "Current Date/Time: $(get_current_datetime)" >> $LOG_FILE
#echo "Machine: $MACHINE_NAME" >> $LOG_FILE
#echo "Username: $USERNAME" >> $LOG_FILE

# Loop through the provided container names and perform actions while logging
for CONTAINER_NAME in "$@"; do
  # Log the activity
  echo "Restarting container: $CONTAINER_NAME" >> $LOG_FILE
  # Perform the action on the container (e.g., Docker restart)
  docker restart "$CONTAINER_NAME"
done

# Create the destination folder on the remote server if it doesn't exist
#ssh $USERNAME@$REMOTE_SERVER "mkdir -p $REMOTE_DESTINATION"

# Copy the log file to the remote server
#scp $LOG_FILE $USERNAME@$REMOTE_SERVER:$REMOTE_DESTINATION