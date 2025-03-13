nix() {
  if [[ $1 == "dev" ]]; then
    shift
    command nix develop "$@"
  else
    command nix "$@"
  fi
}
