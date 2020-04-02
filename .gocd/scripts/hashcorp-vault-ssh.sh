#!/bin/bash
######################################################################
# Installs an SSH key-pair and requests for an SSH certifocate from  #
# a Hashicorp Vault server. Scripts then adds the key to an SSH      #
# agent. The script assumes the following commands are available:    #
#   - curl                                                           #
#   - unzip                                                          #
#   - ssh-agent                                                      #
#   - ssh-add                                                        #
######################################################################

set -e

if [ "$#" -ne 5 ]; then
    echo "USAGE: $0 <directory to install Vault> <directory to install the keys> <path to SSH agent> <Hashicorp Vault user> <path within Hashicorp vault CA key exists>"
    exit 1
fi

vaultVersion="1.3.3"
installDir="$1"
keysDir="$2"
agentFile="$3"
vaultUser="$4"
vaultKeyPath="$5"

curDir="$PWD"
keyFile=`openssl rand -hex 3`


mkdir -p "${keysDir}"
mkdir -p "${installDir}"

curl -o "${installDir}/vault.zip" -L "https://releases.hashicorp.com/vault/${vaultVersion}/vault_${vaultVersion}_linux_amd64.zip"
cd "${installDir}"
unzip vault.zip
cd "${curDir}"

ssh-keygen -t ed25519 -f "${keysDir}/${keyFile}" -N ""
${installDir}/vault login -method=aws
${installDir}/vault write -field=signed_key "${vaultKeyPath}/sign/$vaultUser" public_key="@${keysDir}/${keyFile}.pub" > "${keysDir}/${keyFile}-cert.pub"
eval `ssh-agent -s`
ssh-add "${keysDir}/${keyFile}"
ln -sf $SSH_AUTH_SOCK $agentFile