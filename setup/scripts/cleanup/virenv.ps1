param (
  [string]$ProfilePath
)

if (-Not (Test-Path $ProfilePath)) {
  Write-Output "PowerShell profile not found at $ProfilePath"
  exit 1
}

# Read the profile content
$profileContent = Get-Content -Path $ProfilePath -Raw

# Remove the virenv function definition
$updatedProfileContent = $profileContent -replace "(?s)function virenv \{.*?\n\}", ""

# Remove extra empty spaces at the end
$updatedProfileContent = $updatedProfileContent -replace "\s+$", ""

# Write the updated content back to the profile
Set-Content -Path $ProfilePath -Value $updatedProfileContent

Write-Output "virenv function removed from the PowerShell profile."
Write-Output "Please restart PowerShell or run '. `$PROFILE' to apply the changes."