# load scripts from .bin
export PATH="$HOME/.bin:$PATH"

# setup go
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin

# Disable Software Flow Control (Ctrl-S and Ctrl-Q)
stty start undef stop undef
