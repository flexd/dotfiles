# Add PYENV_ROOT to PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"

# load scripts from .bin
export PATH="$HOME/.bin:$PATH"
