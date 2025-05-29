#!/usr/bin/env bash

weather ()
{
    local location=${1:-"Hamburg"}
    if [[ $# -ge 1 ]]; then
       shift
    fi

    curl_cache "$@" "wttr.in/$location"
}
