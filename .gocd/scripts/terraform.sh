#!/bin/bash
######################################################################
# Sets up Terraform. Assumes that the following is already installed #
# within the GoCD agent:                                             #
#   - curl                                                           #
#   - unzip                                                          #
#                                                                    #
# Since script might add items to the environment, we recommend that #
# you source the file, rather than run it:                           #
#  source ./gocd/set-up/terraform.sh                                 #
######################################################################

set -e

if [ "$#" -ne 1 ]; then
    echo "USAGE: $0 <directory to install Terraform>"
    exit 1
fi

terraformVersion="0.12.24"
installDir="$1"
curDir="$PWD"

mkdir -p "${installDir}"
curl -o "${installDir}/terraform.zip" -L "https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip"
cd "${installDir}"
unzip terraform.zip
cd "${curDir}"