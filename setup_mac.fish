function setup_mac
    function install_with_brew
        set name $argv[1]
        set type $argv[2]  # Can be empty or "cask"

        # Determine if it's a regular package or a cask
        if test "$type" = "cask"
            # Check and install cask applications
            if brew list --cask $name > /dev/null 2>&1
                echo "$name is already installed."
            else
                if brew install --cask $name
                    echo "$name successfully installed."
                else
                    echo "Failed to install $name. Please check for errors."
                    exit 1
                end
            end
        else
            # Check and install regular packages
            if brew list $name > /dev/null 2>&1
                echo "$name is already installed."
            else
                if brew install $name
                    echo "$name successfully installed."
                else
                    echo "Failed to install $name. Please check for errors."
                    exit 1
                end
            end
        end
    end

    echo "Select the tools you want to install (separate choices with spaces):"
    echo "0. Install all"
    echo "1. Git"
    echo "2. Visual Studio Code"
    echo "3. Docker"
    echo "4. PyCharm"
    echo "5. GitKraken (Git UI)"
    echo "6. bitwarden (Password manager)"
    echo "7. flycut (Clipboard manager)"
    echo "8. PipX"
    echo "9. Poetry (with PipX)"
    echo "10. PipEnv (with PipX)"
    echo "11. Flutter SDK"
    echo "12. Obsidian (Local notes storage)"
    echo "13. Calibre (Book management tool)"
    echo "14. PyEnv (Python management tool)"
    echo "15. k8slens (K8S Cluster management UI)"

    echo "Enter your choices: "
    read -l choices

    # Convert input string to a list
    set -l choice_list (string split " " $choices)

    if contains "0" $choice_list
        set choice_list 1 2 3 4 5 6 7 8 9 10 11 12 13
    end

    for choice in $choice_list
        switch $choice
            case 1
                install_with_brew git
            case 2
                install_with_brew visual-studio-code cask
            case 3
                echo "Install docker"
                install_with_brew docker
                echo "Installing Colima..."
                install_with_brew colima
                colima start
                echo "Install docker-compose"
                install_with_brew docker-compose
                echo "Setup docker-compose plugin to be recognizable"
                mkdir -p ~/.docker/cli-plugins
                ln -sfn (brew --prefix)/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
            case 4
                install_with_brew pycharm cask
            case 5
                install_with_brew gitkraken cask
            case 6
                install_with_brew bitwarden cask  
            case 7
                install_with_brew flycut cask
            case 8
                install_with_brew pipx
            case 9
                pipx install poetry
            case 10
                pipx install pipenv
            case 11
                echo "Add leoafarias/fvm package repository..."
                brew tap leoafarias/fvm
                echo "Installing Flutter package manager fvm..."
                install_with_brew fvm
                echo "Installing FlutterSDK..."
                fvm install stable
                fvm global stable
                echo "Configure FlutterSDK PATH"
                fish -c fish_add_path -a ~/fvm/default/bin/
                echo "Flutter installation complete."
            case 12
                install_with_brew obsidian cask
            case 13
                install_with_brew calibre cask
            case 14
                install_with_brew pyenv
                set -Ux PYENV_ROOT $HOME/.pyenv
                fish_add_path $PYENV_ROOT/bin
            case 15
                install_with_brew lens cask
            case '*'
                echo "Invalid option: $choice"
        end
    end

    echo "Installation complete."
end
