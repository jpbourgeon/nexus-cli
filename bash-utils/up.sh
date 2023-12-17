function _nx_up() {
    local profile=$1
    local service=$2
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            _nx up --detach "$service"
        else
            _nx --profile "$profile" up --detach
        fi
    else
        _nx --profile all up --detach
    fi
}
