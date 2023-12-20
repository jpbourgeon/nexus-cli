function _nx_services() {
    local profile=$1
    echo "SERVICE"
    if [ -n "$profile" ]; then
        _nx_profile_check "$profile" && _nx --profile "$profile" config --services
    else
        _nx --profile all config --services
    fi
}

function _nx_service_check() {
    local profile="$1"
    local services="$(_nx_services $profile)"
    local service="$2"
    if echo "$services" | grep -q -w "$service"; then
        return 0
    else
        echo "No such service \"$service\" found in profile \"$profile\"".
        return 1
    fi
}
