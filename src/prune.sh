function _nx_prune() {
    local profile service
    profile=$1
    service=$2
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            _nx_service_check "$profile" "$service" && _nx --profile "$profile" down --rmi all --volumes "$service"
        else
            _nx_profile_check "$profile" && _nx --profile "$profile" down --rmi all --volumes
        fi
    else
        _nx --profile all down --rmi all --volumes
    fi

}
