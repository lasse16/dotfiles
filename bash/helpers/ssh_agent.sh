function run_ssh_env {
  . "${SSH_ENV}" > /dev/null
}

function start_ssh_agent {
  echo "Initializing new SSH agent..."
  ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo "succeeded"
  sudo chmod 600 "${SSH_ENV}"

  run_ssh_env;

  # TODO Make a list or setting which keys to enable on which machine
  # Alternatively enable every key in ssh directory (SECURITY)
  #ssh-add ~/.ssh/id_rsa;
  #ssh-add ~/.ssh/id_gitlab;
  #ssh-add ~/.ssh/id_mafiasi;
  #ssh-add ~/.ssh/id_gitlab_uhh;
  #ssh-add ~/.ssh/id_rpi0;
}
