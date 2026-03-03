# ~/.bashrc - interactive non-login shell config

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc

# History
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Update window size after each command
shopt -s checkwinsize

# Source bash_profile for login-shell setup (ssh-agent, nvm, etc.)
# Guard against infinite recursion since bash_profile sources bashrc
if [[ -z "$_BASHRC_SOURCED" ]]; then
    export _BASHRC_SOURCED=1
    [[ -f ~/.bash_profile ]] && source ~/.bash_profile
fi

# Load aliases
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
