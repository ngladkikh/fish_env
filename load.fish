function load 
    set -l file (string trim $argv[1]) # Trim whitespace from the first argument
    if test -z "$file" # Check if the file variable is empty
        set file .env # Default to ".env" if no argument is provided
    end

    if not test -e $file
        return
    end
    while read -la line
        if not string match -q "#*" $line
          set -l env_str (string split = $line)
          if test -n "$env_str[1]"
              set -xg (string trim $env_str[1]) (string trim $env_str[2])
          end
        end
    end < $file
end
