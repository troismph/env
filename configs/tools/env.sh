#!/bin/bash

export PATH=$PATH:~/tools/go/bin
export GOPATH=~/tools/go
export GOPROXY="https://mirrors.aliyun.com/goproxy/"

alias ecgit='GIT_SSH_COMMAND="ssh -i ~/.ssh/constgz_id_rsa " git'
