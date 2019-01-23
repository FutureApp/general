source <(kubectl completion bash)
alias watchk="watch kubectl get pods --all-namespaces"
alias bye="sudo shutdown now"
alias reb="sudo reboot now"

alias mgitb="git branch"
alias mgits="git branch; git status"
alias mgitc="git commit -m "
alias dockeri="docker images"
alias dockerrmiton="docker "
alias wk="watch kubectl get pods --all-namespaces"


alias mini="minikube "
alias cd..="cd .."
alias kube="kubectl "
eval $(minikube docker-env)
