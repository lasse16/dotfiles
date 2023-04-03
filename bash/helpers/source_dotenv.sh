#!/bin/bash

source_env () {
	local ENV_FILE=".env"
	if [[ ! -f $ENV_FILE ]]
	then
		export $(cat $ENV_FILE | xargs)
	else
		echo "No .env file found"
	fi
}

export -f source_env
