function disable-pyenv
    # Remove shims from PATH
    set -l newpath
    for dir in $PATH
        if test $dir != "$HOME/.pyenv/shims"
            set newpath $newpath $dir
        end
    end
    set -gx PATH $newpath
    echo "🚫 pyenv disabled"
end
