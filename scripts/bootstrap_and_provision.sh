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
REPO_GIT_URL="git@github.com:cwsmithiii/mac-dev-playbook.git"

# Clone repo locally
git clone "${REPO_GIT_URL}" "${REPO_CLONE_LOCATION}"
if [ $? -ne 0 ]; then
    echo "Unable to clone repo successfully, exiting!"
    exit 1
fi

# Load all common functions / variables from repo
source "${REPO_CLONE_LOCATION}/scripts/common/sudo.sh"
source "${REPO_CLONE_LOCATION}/scripts/common/brew.sh"
source "${REPO_CLONE_LOCATION}/scripts/common/ansible.sh"

# Run functions from sourced scripts
ask_sudo
pre_install_brew
install_brew
install_ansible
install_ansible_roles "${REPO_CLONE_LOCATION}/ansible/role_requirements.yml"
# TODO: Re-enable when mas issue is fixed: https://github.com/mas-cli/mas/issues/107
#init_ansible_vault_file "${ANSIBLE_VAULT_FILE}"

# Run ansible provision using repo playbooks
ansible-playbook -i "${REPO_CLONE_LOCATION}/ansible/inventory" "${REPO_CLONE_LOCATION}/ansible/main.yml" \
    --ask-become-pass
#    --vault-password-file "${ANSIBLE_VAULT_FILE}"

# Print output for completion
echo -e "${GREEN}All done!${RESTORE}"
exit 0
