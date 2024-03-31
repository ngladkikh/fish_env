# Mac Setup Script with Fish Shell

This project automates the setup of a development environment on macOS, including the installation of Homebrew, the Fish shell, and several utility functions for managing environment variables.

## Features

- **Homebrew Installation**: Automates the installation of Homebrew, the package manager for macOS.
- **Fish Shell Setup**: Installs the Fish shell and sets it as the default shell.
- **Environment Variable Management**: Provides Fish shell functions to load, unload, and contextually manage environment variables from a `.env` file.

## Getting Started

### Prerequisites

- A macOS system
- Administrator access for installing packages

### Installation

1. Clone this repository.
2. Open a terminal and navigate to the directory containing `install.sh`.
3. Make the script executable:
   ```sh
   chmod +x install.sh
   ```
4. Run the script:
   ```sh
   ./install.sh
   ```

## Usage

After installation, the following Fish shell functions will be available for managing environment variables:

- **setup_mac**: Automates multiple dev tools installation with brew
- **load**: Reads variables from a `.env` file in the current directory and exports them to the shell environment.
- **unload**: Removes the exported variables that were loaded from the `.env` file.
- **cde**: A combination command that unloads environment variables, changes the directory, and then loads new variables from a `.env` file in the target directory.

### Example `.env` File

Create a `.env` file in your project directory with the following format:

```
VAR_NAME=value
ANOTHER_VAR=some_other_value
```

### Loading Environment Variables

To load variables from a `.env` file in the current directory:

```fish
load
```

### Unloading Environment Variables

To remove variables that were previously loaded:

```fish
unload
```

### Changing Directory and Environment Context

To change to a new directory and refresh the environment variables:

```fish
cde /path/to/new/directory
```

## License

This project is open source and available under the [MIT License](LICENSE).