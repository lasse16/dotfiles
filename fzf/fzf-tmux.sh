#!/usr/bin/env bash
# fzf-tmux: starts fzf in a tmux pane
# usage: fzf-tmux [LAYOUT OPTIONS] [--] [FZF OPTIONS]

fzf-tmux(){

fail() {
  >&2 echo "$1"
  exit 2
}

fzf="$(command -v fzf 2> /dev/null)" || fzf="$(dirname "$0")/fzf"
[[ -x "$fzf" ]] || fail 'fzf executable not found'

tmux_args=()
args=()
opt=""
skip=""
swap=""
close=""
term=""
[[ -n "$LINES" ]] && lines=$LINES || lines=$(tput lines) || lines=$(tmux display-message -p "#{pane_height}")
[[ -n "$COLUMNS" ]] && columns=$COLUMNS || columns=$(tput cols) || columns=$(tmux display-message -p "#{pane_width}")

help() {
  >&2 echo 'usage: fzf-tmux [LAYOUT OPTIONS] [--] [FZF OPTIONS]

  LAYOUT OPTIONS:
    (default layout: -d 50%)

    Popup window (requires tmux 3.2 or above):
      -p [WIDTH[%][,HEIGHT[%]]]  (default: 50%)
      -w WIDTH[%]
      -h HEIGHT[%]
      -x COL
      -y ROW

    Split pane:
      -u [HEIGHT[%]]             Split above (up)
      -d [HEIGHT[%]]             Split below (down)
      -l [WIDTH[%]]              Split left
      -r [WIDTH[%]]              Split right
'
  exit
}

while [[ $# -gt 0 ]]; do
  arg="$1"
  shift
  [[ -z "$skip" ]] && case "$arg" in
    -)
      term=1
      ;;
    --help)
      help
      ;;
    --version)
      echo "fzf-tmux (with fzf $("$fzf" --version))"
      exit
      ;;
    -p*|-w*|-h*|-x*|-y*|-d*|-u*|-r*|-l*)
      if [[ "$arg" =~ ^-[pwhxy] ]]; then
        [[ "$opt" =~ "-K -E" ]] || opt="-K -E"
      elif [[ "$arg" =~ ^.[lr] ]]; then
        opt="-h"
        if [[ "$arg" =~ ^.l ]]; then
          opt="$opt -d"
          swap="; swap-pane -D ; select-pane -L"
          close="; tmux swap-pane -D"
        fi
      else
        opt=""
        if [[ "$arg" =~ ^.u ]]; then
          opt="$opt -d"
          swap="; swap-pane -D ; select-pane -U"
          close="; tmux swap-pane -D"
        fi
      fi
      if [[ ${#arg} -gt 2 ]]; then
        size="${arg:2}"
      else
        if [[ "$1" =~ ^[0-9%,]+$ ]] || [[ "$1" =~ ^[A-Z]$ ]]; then
          size="$1"
          shift
        else
          continue
        fi
      fi

      if [[ "$arg" =~ ^-p ]]; then
        if [[ -n "$size" ]]; then
          w=${size%%,*}
          h=${size##*,}
          opt="$opt -w$w -h$h"
        fi
      elif [[ "$arg" =~ ^-[whxy] ]]; then
        opt="$opt ${arg:0:2}$size"
      elif [[ "$size" =~ %$ ]]; then
        size=${size:0:((${#size}-1))}
        if [[ -n "$swap" ]]; then
          opt="$opt -p $(( 100 - size ))"
        else
          opt="$opt -p $size"
        fi
      else
        if [[ -n "$swap" ]]; then
          if [[ "$arg" =~ ^.l ]]; then
            max=$columns
          else
            max=$lines
          fi
          size=$(( max - size ))
          [[ $size -lt 0 ]] && size=0
          opt="$opt -l $size"
        else
          opt="$opt -l $size"
        fi
      fi
      ;;
    --)
      # "--" can be used to separate fzf-tmux options from fzf options to
      # avoid conflicts
      skip=1
      tmux_args=("${args[@]}")
      args=()
      continue
      ;;
    *)
      args+=("$arg")
      ;;
  esac
  [[ -n "$skip" ]] && args+=("$arg")
done

if [[ -z "$TMUX" ]]; then
  "$fzf" "${args[@]}"
  exit $?
fi

# --height option is not allowed. CTRL-Z is also disabled.
args=("${args[@]}" "--no-height" "--bind=ctrl-z:ignore")

# Handle zoomed tmux pane without popup options by moving it to a temp window
if [[ ! "$opt" =~ "-K -E" ]] && tmux list-panes -F '#F' | grep -q Z; then
  zoomed_without_popup=1
  original_window=$(tmux display-message -p "#{window_id}")
  tmp_window=$(tmux new-window -d -P -F "#{window_id}" "bash -c 'while :; do for c in \\| / - '\\;' do sleep 0.2; printf \"\\r\$c fzf-tmux is running\\r\"; done; done'")
  tmux swap-pane -t $tmp_window \; select-window -t $tmp_window
fi

set -e

# Clean up named pipes on exit
id=$RANDOM
argsf="${TMPDIR:-/tmp}/fzf-args-$id"
fifo1="${TMPDIR:-/tmp}/fzf-fifo1-$id"
fifo2="${TMPDIR:-/tmp}/fzf-fifo2-$id"
fifo3="${TMPDIR:-/tmp}/fzf-fifo3-$id"
tmux_win_opts=( $(tmux show-window-options remain-on-exit \; show-window-options synchronize-panes | sed '/ off/d; s/^/set-window-option /; s/$/ \\;/') )
cleanup() {
  \rm -f $argsf $fifo1 $fifo2 $fifo3

  # Restore tmux window options
  if [[ "${#tmux_win_opts[@]}" -gt 0 ]]; then
    eval "tmux ${tmux_win_opts[*]}"
  fi

  # Remove temp window if we were zoomed without popup options
  if [[ -n "$zoomed_without_popup" ]]; then
    tmux display-message -p "#{window_id}" > /dev/null
    tmux swap-pane -t $original_window \; \
      select-window -t $original_window \; \
      kill-window -t $tmp_window \; \
      resize-pane -Z
  fi

  if [[ $# -gt 0 ]]; then
    trap - EXIT
    exit 130
  fi
}
trap 'cleanup 1' SIGUSR1
trap 'cleanup' EXIT

envs="export TERM=$TERM "
[[ "$opt" =~ "-K -E" ]] && FZF_DEFAULT_OPTS="--margin 0,1 $FZF_DEFAULT_OPTS"
[[ -n "$FZF_DEFAULT_OPTS"    ]] && envs="$envs FZF_DEFAULT_OPTS=$(printf %q "$FZF_DEFAULT_OPTS")"
[[ -n "$FZF_DEFAULT_COMMAND" ]] && envs="$envs FZF_DEFAULT_COMMAND=$(printf %q "$FZF_DEFAULT_COMMAND")"
echo "$envs;" > "$argsf"

# Build arguments to fzf
opts=$(printf "%q " "${args[@]}")

pppid=$$
echo -n "trap 'kill -SIGUSR1 -$pppid' EXIT SIGINT SIGTERM;" >> $argsf
close="; trap - EXIT SIGINT SIGTERM $close"

export TMUX=$(cut -d , -f 1,2 <<< "$TMUX")
mkfifo -m o+w $fifo2
if [[ "$opt" =~ "-K -E" ]]; then
  cat $fifo2 &
  if [[ -n "$term" ]] || [[ -t 0 ]]; then
    cat <<< "\"$fzf\" $opts > $fifo2; out=\$? $close; exit \$out" >> $argsf
  else
    mkfifo $fifo1
    cat <<< "\"$fzf\" $opts < $fifo1 > $fifo2; out=\$? $close; exit \$out" >> $argsf
    cat <&0 > $fifo1 &
  fi

  # tmux dropped the support for `-K`, `-R` to popup command
  #   TODO: We can remove this once tmux 3.2 is released
  if [[ ! "$(tmux popup --help 2>&1)" =~ '-R shell-command' ]]; then
    opt="${opt/-K/}"
  else
    opt="${opt} -R"
  fi

  tmux popup -d "$PWD" "${tmux_args[@]}" $opt "bash $argsf" > /dev/null 2>&1
  exit $?
fi

mkfifo -m o+w $fifo3
if [[ -n "$term" ]] || [[ -t 0 ]]; then
  cat <<< "\"$fzf\" $opts > $fifo2; echo \$? > $fifo3 $close" >> $argsf
else
  mkfifo $fifo1
  cat <<< "\"$fzf\" $opts < $fifo1 > $fifo2; echo \$? > $fifo3 $close" >> $argsf
  cat <&0 > $fifo1 &
fi
tmux set-window-option synchronize-panes off \;\
  set-window-option remain-on-exit off \;\
  split-window -c "$PWD" $opt "${tmux_args[@]}" "bash -c 'exec -a fzf bash $argsf'" $swap \
  > /dev/null 2>&1 || { "$fzf" "${args[@]}"; exit $?; }
cat $fifo2
exit "$(cat $fifo3)"

}

export -f fzf-tmux
