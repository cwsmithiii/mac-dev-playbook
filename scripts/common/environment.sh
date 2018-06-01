#!/usr/bin/env bash

environment_cleanup() {
  if [ $# -ne 1 ]; then
    echo "The configuration directory must be given."
    exit 1
  else
    local DIR=$1
  fi

  echo "Removing existing environment configs."
  for file in ${DIR}/*.yml; do
    echo "  Removing ${file}."
    rm -r "${file}" 2>/dev/null
  done
}

environment_link() {
  if [ $# -ne 2 ]; then
    echo "The configuration directory and environment must be given."
    exit 1
  else
    local DIR=$1
    local ENVIRONMENT=$2
  fi

  if [ "${ENVIRONMENT}" != "cleanup" ]; then
    if [ -d "${DIR}/${ENVIRONMENT}" ]; then 
      echo "Linking ${ENVIRONMENT} files."
      for file in ${DIR}/${ENVIRONMENT}/*.yml; do
        echo "  Linking ${file}."
        ln -s "${file}" "${DIR}"
      done
    else
      echo "${ENVIRONMENT} doesn't exist."
      exit 1
    fi
  fi
}
