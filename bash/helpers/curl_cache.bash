#!/usr/bin/env bash

curl_cache() {
    # Cache expiration time (15 minutes in seconds)
    local expire_age=900

    local url="$1"
    

    local cache_name=$(echo -n "$url" | md5sum | awk '{print $1}')

    local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/curl"
    mkdir -p "$cache_dir"
    local cache_file="$cache_dir/$cache_name"


    # Check if cached file exists and is fresh enough
    if [ -f "$cache_file" ] && [ $(($(date +%s) - $(stat -c %Y "$cache_file"))) -lt $expire_age ]; then
        cat "$cache_file"
    else
        # Download and cache with curl
        curl -sSfL "$url" > "$cache_file.tmp" && mv "$cache_file.tmp" "$cache_file"
        cat "$cache_file"
    fi
}
export -f curl_cache
