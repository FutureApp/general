#!/bin/bash 
echo" 
source <(kubectl completion bash)
alias watchk="watch kubectl get pods --all-namespaces"
alias bye="sudo shutdown now"
alias reb="sudo reboot now"

alias gitb="git branch"
alias gits="git branch; git status"
alias gitc="git commit -m "
alias dockeri="docker images"
alias wk="watch kubectl get pods --all-namespaces"


alias mini="minikube "
alias cd..="cd .."
alias kube="kubectl "
eval $(minikube docker-env)" >> ~/.bashrc
