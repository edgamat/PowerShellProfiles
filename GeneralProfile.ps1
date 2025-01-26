if ($host.Name -eq 'ConsoleHost')
{
    Import-Module posh-git
    Import-Module PSReadLine
}

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Register-ArgumentCompleter -Native -CommandName az -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $completion_file = New-TemporaryFile
    $env:ARGCOMPLETE_USE_TEMPFILES = 1
    $env:_ARGCOMPLETE_STDOUT_FILENAME = $completion_file
    $env:COMP_LINE = $wordToComplete
    $env:COMP_POINT = $cursorPosition
    $env:_ARGCOMPLETE = 1
    $env:_ARGCOMPLETE_SUPPRESS_SPACE = 0
    $env:_ARGCOMPLETE_IFS = "`n"
    $env:_ARGCOMPLETE_SHELL = 'powershell'
    az 2>&1 | Out-Null
    Get-Content $completion_file | Sort-Object | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_)
    }
    Remove-Item $completion_file, Env:\_ARGCOMPLETE_STDOUT_FILENAME, Env:\ARGCOMPLETE_USE_TEMPFILES, Env:\COMP_LINE, Env:\COMP_POINT, Env:\_ARGCOMPLETE, Env:\_ARGCOMPLETE_SUPPRESS_SPACE, Env:\_ARGCOMPLETE_IFS, Env:\_ARGCOMPLETE_SHELL
}

function ListDirectories { ls -Directory }
function Print-Environment { gci env:* | Sort-Object -Property Name }
function Git-Checkout { git checkout @args }
function Git-PushForce { git push --force-with-lease }
function Git-CommitAmend { git commit --amend }
function Git-RebaseContinue { git rebase --continue }
function Git-RebaseMain { git rebase main }
function Git-Bump {
    git add .
    git commit -m "bump version"
}
function Get-History {
    $find = $args;
    Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -like "*$find*"} | Get-Unique | more
}

Set-Alias -Name "printenv" -Value Print-Environment
Set-Alias -Name "gco" -Value Git-Checkout
Set-Alias -Name "gpf" -Value Git-PushForce
Set-Alias -Name "gca" -Value Git-CommitAmend
Set-Alias -Name "grc" -Value Git-RebaseContinue
Set-Alias -Name "grm" -Value Git-RebaseMain
Set-Alias -Name "gbump" -Value Git-Bump
Set-Alias -Name "hist" -Value Get-History
Set-ALias -Name "lsd" -Value ListDirectories
