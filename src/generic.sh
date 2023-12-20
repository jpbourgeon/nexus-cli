function _nx_generic() {
    local action profile service
    action=$1
    profile=$2
    service=$3
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            _nx_service_check "$profile" "$service" && _nx --profile "$profile" "$action" "$service"
        else
            _nx_profile_check "$profile" && _nx --profile "$profile" "$action"
        fi
    else
        _nx --profile all "$action"
    fi
}
