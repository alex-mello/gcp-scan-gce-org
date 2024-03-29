# GCE Inventory in GCP ORG

This script was developed to help the teams that work with the Google Cloud Platform by scanning all the instances that are in the GCP Organization. Please remember that this script will be useful if you have the proper permissions to run it, this script should in no way be run from the Cloud Shell.

![image](https://github.com/alex-mello/gcp-scan-gce-org/assets/39780604/c113125c-680a-43a0-b3fb-d94165e8ef15)


##### Do not run the script from Cloud Shell, due to compatibility with the Pip library, the script will not work correctly.

**The script can be run on your local machine or from a VM within GCP.

# Let's go

#### Python Installation
* [Windows](https://python.org.br/instalacao-windows/)
* [Linux](https://python.org.br/instalacao-linux/)
##### Pip Installation
* [pip Install](https://packaging.python.org/en/latest/guides/installing-using-linux-tools/#installing-pip-setuptools-wheel-with-linux-package-managers)
##### Installation Pypi packages
* [googleapiclient](https://pypi.org/project/google-api-python-client/)
#### GCP ORG Permissions
* Compute Viewer
* Folder Viewer
* Organization Role Viewer
* Organization Viewer
* Service Usage Consumer
#### Script execution - Before starting
* Clone the script repository
* Apply permission to run the ```sudo chmod +x scan-script-gce-org.sh ```
* [Let's authenticate with ADC mode](https://cloud.google.com/docs/authentication/provide-credentials-adc?hl=pt-br)
```sh
gcloud auth application-default login
```
```sh
gcloud config set project PROJECT_ID
```
* Run the script ```./scan-script-gce-org.sh```
#### Download CSV
* Use SCP or [GCP Identity-Aware-Proxy (IAP)](https://github.com/GoogleCloudPlatform/iap-desktop)
