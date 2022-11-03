# prompt
PROMPT=$'${lead} ${time}${separator}${(e)context}${separator}${current}${(e)has_branch}${(e)branch}${separator}SHLVL=${SHLVL}\n${(e)pprompt}'

# right-hand prompt
RPROMPT=''

# prompt components
separator="%(?.%{$fg[green]%}.%{$fg[red]%}) | %{$reset_color%}"
lead="%(?.%{$fg[green]%}.%{$fg[red]%})####%{$reset_color%}"
time="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
current="%(?.%{$fg_bold[grey]%}.%{$fg[red]%})%~%{$reset_color%}"
context='%(?.%{$fg[magenta]%}.%{$fg[red]%})$(has_k8s_context)%{$reset_color%}'
has_branch='%(?.%{$fg[green]%}.%{$fg[red]%})$(has_git_branch)%{$reset_color%}'
branch='%(?.%{$fg[magenta]%}.%{$fg[red]%})$(git_current_branch)%{$reset_color%}'
pprompt='%(?.%{$fg_bold[grey]%}.%{$fg[red]%}); %{$reset_color%}'

# functions
function has_git_branch() {
  [[ "$(git_current_branch)" != "" ]] && echo " | "
}

function has_k8s_context() {
  ctx=$(kubectl config current-context 2>/dev/null)
  if [ "$?" -ne 0 ]; then
    ctx="none"
  fi
  echo "${ctx}"
}
