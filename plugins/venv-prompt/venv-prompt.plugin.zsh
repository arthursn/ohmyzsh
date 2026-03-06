# Function to update the prompt when a virtual environment is activated/deactivated
update_virtual_env_prompt() {
    # If VIRTUAL_ENV_DISABLE_PROMPT is set, don't modify the prompt
    ! [ -z "${VIRTUAL_ENV_DISABLE_PROMPT+_}" ] && return

    if ! [ -z "${VIRTUAL_ENV+_}" ] && ! [ -z "${VIRTUAL_ENV_PROMPT+_}" ]; then
        unset error_msg

        python_exe=$(which python)
        if [[ $? -ne 0 ]]; then
            error_msg="Error! Python not found"
        elif ! [[ "$python_exe" == "$VIRTUAL_ENV"* ]]; then
            error_msg="Error! Python path doesn't match set VIRTUAL_VENV"
        fi

        # Save the original PS1 if not already saved
        if [[ -z $_OLD_VIRTUAL_PS1 ]]; then
            _OLD_VIRTUAL_PS1="${PS1-}"
        fi

        if [[ -z "${error_msg+_}" ]]; then
            # Get Python version from the virtual environment
            python_version=$(python --version 2>&1 | cut -d' ' -f2)

            # Extract the environment name without parentheses and create a new prompt
            venv_name=${VIRTUAL_ENV_PROMPT//[()]/}
            venv_name=${venv_name%% *} # Remove any trailing spaces

            custom_prompt="($venv_name $python_version)"

            # Set custom prompt
        else
            custom_prompt="($error_msg)"
        fi

        PS1="$custom_prompt ${_OLD_VIRTUAL_PS1-}"
    elif ! [ -z "${_OLD_VIRTUAL_PS1+_}" ]; then
        # Restore original PS1 when deactivated
        PS1="$_OLD_VIRTUAL_PS1"
        unset _OLD_VIRTUAL_PS1
    fi
}

# Add our function to precmd hooks to run before each prompt
autoload -U add-zsh-hook
add-zsh-hook precmd update_virtual_env_prompt
