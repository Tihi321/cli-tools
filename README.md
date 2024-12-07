# cli-tools

This repository contains a script `virenv.bat` that can be added to your environment paths for Windows, allowing you to manage Python virtual environments directly from the command line.

## Setup

1. Clone this repository to your local machine.
2. Add the `scripts` directory to your system's PATH environment variable.

# VIRENV

## Commands

- `create name` - Create a virtual environment with the specified name
- `activate [name]` - Activate a virtual environment, optionally by name
- `check` - Check if a virtual environment is activated and return its name
- `install` - Install requirements from `requirements.txt`
- `update` - Update packages from `requirements.txt`
- `list` - List installed packages in the activated virtual environment
- `freeze` - Check all packages in the activated virtual environment and populate `requirements.txt`
- `add [package-name]` - Add a package to `requirements.txt`
- `remove [package-name]` - Remove a package from `requirements.txt`
- `init` - Add `virenv` function to PowerShell profile
- `--help` - Display this help information
- `--version` - Display the script version

## Usage

### Initialize

To set up the `virenv` function in your PowerShell profile, run:

```sh
virenv init
```

### Create a virtual environment

To create a new virtual environment with the name `my-env`, run:

```sh
virenv create my-env
```

### Activate a Virtual Environment

To activate a virtual environment, run:

```sh
virenv activate
```

### Install Requirements

To install requirements from requirements.txt, run:

```sh
virenv install
```

### Deactivate a Virtual Environment

To deactivate a virtual environment, simply run:

```sh
deactivate
```
