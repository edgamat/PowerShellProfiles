# PowerShell Profiles

## Setup

Add the following to your default profile:

```powershell
code $PROFILE
```

```powershell
# Use the correct path to the cloned repo
$ProfileRepoPath = "C:\Users\$env:USERNAME\source\PowerShellProfiles"

# Select a profile to load
$SelectedProfile = "GeneralProfile.ps1"  # Change as needed

# Load the selected profile
if (Test-Path "$ProfileRepoPath\$SelectedProfile") {
    . "$ProfileRepoPath\$SelectedProfile"
    Write-Host "Loaded profile: $SelectedProfile"
} else {
    Write-Host "Profile not found: $SelectedProfile"
}
```

## posh-git

[https://github.com/dahlbyk/posh-git](https://github.com/dahlbyk/posh-git)

Full instructions:

[https://github.com/dahlbyk/posh-git?tab=readme-ov-file#installation](https://github.com/dahlbyk/posh-git?tab=readme-ov-file#installation)

To install:

1. Make sure you have the execution policy updated:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm
```

2. Make sure you have Git for Windows installed

3. Install the posh-git module:

```powershell
# (A) You've never installed posh-git from the PowerShell Gallery
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

# (B) You've already installed a previous version of posh-git from the PowerShell Gallery
PowerShellGet\Update-Module posh-git
```

## PSReadLine

PSReadLine is installed by default in PowerhShell 7.x and higher

```powershell
if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}
```

