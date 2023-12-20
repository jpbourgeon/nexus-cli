function _nx_up() {
    local profile service
    profile=$1
    service=$2
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            _nx_service_check "$profile" "$service" && _nx --profile "$profile" up --detach "$service"
        else
            _nx_profile_check "$profile" && _nx --profile "$profile" up --detach
        fi
    else
        _nx --profile all up --detach
    fi
}
