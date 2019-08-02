function unload
    set -l file .env
    if not test -e $file
        return
    end
    while read -la line
        if not string match -q "#*" $line
          set -l env_str (string split = $line)
          if test -n "$env_str[1]"
              set -eg $env_str[1]
          end
        end    
    end < $file
end

