#!/usr/bin/env bash
#
# Copyright (C) 2022 Tomasz Walczyk
#
# This software may be modified and distributed under the terms
# of the GNU LESSER GENERAL PUBLIC LICENSE VERSION 3.0.
# See the LICENSE file for details.
#
############################################################

set -o errexit -o nounset -o pipefail -o noclobber

############################################################

PLATFORM=$(uname -s)
declare -r PLATFORM

############################################################

Failure() {
  if [[ $# -ne 0 ]]; then
    echo -e "$@" >&2
  fi
  exit 1
}

############################################################
###                       START                          ###
############################################################

trap Failure HUP INT QUIT TERM

#-----------------------------------------------------------
# Check preconditions.
#-----------------------------------------------------------

if [[ "${PLATFORM}" != 'Linux' ]]; then
  Failure 'Platform is not supported!'
fi

[[ -z ${PACKAGE_PATH+x} ]] && Failure 'Environment variable is not set: PACKAGE_PATH'
[[ -z ${INSTALL_PATH+x} ]] && Failure 'Environment variable is not set: INSTALL_PATH'
[[ -z ${PACKAGE_VERSION+x} ]] && Failure 'Environment variable is not set: PACKAGE_VERSION'

#-----------------------------------------------------------
# Create package.
#-----------------------------------------------------------

declare -r PACKAGE_FILE_NAME="sha512-crypt-${PACKAGE_VERSION}-linux.tar.gz"
declare -r PACKAGE_FILE_PATH="${PACKAGE_PATH}/${PACKAGE_FILE_NAME}"
declare -r HASH_FILE_NAME="${PACKAGE_FILE_NAME}.sha512"
declare -r HASH_FILE_PATH="${PACKAGE_FILE_PATH}.sha512"

mkdir -p "${PACKAGE_PATH}" && cd "${INSTALL_PATH}" && tar -czf "${PACKAGE_FILE_PATH}" .
sha512sum "${PACKAGE_FILE_PATH}" | awk '{printf $1}' > "${HASH_FILE_PATH}"

#-----------------------------------------------------------
# Set output variables.
#-----------------------------------------------------------

echo "package_file_name=${PACKAGE_FILE_NAME}" >> "${GITHUB_OUTPUT}"
echo "package_file_path=${PACKAGE_FILE_PATH}" >> "${GITHUB_OUTPUT}"
echo "hash_file_name=${HASH_FILE_NAME}" >> "${GITHUB_OUTPUT}"
echo "hash_file_path=${HASH_FILE_PATH}" >> "${GITHUB_OUTPUT}"
