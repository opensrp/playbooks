#! /bin/bash

script_name=$(basename "${0}")
if [ $# -lt 3 ]
then
    echo "Usage: ${script_name} app_name project_name [production|preview|staging]" && exit 1
fi

APP="$1"
PROJECT="$2"
PROJECT_ENV="$3"

if [[ "$PROJECT_ENV" = "preview" || "$PROJECT_ENV" = "production" || "$PROJECT_ENV" = "staging" || "$PROJECT_ENV" = "stage" ]]
then
    GROUP_VARS_DIR="inventories/${PROJECT}/${PROJECT_ENV}/group_vars"
    SOURCE_DIR="sample-inventories/inventory-a/group_vars/${APP}"
    echo "Creating ${GROUP_VARS_DIR} .."
    mkdir -p "${GROUP_VARS_DIR}"

    echo "Creating ${GROUP_VARS_DIR}/${APP}"
    cp -r "${SOURCE_DIR}" "${GROUP_VARS_DIR}"

    if [ -d "${SOURCE_DIR}_client" ]
    then
        echo "Creating  ${GROUP_VARS_DIR}/${APP}_client"
        cp -r "${SOURCE_DIR}_client" "${GROUP_VARS_DIR}"
    fi

    if [ -f "${GROUP_VARS_DIR}/${APP}/vault.yml" ]
    then
        echo "Encrypting ${GROUP_VARS_DIR}/${APP}/vault.yml"
        ansible-vault encrypt "${GROUP_VARS_DIR}/${APP}/vault.yml"
    fi
else
    echo "Invalid environment: ${PROJECT_ENV}" && exit 1
fi
