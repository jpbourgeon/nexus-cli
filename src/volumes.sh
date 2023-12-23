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
    local config services service volumes container containerExists volume volumeExists type name source target
    config=$1
    services=($(echo "$config" | jq -r '.services | keys[]'))
    result="SERVICE\tTYPE\tNAME\tHOST_SOURCE\tCONTAINER_TARGET"
    for service in "${services[@]}"; do
        volumes=($(echo "$config" | jq -r '.services."'$service'".volumes[] | .type, .source, .target'))
        for ((i = 0; i < ${#volumes[@]}; i += 3)); do
            type=${volumes[i]}
            if [ "$type" = "volume" ]; then
                name=$(echo "$config" | jq -r '.volumes."'${volumes[i + 1]}'".name')
                source=$(echo "$config" | jq -r '.volumes."'${volumes[i + 1]}'".driver_opts.device')
                target=${volumes[i + 2]}
                volumeExists=$(dk volume inspect "$name" 2>/dev/null)
                if [ -n "$volumeExists" ] && [ "$volumeExists" != "[]" ]; then
                    result+="\n$service\t$type\t$name\t$source\t$target"
                fi
            else
                container=($(echo "$config" | jq -r '.services."'$service'".container_name'))
                name=""
                source=${volumes[i + 1]}
                target=${volumes[i + 2]}
                containerExists=$(dk container inspect "$container" 2>/dev/null)
                if [ -n "$containerExists" ] && [ "$containerExists" != "[]" ]; then
                    result+="\n$service\t$type\t$name\t$source\t$target"
                fi
            fi
        done

    done
    echo -e "$result" | column -t -s $'\t'
}
