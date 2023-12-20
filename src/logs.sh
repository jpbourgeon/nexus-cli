function _nx_logs() {
    local action profile service
    profile=$1
    service=$2
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            _nx_service_check "$profile" "$service" && _nx --profile "$profile" logs --timestamps --tail="50"
        else
            _nx_profile_check "$profile" && _nx --profile "$profile" logs --timestamps --tail="50"
        fi
    else
        _nx --profile all logs --timestamps --tail="50"
    fi
}
