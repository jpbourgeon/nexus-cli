function _nx_volumes() {
    local profile service
    profile=$1
    service=$2
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            _nx_service_check "$profile" "$service" && _nx_volumes_extract "$(_nx --profile "$profile" config "$service" --format json)"
        else
            _nx_profile_check "$profile" && _nx_volumes_extract "$(_nx --profile "$profile" config --format json)"
        fi
    else
        _nx_volumes_extract "$(_nx --profile all config --format json)"
    fi
}

function _nx_volumes_extract() {
    local config services service volumes volume source target
    config=$1
    services=($(echo "$config" | jq -r '.services | keys[]'))
    result="SERVICE\tHOST_SOURCE\tCONTAINER_TARGET"
    for service in "${services[@]}"; do
        volumes=($(echo "$config" | jq -r '.services."'$service'".volumes[] | .source, .target'))
        for ((i = 0; i < ${#volumes[@]}; i += 2)); do
            source=${volumes[i]}
            target=${volumes[i + 1]}
            result+="\n$service\t$source\t$target"
        done

    done
    echo -e "$result" | column -t -s $'\t'
}
