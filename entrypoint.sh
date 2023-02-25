#!/bin/bash -l
set -e

# Check if CODER_SESSION_TOKEN is set
: "${CODER_SESSION_TOKEN:?Variable not set or empty}"

echo "Pushing ${CODER_TEMPLATE_NAME} to ${CODER_URL}..."

# if the CODRR_TEMPLATE_DIR is empty string, then use the TEMPLATE_NAME as the directory
if [ -z "${CODER_TEMPLATE_DIR}" ]; then
    CODER_TEMPLATE_DIR="${CODER_TEMPLATE_NAME}"
fi

# if the CODER_TEMPLATE_VERSION is empty string then let coder use a random name
if [ -z "${CODER_TEMPLATE_VERSION}" ];
then
    coder templates push ${CODER_TEMPLATE_NAME} --directory ./${CODER_TEMPLATE_DIR} --url ${CODER_URL} --yes
else
    coder templates push ${CODER_TEMPLATE_NAME} --directory ./${CODER_TEMPLATE_DIR} --url ${CODER_URL} --name ${CODER_TEMPLATE_VERSION} --yes
fi
