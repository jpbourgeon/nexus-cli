#!/bin/bash

alias _nx='sudo docker compose -f "$NEXUS_APPS/docker-compose.yml"'

source $NEXUS_CLI/up.sh
# source $NEXUS_CLI/pause.sh
# source $NEXUS_CLI/unpause.sh
# source $NEXUS_CLI/stop.sh
# source $NEXUS_CLI/start.sh
# source $NEXUS_CLI/restart.sh

source $NEXUS_CLI/profiles.sh
source $NEXUS_CLI/services.sh
source $NEXUS_CLI/containers.sh
# source $NEXUS_CLI/networks.sh
source $NEXUS_CLI/volumes.sh
source $NEXUS_CLI/images.sh
# source $NEXUS_CLI/proc.sh
# source $NEXUS_CLI/logs.sh

# source $NEXUS_CLI/pull.sh

# source $NEXUS_CLI/down.sh
# source $NEXUS_CLI/nuke.sh

# source $NEXUS_CLI/help.sh

function nx() {
  case "$1" in
  "up") _nx_up $2 $3 ;;

  "profiles") _nx_profiles ;;
  "services") _nx_services $2 ;;
  "containers") _nx_containers $2 $3 ;;
  "images") _nx_images $2 $3 ;;
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
    opts="up pause unpause stop start restart profiles services containers networks volumes images proc logs pull rm nuke help"

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
