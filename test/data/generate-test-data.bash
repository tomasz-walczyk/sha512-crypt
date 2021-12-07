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

if [[ "${PLATFORM}" == 'Linux' ]]; then
  command -v 'mkpasswd' >/dev/null 2>&1 \
    || Failure 'Program "mkpasswd" is not installed!'
else
  Failure 'Platform is not supported!'
fi

#-----------------------------------------------------------
# Generate test data.
#-----------------------------------------------------------

for ROUNDS in {1000..10000..1000}; do
  for SALT_LENGTH in {8..16..1}; do
    for PASSWORD_LENGTH in {1..127..1}; do
      SALT=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w "${SALT_LENGTH}" | head -n 1 || true)
      PASSWORD=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w "${PASSWORD_LENGTH}" | head -n 1 || true)
      HASH=$(echo -n "${PASSWORD}" | mkpasswd -s -m 'sha-512' -R "${ROUNDS}" -S "${SALT}")
      echo "${PASSWORD};${ROUNDS};${SALT};${HASH}"
    done
  done
done
