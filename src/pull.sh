function _nx_pull() {
    local profile service
    profile=$1
    service=$2
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            _nx_service_check "$profile" "$service" && _nx --profile "$profile" pull --include-deps "$service"
        else
            _nx_profile_check "$profile" && _nx --profile "$profile" pull --include-deps
        fi
    else
        _nx --profile all pull --include-deps
    fi
}
