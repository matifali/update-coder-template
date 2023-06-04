#!/bin/bash -l
set -e

# Check if CODER_SESSION_TOKEN is set
: "${CODER_SESSION_TOKEN:?Variable not set or empty}"

# Check if CODER_ACCESS_URL is set
: "${CODER_ACCESS_URL:?Variable not set or empty}"

echo "Pushing ${CODER_TEMPLATE_NAME} to ${CODER_ACCESS_URL}..."

# if the CODRR_TEMPLATE_DIR is empty string, then use the TEMPLATE_NAME as the directory
if [ -z "${CODER_TEMPLATE_DIR}" ]; then
    CODER_TEMPLATE_DIR="${CODER_TEMPLATE_NAME}"
fi

# if the CODER_TEMPLATE_VERSION is empty string then let coder use a random name
if [ -z "${CODER_TEMPLATE_VERSION}" ];
then
    echo "No version specified, using random name."
    coder templates push ${CODER_TEMPLATE_NAME} --directory ./${CODER_TEMPLATE_DIR} --activate=${CODER_TEMPLATE_ACTIVATE} --yes
else
    coder templates push ${CODER_TEMPLATE_NAME} --directory ./${CODER_TEMPLATE_DIR} --name ${CODER_TEMPLATE_VERSION} --activate=${CODER_TEMPLATE_ACTIVATE} --yes
fi

if [ "${CODER_TEMPLATE_ACTIVATE}" == "true" ];
then
    echo "Template ${CODER_TEMPLATE_NAME} pushed to ${CODER_ACCESS_URL} and activated."
else
    echo "Template ${CODER_TEMPLATE_NAME} pushed to ${CODER_ACCESS_URL}.
fi