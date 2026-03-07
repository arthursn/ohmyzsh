# Venv-prompt plugin

This plugin enhances your command prompt when working with Python virtual environments. It automatically updates your prompt to display the active virtual environment name and Python version.

## Features

- Automatically detects when a virtual environment is activated
- Shows the virtual environment name and Python version in your prompt
- Displays error messages if Python is not found or doesn't match the virtual environment
- Restores your original prompt when the virtual environment is deactivated
- Respects the `VIRTUAL_ENV_DISABLE_PROMPT` environment variable

## Usage

1. Add the plugin to your Oh My Zsh configuration:

   ```zsh
   plugins=(... venv-prompt)
   ```

2. Activate a Python virtual environment as you normally would:

   ```zsh
   source venv/bin/activate
   ```

3. Your prompt will automatically update to show the virtual environment name and Python version:

   ```
   (venv 3.9.0) username@host:~$
   ```

4. When you deactivate the virtual environment, your prompt will return to normal:

   ```zsh
   deactivate
   ```

## Configuration

- Set `VIRTUAL_ENV_DISABLE_PROMPT=1` before activating a virtual environment to prevent this plugin from modifying your prompt.

## Compatibility

This plugin works with standard Python virtual environments and any tool that sets the `VIRTUAL_ENV`, `VIRTUAL_ENV_PROMPT`, and `_OLD_VIRTUAL_PS1` environment variables, including:

- `venv` module
- `virtualenv`
