# ~/.bashrc

# Environment/PATH setup (runs for all shells, including non-interactive e.g. Claude Code)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# If not running interactively, stop here
[[ $- != *i* ]] && return

# Aliases
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Completions
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
command -v uv &>/dev/null && eval "$(uv generate-shell-completion bash)"
