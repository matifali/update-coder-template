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
push_command="coder templates push ${CODER_TEMPLATE_ID} --directory ./${CODER_TEMPLATE_DIR}"

# Add message to the push command if specified
if [ -n "${CODER_TEMPLATE_MESSAGE}" ]; then
  push_command+=" --message \"${CODER_TEMPLATE_MESSAGE}\""
fi

# Add provisioner tag to the push command if specified
if [ -n "${CODER_PROVISIONER_TAG}" ]; then
  push_command+=" --provisioner-tag=\"${CODER_PROVISIONER_TAG}\""
fi

# Add organization to the push command if specified
if [ -n "${CODER_TEMPLATE_ORGANIZATION}" ]; then
  push_command+=" --org \"${CODER_TEMPLATE_ORGANIZATION}\""
fi

# Add version to the push command if specified
if [ -n "${CODER_TEMPLATE_VERSION_NAME}" ]; then
  push_command+=" --name ${CODER_TEMPLATE_VERSION_NAME}"
fi

# Add activate flag to the push command if it is false
if [ "${CODER_TEMPLATE_ACTIVATE}" = "false" ]; then
  push_command+=" --activate=false"
fi

if [ "${CODER_IGNORE_LOCKFILE}" = "true" ]; then
  push_command+=" --ignore-lockfile=true"
fi

# Add confirmation flag to the push command
push_command+=" --yes"

# Execute the push command if no dry run
if [ "${CODER_TEMPLATE_DRY_RUN}" = "false" ]; then
  echo "Pushing ${CODER_TEMPLATE_DIR} to ${CODER_URL}..."
  eval ${push_command}
  echo "A new version of ${CODER_TEMPLATE_DIR} is pushed to ${CODER_URL} successfully."
  exit 0
fi
echo "Dry run is enabled. The following command will be executed:"
echo ${push_command}
echo "A new version of ${CODER_TEMPLATE_DIR} is pushed to ${CODER_URL} successfully."
