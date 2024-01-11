#!/bin/bash

echo "PROJECT NAME, NAME, ZONE, TYPE MACHINE, STATUS, SO, CPU, MEMORY, DISC, PRIVATE IP, STATUS_IP, IP PUBLICO" > gce-inventory_org.csv
prjs=( $(gcloud projects list | tail -n +2 | awk {'print $1'}) )
for i in "${prjs[@]}"
    do
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> list.txt
        echo "Setting Project: $i" >> list.txt
        echo $(gcloud config set project $i)
        if [[ $(gcloud services list --enabled --filter="NAME:compute.googleapis.com" --format="value(NAME)" | grep compute) ]]; then
            echo "Compute API is enabled is in project - $i"
            echo $(gcloud compute instances list | awk '{print $1,$2}' | tail -n +2| while read line; do echo "$i $line"; done |xargs -n3 sh -c 'python3  scan-inventory-gce.py $1 $2 $3 >> gce-inventory_org.csv' sh)
        else
            echo "Compute API is not enabled in project - $i"
        fi       
    done
