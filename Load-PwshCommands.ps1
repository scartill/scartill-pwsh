# $config_file = "$PSScriptRoot/on-my-posh-config.yaml"
$config_file = "${PSScriptRoot}/on-my-posh-config.json"

Write-Host "Loading Oh-My-Posh from $config_file"

try {
    $posh_cmd = "oh-my-posh --init --shell pwsh --config $config_file"
    Invoke-Expression $posh_cmd | Invoke-Expression
} catch {
    Write-Error "Error loading Oh-My-Posh"
}
