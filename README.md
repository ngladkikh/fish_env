# fish_env

Load/unload ENV varibles from .env file for fish shell.

## INSTALATION
Create function if not exist

```fish
mkdir -p ~/.config/fish/functions
```

Copy *.fish files from this repo to ~/.config/fish/functions:

```fish
cp (pwd)/*.fish ~/.config/fish/functions
```

## USE

* `load` Loads all ENV variables from .env file in current directory if exists.

* `unload` Removes all ENV variables taken from .env file in current directory if exists.

* `cde` Same as `cd` but runs first unload then cd and load after all. Use this alias for auto load/unload ENV variables.
