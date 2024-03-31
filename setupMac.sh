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

# Function to install a tool using Homebrew, handling both regular packages and casks
install_with_brew() {
    local name=$1
    local type=$2  # Can be empty or "cask"

    # Determine if it's a regular package or a cask
    if [ "$type" = "cask" ]; then
        # Check and install cask applications
        if brew list --cask "$name" &> /dev/null; then
            echo "$name is already installed."
        else
            echo "Installing $name..."
            brew install --cask "$name"
        fi
    else
        # Check and install regular packages
        if brew list "$name" &> /dev/null; then
            echo "$name is already installed."
        else
            echo "Installing $name..."
            brew install "$name"
        fi
    fi
}

echo "Select the tools you want to install (separate choices with spaces):"
echo "1. Git"
echo "2. Visual Studio Code"
echo "3. Docker"
echo "4. PyCharm"
echo "5. GitKraken"
echo "6. bitwarden"
echo "7. flycut"
echo "8. PipX"
echo "9. Poetry"
echo "10. PipEnv"
echo "11. Fish"
echo "12. Flutter SDK"
echo "13. Obsidian"
read -p "Enter your choices: " choices

for choice in $choices; do
    case $choice in
        1)
            install_with_brew git
            ;;
        2)
            install_with_brew visual-studio-code cask
            ;;
        3)
            echo "Installing Colima..."
            install_with_brew colima
            colima start
            echo "Install docker"
            install_with_brew docker
            echo "Install docker-compose"
            install_with_brew docker-compose
            echo "Setup docker-compose plugin to be recognizable"
            mkdir -p ~/.docker/cli-plugins
            ln -sfn $(brew --prefix)/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
            ;;
        4)
            install_with_brew pycharm cask
            ;;
        5)
            install_with_brew gitkraken cask
            ;;
        6)
            install_with_brew bitwarden cask
            ;;
        7)
            install_with_brew flycut cask
            ;;
        8)
            install_with_brew pipx
            ;;
        9)
            pipx install poetry
            ;;
        10)
            pipx install pipenv
            ;;
        11)
            install_with_brew fish
            sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
            echo 'eval (/opt/homebrew/bin/brew shellenv)' >> ~/.config/fish/config.fish

            # install ENV fuction in fish
            cp $(pwd)/*.fish ~/.config/fish/functions
            fish -c fish_add_path /opt/homebrew/bin
            ;;
        12)
            brew tap leoafarias/fvm
            install_with_brew fvm
            fvm install stable
            fvm global stable
            fish -c fish_add_path -a ~/fvm/default/bin/
            ;;
        13)
            install_with_brew obsidian cask
            ;;
        *)
            echo "Invalid option: $choice"
            ;;
    esac
done

echo "Installation complete."