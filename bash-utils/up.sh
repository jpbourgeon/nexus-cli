# nexus-up [PROFILE] [SERVICE]
# Create and start containers in the background.
# documentation: https://docs.docker.com/engine/reference/commandline/compose_up/

function _nx-up() {
    local profile=$1
    local service=$2

    if [ -z "$profile" ] || [ "$profile" = "all" ]; then
        sudo docker compose --profile all up --detach
    else
        sudo docker compose --profile "$profile" up --detach "$service"
    fi
}
