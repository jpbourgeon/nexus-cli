#!/bin/bash

# import nx subcommands
# source $NEXUS_BASH_UTILS_PATH/containers.sh
# source $NEXUS_BASH_UTILS_PATH/images.sh
# source $NEXUS_BASH_UTILS_PATH/networks.sh
# source $NEXUS_BASH_UTILS_PATH/profiles.sh
# source $NEXUS_BASH_UTILS_PATH/services.sh
# source $NEXUS_BASH_UTILS_PATH/volumes.sh
# source $NEXUS_BASH_UTILS_PATH/top.sh
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
    "up")
        _nx-up $2 $3
        ;;
    *)
        cat $NEXUS_BASH_UTILS_PATH/help.txt
        ;;
  esac
}

function _nx_autocomplete() {
  # Choose an action
  local cur_word opts profiles services
  
  case ${COMP_CWORD} in
    1) # command
      COMPREPLY=()
      cur_word="${COMP_WORDS[COMP_CWORD]}"
      opts="containers images networks profiles services volumes top logs up pause unpause stop start restart pull rm nuke help"

      COMPREPLY=($(compgen -W "${opts}" -- ${cur_word})) 
      ;;
    2) # profile
      profiles=($(docker compose config --profiles | awk '{print $1}' | sort))
      cur_word="${COMP_WORDS[COMP_CWORD]}"
      COMPREPLY=( $(compgen -W "${profiles[*]}" -- "$cur_word") )
      ;;
    3) # service
      services=($(docker compose --profile "${COMP_WORDS[COMP_CWORD -1]}" config --services | sort))
      cur_word="${COMP_WORDS[COMP_CWORD]}"
      COMPREPLY=( $(compgen -W "${services[*]}" -- "$cur_word") )
      ;;
  esac

  return 0
}

complete -F _nx_autocomplete nx


# _nx_up_autocomplete() {
#     local cur_word args
#     cur_word="${COMP_WORDS[COMP_CWORD]}"
    
#     # Get the profiles array
#     profiles=($(docker compose config --profiles | awk '{print $1}' | sort))
    
#     # Check if the first comp word matches an entry of the profiles array
#     if [[ ! " ${profiles[@]} " =~ " ${COMP_WORDS[1]} " ]]; then
#         COMPREPLY=( $(compgen -W "${profiles[*]}" -- "$cur_word") )
#     else
#         # Check if the current word is the second comp word
#         if [[ "$cur_word" == "${COMP_WORDS[1]}" ]]; then
#             COMPREPLY=( $(compgen -W "${profiles[*]}" -- "$cur_word") )
#         elif [[ "$cur_word" == "${COMP_WORDS[2]}" ]]; then
#         fi
#     fi
# }
