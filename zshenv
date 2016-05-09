# load scripts from .bin
export PATH="$HOME/.bin:$PATH"

# setup go
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin

# virtualenvwrapper
export WORKON_HOME=~/.virtualenvs

# Disable Software Flow Control (Ctrl-S and Ctrl-Q)
stty start undef stop undef

export TERM='xterm-256color'
