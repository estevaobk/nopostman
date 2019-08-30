#!/bin/bash

# Usage: <client id> <client secret> <APIcast>

USERNAME="rh-sso-user"

PASSWORD="rhs-sso-password"

REALM="rh-sso-realm"

RHSSO_HOST="https://rh-sso-host"


########
# Main #
########


clear

RHSSO="${RHSSO_HOST}/auth/realms/${REALM}/protocol/openid-connect/token"

TKN=$(curl -k -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "username=${USERNAME}" -d "password=${PASSWORD}" -d "grant_type=password" -d "client_id=${1}" -d "client_secret=${2}" ${RHSSO} 2> /dev/null)

echo -e "\nRH SSO: ${RHSSO}\n\nToken: ${TKN}\n"

TKN=$(echo "${TKN}" | sed 's/.*access_token":"//g' | sed 's/".*//g')

curl -k -v -X GET -H "Accept: application/json" -H "Authorization: Bearer ${TKN}" ${3}
