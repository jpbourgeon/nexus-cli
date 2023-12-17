function _nx_profiles() {
    _nx config --profiles
}

function _nx_profile_check() {
    local profiles="$(_nx_profiles)"
    local profile="$1"
    if echo "$profiles" | grep -q -w "$profile"; then
        return 0
    else
        echo "No such profile: $profile"
        return 1
    fi
}
