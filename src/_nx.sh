#!/bin/bash

alias _nx='sudo docker compose -f "$NEXUS_SVC/docker-compose.yml"'

source $NEXUS_CLI/containers.sh
source $NEXUS_CLI/generic.sh
source $NEXUS_CLI/images.sh
source $NEXUS_CLI/logs.sh
source $NEXUS_CLI/networks.sh
source $NEXUS_CLI/profiles.sh
source $NEXUS_CLI/rm.sh
source $NEXUS_CLI/pull.sh
source $NEXUS_CLI/services.sh
source $NEXUS_CLI/up.sh
source $NEXUS_CLI/volumes.sh

function nx() {
  case "$1" in
  "containers") _nx_containers $2 $3 ;;
  "images") _nx_images $2 $3 ;;
  "logs") _nx_logs $2 $3 ;;
  "networks") _nx_networks $2 $3 ;;
  "pause") _nx_generic $1 $2 $3 ;;
  "profiles") _nx_profiles ;;
  "pull") _nx_pull $2 $3 ;;
  "restart") _nx_generic $1 $2 $3 ;;
  "rm") _nx_rm $2 $3 ;;
  "services") _nx_services $2 ;;
  "start") _nx_generic $1 $2 $3 ;;
  "stop") _nx_generic $1 $2 $3 ;;
  "top") _nx_generic $1 $2 $3 ;;
  "unpause") _nx_generic $1 $2 $3 ;;
  "up") _nx_up $2 $3 ;;
  "volumes") _nx_volumes $2 $3 ;;
  *) cat $NEXUS_CLI/help.txt ;;
  esac
}

function _nx_autocomplete() {
  local cur_word opts profiles services
  case ${COMP_CWORD} in
  1) # command
    COMPREPLY=()
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    opts="archive containers images logs networks pause profiles pull restart rm services start stop top unpause up volumes help"

    COMPREPLY=($(compgen -W "${opts}" -- ${cur_word}))
    ;;
  2) # profile
    if [[ "${COMP_WORDS[COMP_CWORD - 1]}" == "profiles" ]]; then
      COMPREPLY=()
    else
      profiles=($(_nx_profiles | awk '{print $1}' | sort))
      cur_word="${COMP_WORDS[COMP_CWORD]}"
      COMPREPLY=($(compgen -W "${profiles[*]}" -- "$cur_word"))
    fi
    ;;
  3) # service
    if [[ "${COMP_WORDS[COMP_CWORD - 2]}" == "services" ]]; then
      COMPREPLY=()
    else
      services=($(_nx_services "${COMP_WORDS[COMP_CWORD - 1]}" | sort))
      cur_word="${COMP_WORDS[COMP_CWORD]}"
      COMPREPLY=($(compgen -W "${services[*]}" -- "$cur_word"))
    fi
    ;;
  esac
  return 0
}
complete -F _nx_autocomplete nx
