#!/bin/sh
set -e
#set -o pipefail
cpCode=$1
path=$2
domainName=$3

# Build Jekyll
/bin/bash -l -c "bundle install"
/bin/bash -l -c "bundle exec jekyll build"

# Create private_key file from env variable
echo -e "${AKAMAI_PRIVATEKEY}" > /root/privatekey
chmod 600 /root/privatekey
# Upload to NetStorage
scp -i /root/privatekey -o 'HostKeyAlgorithms=+ssh-dss' -o 'StrictHostKeyChecking no' -r /github/workspace/${path} sshacs@${domainName}.scp.upload.akamai.com:/${cpCode}/${path}/
  
  
