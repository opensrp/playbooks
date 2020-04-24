#!/bin/bash
######################################################################
# Sets up Ansible. Assumes that the following is already installed   #
# within the GoCD agent:                                             #
#   - virtualenv                                                     #
#   - pip                                                            #
######################################################################

set -e

if [ "$#" -ne 3 ]; then
    echo "USAGE: $0 <directory to set up virtualenv> <directory to install Ansible Galaxy requirements> <arguments to pass to the ansible-playbook command>"
    exit 1
fi

venvDir="$1"
rolesDir="$2"
ansibleArgs="$3"
rootDir="."

virtualenv "${venvDir}"
source "${venvDir}/bin/activate"
pip install -r "${rootDir}/requirements/base.pip"
ansible-galaxy install -r "${rootDir}/requirements/ansible-galaxy.yml" -p "${rolesDir}"
ansible-playbook "${ansibleArgs}"
