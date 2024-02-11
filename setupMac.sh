#!/bin/sh

# INSTALL homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# setup homebrew
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# install dev tools
brew install --cask visual-studio-co
brew install --cask gitkraken
brew install --cask pycharm
brew install --cask bitwarden
brew install colima && colima start
brew install docker docker-compose
mkdir -p ~/.docker/cli-plugins
ln -sfn $(brew --prefix)/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
brew install helm
brew install minikube
brew install pipx
pipx install poetry pipenv

# install fish shel
brew install fish
echo 'eval (/opt/homebrew/bin/brew shellenv)' >> ~/.config/fish/config.fish

# install ENV fuction in fish
cp (pwd)/*.fish ~/.config/fish/functions

# install flutter SDK
brew tap leoafarias/fvm
brew install fvm
fvm install stable
fvm global stable
fish_add_path -a ~/fvm/default/bin/