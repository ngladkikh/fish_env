# fish_env

Load/unload ENV varibles from .env file for fish shell.

## INSTALATION

Copy *.fish files from this repo to ~/.config/fish/functions:

```fish
cp (pwd)/*.fish ~/.config/fish/functions
```

## load

Loads all ENV variables from .env file in current directory if exists.

## unload

Removes all ENV variables taken from .env file in current directory if exists.

## cde

The same as `cd` but runs first unload then cd and load after all.
Use this alias for auto load/unload ENV variables.
