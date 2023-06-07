#!/bin/bash -l
set -euo pipefail

# Check if required variables are set
: "${CODER_SESSION_TOKEN:?Variable not set or empty}"
echo "CODER_SESSION_TOKEN is set."

: "${CODER_ACCESS_URL:?Variable not set or empty}"
echo "CODER_ACCESS_URL: ${CODER_ACCESS_URL}"

echo "Pushing ${CODER_TEMPLATE_NAME} to ${CODER_ACCESS_URL}..."

# Set default values if variables are empty
CODER_TEMPLATE_DIR=${CODER_TEMPLATE_DIR:-$CODER_TEMPLATE_NAME}
echo "CODER_TEMPLATE_DIR is set to ${CODER_TEMPLATE_DIR}"

# Construct push command
push_command="coder templates push ${CODER_TEMPLATE_NAME} --directory ./${CODER_TEMPLATE_DIR}"

# Add version to the push command if specified
if [ -n "${CODER_TEMPLATE_VERSION}" ]; then
  push_command+=" --name ${CODER_TEMPLATE_VERSION}"
fi

# Add activate flag to the push command if specified
if [ -n "${CODER_TEMPLATE_ACTIVATE}" ]; then
  push_command+=" --activate=${CODER_TEMPLATE_ACTIVATE}"
fi

# Add confirmation flag to the push command
push_command+=" --yes"

# Execute the push command
${push_command}

echo "Template ${CODER_TEMPLATE_NAME} pushed to ${CODER_ACCESS_URL}."
