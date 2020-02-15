: '
------------------------------------------------------------------------------
         FILE:  network
  DESCRIPTION:  oh-my-zsh plugin.
       AUTHOR:  marco treglia markno1.github@gmail.com
      VERSION:  1.0.0
------------------------------------------------------------------------------
'

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
BOLD="$(tput bold)"
NORMAL="$(tput sgr0)"


function Login() {
  if [[ -n "$2" ]]; then
    port=$2
  else
    port=22
  fi
  echo -e "Login into ${1} with port ${2}"
  xhost +
  ssh -2 -p${port} -XY ${1}
}

SetConnection() {
  NAME=$(echo "$1" | tr '[a-z]' '[A-Z]')
  if [[ $NETMASK ]]; then
    address="$3@${NETMASK}.$2"
    alias "$1"="Login ${address} ${4}"
    export "${NAME}_ADDR"=$address
    echo -e "$BLUE $1 $NORMAL : $address  "
  else
    echo -e "No env NETMASK is setted"
  fi
}

function Copy() {
  echo -e "Copying from ${1}  to  ${2}"
  rsync -av --progress -e ssh ${1} ${2}
}


LoadConfiguration(){
  cfg=".net-alias.cfg"
  if [ -f  "$HOME/$cfg" ]; then
    source "$HOME/$cfg"
    echo "[net-alias] $emoji[winking_face]"
  else
    echo "[net-alias]: No $cfg in $HOME. $emoji[dizzy_face]"
  fi
}

LoadConfiguration
