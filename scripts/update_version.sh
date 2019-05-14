#!/bin/bash
# Update The Software Version From Online

# Get The Versions Of The Software
SITE_VERSION=$(curl -s https://releases.hashicorp.com/packer/ | grep -o "packer_.*" | head -1 | grep -Eo "[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}")
LOCAL_VERSION=$(grep "finalImageVersion" config.yml | cut -d: -f 2 | sed 's/ //g')

# Check Versions And Update File
if [ "$SITE_VERSION" != "$LOCAL_VERSION" ]
then
  sed -i "s/^finalImageVersion:.*/finalImageVersion: ${SITE_VERSION}/" config.yml
  echo "Version Updated. New Version Set To ${SITE_VERSION}"
else
  echo "No Version Change Required."
fi
