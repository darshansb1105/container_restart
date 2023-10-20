#!/bin/bash
sudo -s
mkdir -p /opt/restart_logs
touch /opt/restart_logs/Restart_log.log
cd /opt/restart_logs
chmod 755 ./Restart_log.log

# Log file location on the remote machine
LOG_FILE="/opt/restart_logs/Restart_log.log"

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


# Loop through the provided container names and perform actions while logging
for CONTAINER_NAME in "$@"; do
  # Log the activity
  echo "Restarting container: $CONTAINER_NAME" >> $LOG_FILE
  # Perform the action on the container (e.g., Docker restart)
  docker restart "$CONTAINER_NAME"
done
