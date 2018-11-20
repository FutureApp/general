
# Cleans the docker enviromenten by writting the alias
alias dockercli='docker rmi $(docker images -a --filter=dangling=true -q)'
alias dockerclp='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
