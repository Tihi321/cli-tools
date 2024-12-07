# CLI Tools

This repository contains a scripts that can be added to your environment paths for Windows.

## Setup

1. Clone this repository to your local machine.
2. Add the `scripts` directory to your system's PATH environment variable.
3. Run the script `add_to_path.bat` in terminal.
4. Open a new terminal window or restart your current one.
5. To remove scripts, run the script `remove_from_path.bat` or manually remove the `scripts` directory from your system' PATH environment variable.

## Scripts

- `add_to_path.bat` - Add the `scripts` directory to your system' PATH environment variable.
- `remove_from_path.bat` - Remove the `scripts` directory from your system' PATH environment variable.

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
- `add [package-name]` - Add a package to `requirements.txt`
- `remove [package-name]` - Remove a package from `requirements.txt`
- `init` - Add `virenv` function to PowerShell profile
- `--help` - Display this help information
- `--version` - Display the script version

### Usage

#### Initialize

To set up the `virenv` function in your PowerShell profile, run:

```sh
virenv init
```

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

- [<Tihomir Selak>](https://github.com/Tihi321)
