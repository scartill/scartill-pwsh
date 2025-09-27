$config_file = Get-Item "${PSScriptRoot}\on-my-posh-config.json" 

Write-Host "Loading Oh-My-Posh from $config_file"

try {
    oh-my-posh --init --shell pwsh --config $config_file | Invoke-Expression
    Write-Host "Oh-My-Posh loaded successfully"
} catch {
    Write-Error "Error loading Oh-My-Posh"
}

Set-PSReadLineOption -Colors @{ "Parameter"="Green" }
Set-PSReadLineOption -Colors @{ "Operator"="Blue" }
