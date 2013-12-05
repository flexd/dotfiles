if [[ ! $DISABLE_VENV_CD -eq 1 ]]; then
    # Automatically activate Git projects's virtual environments based on the
    # directory name of the project. Virtual environment name can be overridden
    # by placing a .venv file in the project root with a virtualenv name in it
    function workon_cwd {
        if [ ! $WORKON_CWD ]; then
            WORKON_CWD=1
            # Check if this is a Git repo
            PROJECT_ROOT=`git rev-parse --show-toplevel 2> /dev/null`
            if (( $? != 0 )); then
                PROJECT_ROOT="."
            fi
            # Check for virtualenv name override
            if [[ -f "$PROJECT_ROOT/.venv" ]]; then
                ENV_NAME=`cat "$PROJECT_ROOT/.venv"`
            elif [[ "$PROJECT_ROOT" != "." ]]; then
                ENV_NAME=`basename "$PROJECT_ROOT"`
            else
                ENV_NAME=""
            fi
            if [[ "$ENV_NAME" != "" ]]; then
                # Activate the environment only if it is not already active
                if [[ "$PYENV_VERSION" != "$WORKON_HOME/$ENV_NAME" ]]; then
                    if [[ -e "$PYENV_ROOT/versions/$ENV_NAME/" ]]; then
                        pyenv shell "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
                    fi
                fi
            elif [ $CD_VIRTUAL_ENV ]; then
                # We've just left the repo, deactivate the environment
                # Note: this only happens if the virtualenv was activated automatically
                pyenv shell --unset && unset CD_VIRTUAL_ENV
            fi
            unset PROJECT_ROOT
            unset WORKON_CWD
        fi
    }

    # Append workon_cwd to the chpwd_functions array, so it will be called on cd
    # http://zsh.sourceforge.net/Doc/Release/Functions.html
    # TODO: replace with 'add-zsh-hook chpwd workon_cwd' when oh-my-zsh min version is raised above 4.3.4
    if (( ${+chpwd_functions} )); then
        if (( $chpwd_functions[(I)workon_cwd] == 0 )); then
            set -A chpwd_functions $chpwd_functions workon_cwd
        fi
    else
        set -A chpwd_functions workon_cwd
    fi
fi