
# fzf
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude "**/.git"'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# vim
set -o vi
alias vim="nvim"
export EDITOR=vim

# other
alias gs="git status"
alias ls="ls -a --group-directories-first --color=auto"
alias rg="rg --smart-case"
