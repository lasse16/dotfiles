#!/usr/bin/env bash
authenticate-jira() {
    local api_token=$(bw get notes "JIRA LUFTHANSA SYSTEMS PAT TOKEN")
    export JIRA_API_TOKEN="$api_token"
    export JIRA_TOKEN="$api_token"
    export JIRA_AUTH_TYPE="pat"
}

export -f authenticate-jira
