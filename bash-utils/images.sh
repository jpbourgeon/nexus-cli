function _nx_images() {
    local profile=$1
    local service=$2
    local first_iteration=true
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            _nx_service_check "$profile" "$service" && _nx images "$service"
        else
            if [ "$profile" = "all" ]; then
                _nx images
            else
                ! _nx_check-profile "$profile" && return 1
                services=($(_nx_services "$profile"))
                for service in "${services[@]}"; do
                    if [ "$first_iteration" = true ]; then
                        _nx images "$service"
                        first_iteration=false
                    else
                        result="$(_nx images "$service")"
                        IFS=$'\n' read -r -d '' -a lines <<<"$result"
                        output="${lines[*]:1}"
                        echo -e "$output"
                    fi
                done
            fi
        fi
    else
        _nx images
    fi
}
