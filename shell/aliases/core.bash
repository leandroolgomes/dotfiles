#!/usr/bin/env bash

# ========================
# terminal
# ========================
alias c='clear'
alias t='tmux'
alias tt='dot terminal tmux tat'
alias tl='dot terminal tmux ls'
alias tn='dot terminal tmux new'
alias ta='dot terminal tmux attach'
alias tk='dot terminal tmux kill'

# ========================
# shell
# ========================
alias reload='source ~/.zshrc' # env -i zsh

# ========================
# scripting
# ========================
alias map='xargs -I%'

# ========================
# work
# ========================
alias ph='dot uber projects alias phabricator'
alias sg='dot uber projects alias sourcegraph'

# ========================
# editors
# ========================
alias vim='nvim'
alias v="dot terminal dashed nvim --"
alias code="dot terminal dashed dot code vscode --"

# ========================
# utils
# ========================
# alias fzf='fzf-tmux'
alias d='dot'
alias n="navi"

# ========================
# git
# ========================
source "${DOTFILES}/shell/aliases/git.bash"

# ========================
# phabricator
# ========================
alias ac="arc diff --create"
alias au="navi best 'Update a diff'"
alias al="navi best 'Land a diff'"

# ========================
# explorer
# ========================

alias o="dot terminal dashed open --"
unalias f &> /dev/null
alias f="dot terminal dashed vifm --"
# alias ls='ls --color=auto'
ls() { has lsd && lsd "$@" || command ls "$@"; }
alias lst="tree -L 2"
cdd() { cd "$@" && ls .; }
mkcd() { mkdir -p -- "$@" && cd -P -- "$@"; }

_safe_cd() { [[ -d "${1:-}" ]] && cd "$1" || echoerr "$1 doesn't exist"; }
j() { _safe_cd "$(dot fs jump global "$@")"; }
jj() { _safe_cd "$(dot fs jump local "$@")"; }
ju() { _safe_cd "$(dot uber projects --clone local "$@")"; }
jd() { _safe_cd "$(dot fs jump dev "$@")"; }
jjf() { _safe_cd "$(dot fs jump file "$@")"; }
up() { _safe_cd "$(dot fs jump up "$@")"; }
jr() { _safe_cd "$(dot fs jump root "$@")"; }
jr() { _safe_cd "$(dot fs jump root "$@")"; }
fdd() { _safe_cd "$(dot fs nav "$@")"; }
alias jv="dot fs jump edit global nvim"
alias jjv="dot fs jump edit local nvim"
alias js="dot fs jump edit global code"
alias jjs="dot fs jump edit local code"
