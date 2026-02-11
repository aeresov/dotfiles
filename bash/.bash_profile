# ~/.bash_profile
[[ -f ~/.profile ]] && source ~/.profile
[[ -f ~/.bashrc ]] && source ~/.bashrc

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" > /dev/null
    for key in ~/.ssh/id_*; do
        [[ -f "$key" && "$key" != *.pub ]] && ssh-add "$key" 2>/dev/null
    done
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

eval "$(uv generate-shell-completion bash)"

