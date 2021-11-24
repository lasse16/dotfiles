#!/usr/bin/env bash
mail() {
	local mail_accounts="uni professional private"
	local tmp_file_path="/tmp/mails"
	# Get Ids of mails across all accounts
	#echo "$mail_accounts" | xargs -n 1 | xargs -P 3 -t -I {} sh -c "himalaya -a {} -o json list | jq -r '.response[].id'" | fzf
	# Get Ids of mails across all accounts
	echo "$mail_accounts" | xargs -n 1 | xargs -t -I {} sh -c "himalaya -a {} -o json list | jq  '.response[] | { id: .id, subject: .subject, sender: .sender, date: .date }' >> $tmp_file_path"
	cat "$tmp_file_path"
	# echo "$mail_accounts" | xargs -n 1 | xargs -P 3 -t -I {} sh -c "himalaya -a {} -o json list | jq -r '.response[]|@sh'"
	# trap "rm -f $tmp_file_path" EXIT
	# local header=$(head -n 1 "$tmp_file_path")
	# local search_results=$(tail -n +1)
	# echo "$search_results" | fzf --header "$header"
}

export -f mail
