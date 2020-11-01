#!/bin/bash
function get_executing_directory(){
	dirname "$(readlink -f "$0")"
}
