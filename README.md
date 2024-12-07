# CLI Tools

This repository contains a scripts that can be added to your environment paths for Windows.

## Scripts

- `setup.bat` - Add the `scripts` directory to your system' PATH environment variable and add configuration needed for scripts.
- `cleanup.bat` - Remove the `scripts` directory from your system' PATH environment variable and cleans up configuration form scripts.

## Setup

1. Clone this repository to your local machine.
2. Run the script `setup.bat` in terminal.
3. Open a new terminal window or restart your current one.

## Remove

2. Run the script `cleanup.bat`.

## Manualy adding paths:

- On Windows, open the "System Properties" window and click on the "Advanced system settings..." button.
- Click on the "Environment Variables..." button.
- Click on the "Path" variable and click on the "Edit..." button.
- Click on "New" and add the path of the `scripts` directory.
- Click OK until you return back to the main window.

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

#### Deactivate a Virtual Environment

To deactivate a virtual environment, simply run:

```sh
deactivate
```

## License

[MIT](https://opensource.org/license/mit)

## Contact

- [Tihomir Selak](https://github.com/Tihi321)
