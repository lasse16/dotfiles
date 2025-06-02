#!/usr/bin/env bash

jira() {
	if [[ "$1" == "my-issues" ]]; then
		shift
        command jira issue list -a$(jira me) -s~Done -s~Production -s ~closed --jql 'project in (TCOE, DEVSRV)' $@

	elif [[ "$1" == "devsrv" ]]; then
		shift
        command jira issue list -ax -p DEVSRV -s open $@

	else
		command jira "$@"
	fi
}

export -f jira
