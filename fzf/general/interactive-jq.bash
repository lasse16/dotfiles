#!/usr/bin/env bash


ijq ()
{

if [[ -z $1 ]] || [[ $1 == "-" ]]; then
    input=$(mktemp)
    trap "rm -f $input" EXIT
    cat /dev/stdin > $input
else
    input=$1
fi

echo '' \
    | fzf --preview-window='down:99%' \
          --print-query \
          --preview "sleep 0.3;jq --color-output -r {q} $input" \
          --query "." \
          --bind="ctrl-y:execute-silent(echo {q} | copy -i)"\
          --bind="enter:become(jq {q} $input )"\
          --header=$'<C-y>: Copy query\n<enter> Apply query'\
          --header-border --input-border  \
          --color='input-border:green,header:bright-black,header-border:bright-black' \

}

export -f ijq
