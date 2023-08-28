from pprint import pprint
from googleapiclient import discovery

import google.auth
import re
import sys
import os

credentials, project = google.auth.default()
service = discovery.build('compute', 'v1', credentials=credentials)

#print(str(sys.argv))
if (len(sys.argv)) >=3:
    project = sys.argv[1]
    instance = sys.argv[2]
    zone = sys.argv[3]

    # Get instance details
    request = service.instances().get(project=project, zone=zone, instance=instance)
    response = request.execute()

    # Get machine type
    mtype = re.search(r'(.*)/(.*)', response['machineType']).group(2)

    # Get operating system name
    osu = response['disks'][0]['licenses'][0]
    os = re.search(r'(.*)/(.*)', osu).group(2)

    # Get disk size/count
    num_disks = len(response['disks'])

    # Use machine type to get cpu count & memory size
    mrequest = service.machineTypes().get(project=project, zone=zone, machineType=mtype)
    mresponse = mrequest.execute()

    # Get cpu count
    cpu = mresponse['guestCpus']

    # Get memory size
    megabyte = mresponse['memoryMb']
    gigabyte = 1.0/1024
    memory = str(gigabyte * megabyte) + ' GB'

    # Get status
    status = response['status']

    # Get network Interfaces list of dictionaries
    ni = response['networkInterfaces']

    # Get private IP and public IP
    for d in ni:
        privateip = str(d['networkIP'])
        if 'accessConfigs' in d:
            publicip = str(d['accessConfigs'][0]['natIP'])
        else:
            publicip = "NA"

    print(f'{project},{instance},{zone},{mtype},{status},{os},{cpu},{memory},{num_disks},{privateip},{publicip}')
