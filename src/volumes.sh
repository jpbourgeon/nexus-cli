function _nx_volumes() {
    local profile=$1
    local service=$2
    local result=""
    local first_iteration=true
    if [ -n "$profile" ]; then
        if [ -n "$service" ]; then
            result="$(_nx_service_check "$profile" "$service" && _nx config --volumes "$service")"
            if [ -n "$result" ]; then echo "$result"; else echo "No volumes in service: $service"; fi
        else
            if [ "$profile" = "all" ]; then
                result="$(_nx --profile all config --volumes)"
                if [ -n "$result" ]; then echo "$result"; else echo "No volumes in profile: $profile"; fi
            else
                ! _nx_profile_check "$profile" && return 1
                services=($(_nx_services "$profile"))
                for service in "${services[@]}"; do
                    if [ "$first_iteration" = true ]; then
                        result="$(_nx config --volumes "$service")"
                        first_iteration=false
                    else
                        temp=$(_nx config --volumes "$service")
                        IFS=$'\n' read -r -d '' -a lines <<<"$temp"
                        result="${lines[*]:1}"
                    fi
                done
                if [ -n "$result" ]; then echo "$result"; else echo "No volumes in profile: $profile"; fi
            fi
        fi
    else
        profile="all"
        result="$(_nx --profile $profile config --volumes)"
        if [ -n "$result" ]; then echo "$result"; else echo "No volumes in profile: $profile"; fi
    fi
}
