# Function to update the prompt when a virtual environment is activated/deactivated
update_virtual_env_prompt() {
    which python &>/dev/null
    [[ $? -ne 0 ]] && return

    # If VIRTUAL_ENV_DISABLE_PROMPT is set, don't modify the prompt
    ! [ -z "${VIRTUAL_ENV_DISABLE_PROMPT+_}" ] && return

    if ! [ -z "${VIRTUAL_ENV+_}" ] && ! [ -z "${VIRTUAL_ENV_PROMPT+_}" ]; then
        # Save the original PS1 if not already saved
        if [[ -z $_OLD_VIRTUAL_PS1 ]]; then
            _OLD_VIRTUAL_PS1="${PS1-}"
        fi

        # Get Python version from the virtual environment
        local python_version=$(python --version 2>&1 | cut -d' ' -f2)

        # Extract the environment name without parentheses and create a new prompt
        local venv_name=${VIRTUAL_ENV_PROMPT//[()]/}
        venv_name=${venv_name%% *} # Remove any trailing spaces

        # Create custom prompt with Python logo
        local custom_prompt="($venv_name $python_version) "

        # Set custom prompt
        PS1="$custom_prompt${_OLD_VIRTUAL_PS1-}"
    elif ! [ -z "${_OLD_VIRTUAL_PS1+_}" ]; then
        # Restore original PS1 when deactivated
        PS1="$_OLD_VIRTUAL_PS1"
        unset _OLD_VIRTUAL_PS1
    fi
}

# Add our function to precmd hooks to run before each prompt
autoload -U add-zsh-hook
add-zsh-hook precmd update_virtual_env_prompt
