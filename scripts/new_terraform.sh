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
    TARGET_DIR="terraform/deployments/${PROJECT}/${PROJECT_ENV}"
    SOURCE_DIR="sample-terraform-deployments/deployment_a/${APP}"
    echo "Creating ${TARGET_DIR} .."
    mkdir -p "${TARGET_DIR}"

    echo "Creating ${TARGET_DIR}/${APP}"
    cp -r "${SOURCE_DIR}" "${TARGET_DIR}"
else
    echo "Invalid environment: ${PROJECT_ENV}" && exit 1
fi
