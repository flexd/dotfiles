
# completion
autoload -U compinit
compinit

export VISUAL=vim
export EDITOR=$VISUAL

setopt prompt_subst
# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '
#
# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=4096

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

# Allow [ or ] whereever you want
unsetopt nomatch

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


# Customize to your needs...
export LC_ALL="en_US.UTF-8"
stty start undef stop undef

#alias tmux="tmux -2"
## SSH-agent
SSHPID=`ps ax|grep -c "[s]sh-agent"`
if (( $SSHPID == 0 ))
then
    ssh-agent > ~/.ssh-env
    source ~/.ssh-env
    ssh-add
else
    source ~/.ssh-env
fi
