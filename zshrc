zmodload zsh/zprof
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# history
HISTSIZE=5000               # How many lines of history to keep in memory
HISTFILE=~/.zsh_history     # Where to save history to disk
SAVEHIST=5000               # Number of history entries to save to disk
setopt    histignoredups    # Erase duplicates in the history file
setopt    appendhistory     # Append history to the history file (no overwriting)
setopt    sharehistory      # Share history across terminals
setopt    incappendhistory  # Immediately append to the history file, not just when a term is killed

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME='basic'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  ssh-agent
)

source "${ZSH}/oh-my-zsh.sh"

# Customize to your needs...

EDITOR=$(which vim)
export EDITOR

PATH=/opt/homebrew/bin:${PATH}
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
PATH=${HOME}/go/bin:${PATH}
PATH=${HOME}/.local/bin:${PATH}
export PATH

# GPG
GPG_TTY=$(tty)
export GPG_TTY

# without this, ls in subshells gets no colour
CLICOLOR=1
export CLICOLOR

ZSH_AUTOSUGGEST_USE_ASYNC=yes
ZSH_HIGHLIGHT_HIGHLIGHTERS=(brackets)
ZSH_AUTOSUGGEST_STRATEGY=(history)

export ZSH_HIGHLIGHT_HIGHLIGHTERS ZSH_AUTOSUGGEST_STRATEGY ZSH_AUTOSUGGEST_USE_ASYNC

alias ll='ls -l'
alias k=kubectl
alias use='kubectl config use-context'

autoload -U compinit
compinit

autoload -U +X bashcompinit && bashcompinit

# kubectl
type kubectl >/dev/null && source <(kubectl completion zsh)

# helm
type helm >/dev/null && source <(helm completion zsh)

# argo
type kubectl-argo-rollout >/dev/null && source <(kubectl argo rollouts completion zsh)
type argo >/dev/null && source <(argo completion zsh)
type argocd >/dev/null && source <(argocd completion zsh)

# aws cli
type aws_completer >/dev/null && complete -C '/usr/local/bin/aws_completer' aws

# fzf
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

bindkey '\el' down-case-word
bindkey '\eu' up-case-word
bindkey '\e#' pound-insert
bindkey '^t' transpose-chars

function eksupdate {
  local profile=$1
  if [ -z "${profile}" ]; then
    echo "eksupdate AWS_PROFILE"
    return
  fi
  echo ${profile}
  for cluster in $(aws eks --profile "${profile}" --region us-east-1 list-clusters | jq -r '.clusters[]'); do
    aws eks --profile "${profile}" --region us-east-1 update-kubeconfig --name "${cluster}" --alias "${cluster}"
  done
}

function kall {
  local ns=$1
  if [ -z "${ns}" ]; then
    ns=$(kubectl config view --minify -o jsonpath='{..namespace}')
  fi

  kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n "${ns}"
}

function ami-name {
  local ami_id=$1
  aws --no-cli-pager ec2 describe-images --image-ids "${ami_id}" --query "Images[].Name" --output text
}

function ami {
  local node=$1
  ami-name $(kubectl get node "${node}" -o json \
    | jq -r '.metadata.labels["karpenter.k8s.aws/instance-ami-id"]//empty,.metadata.labels["eks.amazonaws.com/nodegroup-image"]//empty')
}

function amis {
  ami_ids=($(k get nodes -o json \
    | jq -r '.items[]|[.metadata.name,.metadata.labels["karpenter.k8s.aws/instance-ami-id"]//empty,.metadata.labels["eks.amazonaws.com/nodegroup-image"]//empty]|@tsv'))
  for node_id ami_id in ${ami_ids[@]}; do
    echo "${node_id} ${ami_id} $(ami-name ${ami_id})"
  done
}

function ami-latest {
  local v=${1:-1.24}
  ami-name $(aws --no-cli-pager ssm get-parameter --name /aws/service/eks/optimized-ami/${v}/amazon-linux-2/recommended/image_id --query "Parameter.Value" --output text)
}

function contexts {
  kubectl config get-contexts -o name | awk -F/ '{print $NF}' | sort -u
}

#-e
##THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
chruby ruby-3.1.2

# discard duplicates from PATH and path
typeset -U PATH path
