# cli-tools

This repository contains a script `virenv.bat` that can be added to your environment paths for Windows, allowing you to manage Python virtual environments directly from the command line.

## Setup

1. Clone this repository to your local machine.
2. Add the `scripts` directory to your system's PATH environment variable.

## Usage

The `virenv.bat` script provides several commands to manage Python virtual environments:

- `virenv create <name>`: Create a virtual environment with the specified name.
- `virenv activate [name]`: Activate a virtual environment, optionally by name. If no name is provided, it will search for a virtual environment in the current directory.
- `virenv check`: Check if a virtual environment is activated and return its name.
- `virenv deactivate`: Deactivate the current virtual environment.
- `virenv install`: Install requirements from `requirements.txt` in the current directory.
- `virenv update`: Update packages from `requirements.txt` in the current directory.
- `virenv --help`: Display help information about the script.
- `virenv --version`: Display the script version.

## Examples

### Create a Virtual Environment

```sh
virenv create myenv
```
