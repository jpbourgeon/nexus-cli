#!/bin/bash

alias _nx='sudo docker compose -f "$NEXUS_PROJECT_PATH/docker-compose.yml"'

source $NEXUS_BASH_UTILS_PATH/profiles.sh
source $NEXUS_BASH_UTILS_PATH/services.sh
source $NEXUS_BASH_UTILS_PATH/containers.sh
# source $NEXUS_BASH_UTILS_PATH/networks.sh
# source $NEXUS_BASH_UTILS_PATH/volumes.sh
source $NEXUS_BASH_UTILS_PATH/images.sh
# source $NEXUS_BASH_UTILS_PATH/proc.sh
# source $NEXUS_BASH_UTILS_PATH/logs.sh
source $NEXUS_BASH_UTILS_PATH/up.sh
# source $NEXUS_BASH_UTILS_PATH/pause.sh
# source $NEXUS_BASH_UTILS_PATH/unpause.sh
# source $NEXUS_BASH_UTILS_PATH/stop.sh
# source $NEXUS_BASH_UTILS_PATH/start.sh
# source $NEXUS_BASH_UTILS_PATH/restart.sh
# source $NEXUS_BASH_UTILS_PATH/pull.sh
# source $NEXUS_BASH_UTILS_PATH/rm.sh
# source $NEXUS_BASH_UTILS_PATH/nuke.sh
# source $NEXUS_BASH_UTILS_PATH/help.sh

function nx() {
  case "$1" in
  "profiles")
    _nx_profiles
    ;;
  "services")
    _nx_services $2
    ;;
  "containers")
    _nx_containers $2 $3
    ;;
  "images")
    _nx_images $2 $3
    ;;
  "up")
    _nx_up $2 $3
    ;;
  *)
    cat $NEXUS_BASH_UTILS_PATH/help.txt
    ;;
  esac
}

function _nx_autocomplete() {
  local cur_word opts profiles services
  case ${COMP_CWORD} in
  1) # command
    COMPREPLY=()
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    opts="profiles services containers networks volumes images proc logs up pause unpause stop start restart pull rm nuke help"

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
