#!/bin/sh
set -e

# Check if Homebrew is installed, install if it's not
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not installed. Installing Homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed"
    echo "Setup homebrew path in zsh"
    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "Homebrew configured"
else
    echo "Homebrew is already installed."
fi

# Install Fish Shell
if ! command -v fish &> /dev/null; then
    echo "Installing Fish shell..."
    brew install fish
    # Add Fish to the list of acceptable shells
    sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
    # Register brew in fish
    echo 'eval (/opt/homebrew/bin/brew shellenv)' >> ~/.config/fish/config.fish
    fish -c fish_add_path /opt/homebrew/bin
    # Change the user's default shell to Fish
    chsh -s /usr/local/bin/fish

    # install fuctions in fish
    mkdir -p ~/.config/fish/functions;
    cp $(pwd)/*.fish ~/.config/fish/functions
else
    echo "Fish shell is already installed."
fi