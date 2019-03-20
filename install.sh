#!/bin/bash

## Source Common Functions sucees / failure functions 
curl -s "https://raw.githubusercontent.com/linuxautomations/scripts/master/common-functions.sh" >/tmp/common-functions.sh
#source /root/scripts/common-functions.sh
source /tmp/common-functions.sh

### Checking Root User or not
CheckRoot

URL=$(curl -s https://www.terraform.io/downloads.html | grep linux_amd64.zip | awk -F \" '{print $2}')
wget -q -O /tmp/terraform.zip $URL &>/dev/null
if [ $? -eq 0 ]; then 
    success "Downloaded Terraform"
else
    error "Downloading Terraform"
    exit 1
fi 

cd /tmp
unzip -o terraform.zip &>/dev/null 
if [ $? -eq 0 ]; then 
    success "Extracted Terraform"
else
    error "Extracting Terraform"
    exit 1
fi 

mv terraform /bin
chmod +x /bin/terraform 
/bin/terraform --version &>/dev/null 
if [ $? -eq 0 ]; then 
    success "Installed Terrafrom"
else
    error "Installing Terraform"
    exit 1
fi

