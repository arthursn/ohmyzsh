# Function to update the prompt when a virtual environment is activated/deactivated
update_virtual_env_prompt() {
    # If any of the following variables are unset, there is nothing to do
    if [ -z "${VIRTUAL_ENV+_}" ] ||
        [ -z "${VIRTUAL_ENV_PROMPT+_}" ]; then
        return
    fi

    # If _OLD_VIRTUAL_PS1 it is empty or unset
    if [ -z "$_OLD_VIRTUAL_PS1" ]; then
        # Just in case, try to remove VIRTUAL_ENV_PROMPT from the prefix
        _OLD_VIRTUAL_PS1="${PS1#$VIRTUAL_ENV_PROMPT}"
    fi

    # If VIRTUAL_ENV_DISABLE_PROMPT is not set to null, then reset to old prompt
    if ! [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ]; then
        PS1="$_OLD_VIRTUAL_PS1"
        return
    fi

    local prompt_python_msg
    local python_exe

    # Exit code will determine whether python executable exists or not
    python_exe=$(which python)

    if [ $? -ne 0 ]; then
        prompt_python_msg="Error! Python not found"
    elif ! [[ "$python_exe" == "$VIRTUAL_ENV"* ]]; then
        prompt_python_msg="Error! Python executable isn't in VIRTUAL_VENV"
    else
        # Get Python version from the virtual environment
        local python_version=$(python --version 2>&1 | cut -d' ' -f2)
        python_version=${python_version//$'\r'/} # Remove carriage return

        # Extract the environment name without parentheses and create a new prompt
        local venv_name=${VIRTUAL_ENV_PROMPT//[()]/}
        venv_name=${venv_name%% *} # Remove any trailing spaces

        prompt_python_msg="$venv_name $python_version"
    fi

    local python_icon
    if ! [ -z ${OMZ_PYTHON_ICON+_} ]; then
        python_icon="$OMZ_PYTHON_ICON "
    fi
    local prompt_prefix="($python_icon$prompt_python_msg) "

    # Set custom prompt
    PS1="$prompt_prefix${_OLD_VIRTUAL_PS1-}"
}

# Add our function to precmd hooks to run before each prompt
autoload -U add-zsh-hook
add-zsh-hook precmd update_virtual_env_prompt
