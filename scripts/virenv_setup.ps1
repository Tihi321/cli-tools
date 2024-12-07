param (
  [string]$ProfilePath
)

if (-Not (Test-Path $ProfilePath)) {
  Write-Output "Creating PowerShell profile at $ProfilePath"
  New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
}

$functionDefinition = @'
function virenv {
    param (
        [string]$Command,
        [string]$Name
    )

    if ($Command -eq "activate") {
        if ($Name) {
            $activatePath = Join-Path -Path (Get-Location) -ChildPath "$Name\Scripts\Activate.ps1"
            if (Test-Path $activatePath) {
                . $activatePath
                Write-Output "Virtual environment '$Name' activated."
            }
            else {
                Write-Output "Activate script not found for environment '$Name'."
            }
        }
        else {
            $activateScript = Get-ChildItem -Directory | Where-Object { Test-Path "$($_.FullName)\Scripts\Activate.ps1" } | Select-Object -First 1
            if ($activateScript) {
                . "$($activateScript.FullName)\Scripts\Activate.ps1"
                Write-Output "Virtual environment '$($activateScript.Name)' activated."
            }
            else {
                Write-Output "No virtual environment found in the current directory."
            }
        }
    }
    else {
        & .\virenv.bat $Command $Name
    }
}
'@

# Check if the virenv function already exists in the profile
if (Get-Content -Path $ProfilePath | Select-String -Pattern "function virenv") {
  Write-Output "virenv function is already present in the PowerShell profile."
}
else {
  Add-Content -Path $ProfilePath -Value "`n"  # Add a new line for separation
  Add-Content -Path $ProfilePath -Value $functionDefinition
  Write-Output "virenv function added to the PowerShell profile."
  Write-Output "Please restart PowerShell or run '. `$PROFILE' to apply the changes."
}