#!/bin/bash

# golang settings
export PATH=$PATH:~/tools:~/tools/go/bin:~/.local/bin
export GOPATH=~/tools/go
export GOPROXY="https://mirrors.aliyun.com/goproxy/"

# project ec settings
alias ecgit='GIT_SSH_COMMAND="ssh -i ~/.ssh/constgz_id_rsa " git'

# python virtualenvwrapper settings
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
source $HOME/.local/bin/virtualenvwrapper.sh

# NVM settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pipx settings
eval "$(register-python-argcomplete3 pipx)"
