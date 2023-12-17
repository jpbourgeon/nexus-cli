#!/bin/bash

alias _nx='sudo docker compose -f "$NEXUS_PROJECT_PATH/docker-compose.yml"'

function _nx_services() {
  local profile=$1
  if [ -n "$profile" ]; then
    _nx --profile "$profile" config --services
  else
    _nx config --services
  fi
}

function _nx_check_service() {
  local profile="$1"
  local services="$(_nx_services $profile)"
  local service="$2"
  if echo "$services" | grep -q -w "$service"; then
    return 0
  else
    echo "No such service: $service, in profile: $profile"
    return 1
  fi
}

function _nx_profiles() {
  _nx config --profiles
}

function _nx_check_profile() {
  local profiles="$(_nx_profiles)"
  local profile="$1"
  if echo "$profiles" | grep -q -w "$profile"; then
    return 0
  else
    echo "No such profile: $profile"
    return 1
  fi
}
