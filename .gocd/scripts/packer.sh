#!/bin/bash
######################################################################
# Sets up Packer. Assumes that the following is already installed    #
# within the GoCD agent:                                             #
#   - curl                                                           #
#   - unzip                                                          #
#                                                                    #
# Since script might add items to the environment, we recommend that #
# you source the file, rather than run it:                           #
#  source ./gocd/set-up/packer.sh                                    #
######################################################################

set -e

if [ "$#" -ne 1 ]; then
    echo "USAGE: $0 <directory to install Packer>"
    exit 1
fi

packerVersion="1.5.5"
installDir="$1"
curDir="$PWD"

mkdir -p "${installDir}"
curl -o "${installDir}/packer.zip" -L "https://releases.hashicorp.com/packer/${packerVersion}/packer_${packerVersion}_linux_amd64.zip"
cd "${installDir}"
unzip packer.zip
cd "${curDir}"