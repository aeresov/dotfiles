# ~/.bash_profile
[[ -f ~/.profile ]] && source ~/.profile
[[ -f ~/.bashrc ]] && source ~/.bashrc

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" > /dev/null
    for key in ~/.ssh/id_*; do
        [[ -f "$key" && "$key" != *.pub ]] && ssh-add "$key" 2>/dev/null
    done
fi


