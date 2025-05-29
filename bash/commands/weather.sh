#!/usr/bin/env bash

weather ()
{
    local location=${1:-"Hamburg"}
    curl "wttr.in/$location"
}

export -f weather
