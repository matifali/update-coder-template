#!/bin/bash -l
set -euo pipefail

# Check if required variables are set
: "${CODER_SESSION_TOKEN:?Variable not set or empty}"
echo "CODER_SESSION_TOKEN is set."

: "${CODER_URL:?Variable not set or empty}"
echo "CODER_URL: ${CODER_URL}"

echo "Pushing ${CODER_TEMPLATE_NAME} to ${CODER_URL}..."

# Set default values if variables are empty
CODER_TEMPLATE_DIR=${CODER_TEMPLATE_DIR:-$CODER_TEMPLATE_NAME}
echo "CODER_TEMPLATE_DIR is set to ${CODER_TEMPLATE_DIR}"

# Construct push command
push_command="coder templates push ${CODER_TEMPLATE_NAME} --directory ./${CODER_TEMPLATE_DIR}" --url ${CODER_URL} --token ${CODER_SESSION_TOKEN}

# Add version to the push command if specified
if [ -n "${CODER_TEMPLATE_VERSION}" ]; then
  push_command+=" --name ${CODER_TEMPLATE_VERSION}"
fi

# Add activate flag to the push command if it is false
if [ "${CODER_TEMPLATE_ACTIVATE}" = "false" ]; then
  push_command+=" --activate=false"
fi

# Add confirmation flag to the push command
push_command+=" --yes"

# Execute the push command
${push_command}

echo "Template ${CODER_TEMPLATE_NAME} pushed to ${CODER_URL}."
