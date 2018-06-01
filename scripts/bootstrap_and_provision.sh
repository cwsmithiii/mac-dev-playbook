#!/usr/bin/env bash
# This script will clone this repo locally and then run the main ansible provisioning playbook

# Load colors used
RESTORE=$(echo -en '\033[0m')
GREEN=$(echo -en '\033[00;32m')
RED=$(echo -en '\033[00;31m')

# Set variables
if [ -z "$HOME" ]; then
    echo "${RED}Must set \$HOME environment variable in order to run script${RESTORE}"
    exit 1
fi
ANSIBLE_VAULT_FILE="$HOME/.ansible_vault_pass"
REPO_CLONE_LOCATION="$HOME/.install/mac-dev-playbook"
REPO_GIT_URL="https://github.com/cwsmithiii/mac-dev-playbook.git"

# Confirm environment argument defined
if [ $# -eq 0 ]; then
  echo "This script, '$0', requires that an environment be given."
  exit 1
else
  ENVIRONMENT=$1
fi

# Clone repo locally
git clone "${REPO_GIT_URL}" "${REPO_CLONE_LOCATION}"
if [ $? -ne 0 ]; then
    echo "Unable to clone repo successfully, exiting!"
    exit 1
fi

${REPO_CLONE_LOCATION}/scripts/bootstrap.sh ${ENVIRONMENT}

# Run ansible provision using repo playbooks
ansible-playbook -i "${REPO_CLONE_LOCATION}/ansible/inventory" "${REPO_CLONE_LOCATION}/ansible/main.yml" \
    --ask-become-pass
#    --vault-password-file "${ANSIBLE_VAULT_FILE}"

# Print output for completion
echo -e "${GREEN}All done!${RESTORE}"
exit 0
