# CLI Tools

This repository contains a scripts that can be added to your environment paths for Windows.

## Scripts

- `setup.bat` - Add the `scripts` directory to your system' PATH environment variable and add configuration needed for scripts.
- `cleanup.bat` - Remove the `scripts` directory from your system' PATH environment variable and cleans up configuration form scripts.

## Disclaimer:

IMPORTANT: This script is not tested on Windows 10 or older. It should work but use it at your own risk!
Script for adding path is tested on Windows 11. Please backup your system' PATH variable before running this script. Check manual way of adding for safety.

## Manualy adding paths:

- On Windows, open the "System Properties" window and click on the "Advanced system settings..." button.
- Click on the "Environment Variables..." button.
- Click on the "Path" variable and click on the "Edit..." button.
- Click on "New" and add the path of the `scripts` directory.
- Click OK until you return back to the main window.

## Setup

1. Clone this repository to your local machine.
2. Run the script `setup.bat` in terminal.
3. Open a new terminal window or restart your current one.

## Remove

2. Run the script `cleanup.bat`.

# Tools

## VIRENV

#### Commands

- `create name` - Create a virtual environment with the specified name
- `activate [name]` - Activate a virtual environment, optionally by name
- `check` - Check if a virtual environment is activated and return its name
- `install` - Install requirements from `requirements.txt`
- `update` - Update packages from `requirements.txt`
- `list` - List installed packages in the activated virtual environment
- `freeze` - Check all packages in the activated virtual environment and populate `requirements.txt`
- `add [package-name]` - Installs and adds to `requirements.txt`
- `remove [package-name]` - Uninstall and removes a package from `requirements.txt`
- `deactivate` - Deactivate the current virtual environment
- `updatepy [path]` - Update Python path in a virtual environment (auto-detects if no path given)
- `--help` - Display this help information
- `--version` - Display the script version

### Usage

#### Create a virtual environment

To create a new virtual environment with the name `my-env`, run:

```sh
virenv create my-env
```

#### Activate a Virtual Environment

To activate a virtual environment, run:

```sh
virenv activate
```

#### Install Requirements

To install requirements from requirements.txt, run:

```sh
virenv install
```

#### Update Python path in virtual environment

When your system Python path changes (e.g. after a Python upgrade), update the virtual environment to point to the new path. If no path is provided, it will search the current directory for a virtual environment, the same way `activate` does:

```sh
virenv updatepy
```

To target a specific virtual environment:

```sh
virenv updatepy myenv
```

#### Deactivate a Virtual Environment

To deactivate a virtual environment, run:

```sh
virenv deactivate
```

## VITASKS

A CLI tool for managing processes running on specific ports.

#### Commands

- `listall` - List all processes with open ports (shows name, path, and port)
- `list [port]` - List all processes running on the specified port (shows name, path, and PID)
- `find [name]` - Find all processes matching the specified name (shows name, path, port, and PID)
- `stop [port]` - Stop all processes running on the specified port
- `--help` - Display this help information
- `--version` - Display the script version

### Usage

#### List all processes with ports

To list all processes that have open ports:

```sh
vitasks listall
```

#### List processes on a port

To list all processes running on port 3000 (with name and path):

```sh
vitasks list 3000
```

#### Find processes by name

To find all processes with "node" in the name:

```sh
vitasks find node
```

#### Stop processes on a port

To kill all processes running on port 8080:

```sh
vitasks stop 8080
```

## License

[MIT](https://opensource.org/license/mit)

## Contact

- [Tihomir Selak](https://github.com/Tihi321)
