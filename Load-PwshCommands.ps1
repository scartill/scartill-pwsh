$config_url = "https://raw.githubusercontent.com/scartill/scartill-pwsh/refs/heads/main/on-my-posh-config.yaml"

try {
    $posh_cmd = "oh-my-posh --init --shell pwsh --config $config_url"
    Invoke-Expression $posh_cmd | Invoke-Expression
} catch {
    Write-Error "Error loading Oh-My-Posh"
}
