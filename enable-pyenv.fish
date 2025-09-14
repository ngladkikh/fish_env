function enable-pyenv
    # Add pyenv to PATH
    set -gx PATH $HOME/.pyenv/bin $PATH
    # Initialize pyenv
    pyenv init - | source
    pyenv init --path | source
    echo "✅ pyenv enabled"
end
