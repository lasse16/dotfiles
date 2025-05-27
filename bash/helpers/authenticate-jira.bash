#!/usr/bin/env bash
authenticate-jira() {
    local api_token=$(bw get notes "JIRA LUFTHANSA SYSTEMS PAT TOKEN")
    export JIRA_API_TOKEN="$api_token"
}

export -f authenticate-jira
