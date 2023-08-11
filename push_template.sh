#!/bin/bash -l
set -euo pipefail

# check if required variables are set
: "${CODER_SESSION_TOKEN:?CODER_SESSION_TOKEN not set or empty}"
echo "CODER_SESSION_TOKEN is set."
: "${CODER_URL:?CODER_URL not set or empty}"
echo "CODER_URL is set."
: "${CODER_TEMPLATE_ID:?CODER_TEMPLATE_ID not set or empty}"
echo "CODER_TEMPLATE_ID: ${CODER_TEMPLATE_ID}"
: "${CODER_TEMPLATE_DIR:?CODER_TEMPLATE_DIR not set or empty}"
echo "CODER_TEMPLATE_DIR: ${CODER_TEMPLATE_DIR}"

# Construct push command
push_command="coder templates push ${CODER_TEMPLATE_NAME} --directory ./${CODER_TEMPLATE_DIR}" --message ${CODER_TEMPLATE_MESSAGE}

# Append --create flag to the push command if CODER_TEMPLATE_CREATE is true
if [ "${CODER_TEMPLATE_CREATE}" = "true" ]; then
  push_command+=" --create"
fi

# Add version to the push command if specified
if [ -n "${CODER_TEMPLATE_VERSION_NAME}" ]; then
  push_command+=" --name ${CODER_TEMPLATE_VERSION_NAME}"
fi

# Add activate flag to the push command if it is false
if [ "${CODER_TEMPLATE_ACTIVATE}" = "false" ]; then
  push_command+=" --activate=false"
fi

# Add confirmation flag to the push command
push_command+=" --yes"

# Execute the push command
${push_command}

echo "A new version of ${CODER_TEMPLATE_DIR} is pushed to ${CODER_URL} successfully."
