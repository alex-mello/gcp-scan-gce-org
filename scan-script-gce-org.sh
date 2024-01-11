#!/bin/bash

# Log file path
LOG_FILE="script_log.txt"

# Function to log messages with timestamp
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "$LOG_FILE"
}

# Header for the CSV file
echo "PROJECT ID, NAME, ZONE, TYPE MACHINE, STATUS, SO, CPU, MEMORY, DISC, PRIVATE IP, STATUS_IP, PUBLIC IP" > gce-inventory_org.csv

# Array of GCP project IDs
prjs=( $(gcloud projects list | tail -n +2 | awk {'print $1'}) )

# Loop through each project
for i in "${prjs[@]}"
do
    # Set the default quota project used by any library that requests Application Default Credentials (ADC)
    log "Setting default quota project: $i"
    gcloud auth application-default set-quota-project $i >> "$LOG_FILE"

    # Log setting the current project
    log "Setting Project: $i"
    echo $(gcloud config set project $i) >> "$LOG_FILE"

    # Check if Compute Engine API is enabled
    if [[ $(gcloud services list --enabled --filter="NAME:compute.googleapis.com" --format="value(NAME)" | grep compute) ]]; then
        # Log that Compute API is enabled in the current project
        log "Compute API is enabled in project - $i"

        # Get information about instances and append to the CSV file
        echo $(gcloud compute instances list | awk '{print $1,$2}' | tail -n +2 | while read line; do echo "$i $line"; done | xargs -n3 sh -c 'python3  scan-inventory-gce.py $1 $2 $3 >> gce-inventory_org.csv' sh) >> "$LOG_FILE"
    else
        # Log that Compute API is not enabled in the current project
        log "Compute API is not enabled in project - $i"
    fi       
done
