function _nx_networks() {
    local profile service
    profile=$1
    service=$2
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            _nx_service_check "$profile" "$service" && _nx_networks_extract "$(_nx --profile "$profile" config "$service" --format json)"
        else
            _nx_profile_check "$profile" && _nx_networks_extract "$(_nx --profile "$profile" config --format json)"
        fi
    else
        _nx_networks_extract "$(_nx --profile all config --format json)"
    fi
}

function _nx_networks_extract() {
    local config services service networks network name result
    config=$1
    services=($(echo "$config" | jq -r '.services | keys[]'))
    result="SERVICE\tNETWORK\tDOCKER_NAME"
    for service in "${services[@]}"; do
        network=$(echo "$config" | jq -r ".services[\"$service\"].networks | keys[0]")
        network_name=$(echo "$config" | jq -r ".networks[\"$network\"].name")
        result+="\n$service\t$network\t$network_name"
    done
    echo -e "$result" | column -t -s $'\t'
}
