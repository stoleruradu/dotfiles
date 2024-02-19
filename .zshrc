export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DOTNET_ROOT="/usr/local/share/dotnet"

alias th='tmux new -s ${PWD##*/}'
alias zshrc="nvim ~/.zshrc"
alias ls=exa
alias gg="git branch -vv | grep ': gone]' | grep -v \"\*\" | awk '{ print \$1; }'"
alias ggD="git branch -vv | grep ': gone]' | grep -v \"\*\" | awk '{ print \$1; }' | xargs -r git branch -D"

eval "$(starship init zsh)"

