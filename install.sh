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
    # Register brew in fish
    fish -c fish_add_path /opt/homebrew/bin
    # Change the user's default shell to Fish
    chsh -s /usr/local/bin/fish
else
    echo "Fish shell is already installed."
fi

# Find the actual path to the Fish shell
fish_path=$(which fish)

if ! grep -q "$fish_path" /etc/shells; then
    echo "Adding fish path to the shells"
    sudo sh -c "echo $fish_path >> /etc/shells"
else
    echo "Fish path found in /etc/shells"
fi

if [ "$SHELL" != "$fish_path" ]; then
    echo "Change the default shell to Fish"
    chsh -s "$fish_path"
else
    echo "Default shell is Fish"
fi

if ! grep -q 'eval (/opt/homebrew/bin/brew shellenv)' ~/.config/fish/config.fish; then
    echo "Register homebrew bin in config.fish"
    echo 'eval (/opt/homebrew/bin/brew shellenv)' >> ~/.config/fish/config.fish
else
    echo "Homebrew bin registered in config.fish"
fi

echo "Install fuctions in fish..."
mkdir -p ~/.config/fish/functions;
cp $(pwd)/*.fish ~/.config/fish/functions
echo "DONE"