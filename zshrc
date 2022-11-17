zmodload zsh/zprof
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# history
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
setopt    histignoredups    #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

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
  zsh-completions
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

#alias jdebug=kubectl exec $(kubectl get pods -oname | shuf | head -n1) -c main -- sh -c 'ps -o pid,vsz,rss,args; echo; grep . /sys/fs/cgroup/memory/memory.*_in_bytes; echo; jcmd 1 GC.heap_info; echo; jmap -histo 1|grep -EA20 "class name|^Total"; echo; echo thread count $(jcmd 1 Thread.print|grep Thread.State|wc -l); java -XX:+PrintFlagsFinal -version 2>&1| grep -w ThreadStackSize; echo; df -k|grep -E "Filesystem|tmpfs"'

autoload -U compinit
compinit

autoload -U +X bashcompinit && bashcompinit

# aws cli
type aws_completer >/dev/null && complete -C '/usr/local/bin/aws_completer' aws

# fzf
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

bindkey '\el' down-case-word
bindkey '\eu' up-case-word
bindkey '\e#' pound-insert
bindkey '^t' transpose-chars

#-e
##THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
