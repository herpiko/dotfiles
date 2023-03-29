export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/opt/homebrew/opt/python@3.8/libexec/bin"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Alias
alias vim=nvim
alias grep="grep --exclude-dir=node_modules "
alias kubeprod='f() { kubectl --kubeconfig ~/config-prod $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 };f'
alias kubestaging='f() { kubectl --kubeconfig ~/config-staging $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 };f'
alias minikube-ecr-login='kubectl create secret docker-registry regcred --namespace=default --docker-server=https://ACCOUNT_ID.dkr.ecr.ap-southeast-3.amazonaws.com --docker-username=AWS --docker-password='''
alias gitrsa="GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes' git"
alias dev="tmux new-session \; send-keys 'vim' C-m \; split-window -v -p 20 \; select-window -t 0 \;"
alias aws_ecr_login="aws ecr get-login-password --region ap-southeast-3 | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.ap-southeast-3.amazonaws.com"
