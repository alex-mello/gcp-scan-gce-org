# GCE Inventory in GCP ORG

This script was developed to help the teams that work with the Google Cloud Platform by scanning all the instances that are in the GCP Organization. Please remember that this script will be useful if you have the proper permissions to run it, this script should in no way be run from the Cloud Shell.

![image](https://github.com/alex-mello/gcp-scan-gce-org/assets/39780604/f385754b-5d9e-4472-a286-a5326592aa99)

##### Do not run the script from Cloud Shell, due to compatibility with the Pip library, the script will not work correctly.

**The script can be run on your local machine or from a VM within GCP.

# Let's go

#### Python Installation
* Windows
* Linux
##### Pip Installation
##### Installation Pypi packages
* googleapiclient
#### GCP ORG Permissions
* Organization paper reader
* Service Usage Reader
* Organization Viewer
* Folder Viewer
* Compute Viewer
#### Script execution - Before starting
* Clone the script repository
* Apply permission to run the sudo chmod +x script
* Let's authenticate with ADC mode
* gcloud auth application-default login
* gcloud config set project PROJECT_ID
* Run the script
#### Download CSV
