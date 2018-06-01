#!/usr/bin/env bash
# This script will initialize the local system for running any ansible playbooks within this repo

# Get directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( dirname "${DIR}" )"
CONFIG_DIR="${ROOT_DIR}/ansible/configs"

# Confirm environment argument defined
if [ $# -eq 0 ]; then
  echo "This script, '$0', requires that an environment be given."
  exit 1
else
  ENVIRONMENT=$1
fi

# Load colors used
RESTORE=$(echo -en '\033[0m')
GREEN=$(echo -en '\033[00;32m')

# Load all common functions / variables
source "${DIR}/common/environment.sh"
source "${DIR}/common/sudo.sh"
source "${DIR}/common/brew.sh"
source "${DIR}/common/ansible.sh"

# Run functions
environment_cleanup "${CONFIG_DIR}"
environment_link "${CONFIG_DIR}" "${ENVIRONMENT}"
ask_sudo
pre_install_brew
install_brew
install_ansible
install_ansible_roles "${DIR}/../ansible/role_requirements.yml"

# Print output for completion
echo -e "${GREEN}All done!${RESTORE}"
exit 0
