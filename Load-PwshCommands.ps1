$base_url = "https://gist.githubusercontent.com/scartill/"
$config_url = "$base_url/5b703c57d71aaff4364552344f64959a/raw/pwsh-7-posh-conf.json"

try {
    $posh_cmd = "oh-my-posh --init --shell pwsh --config $config_url"
    Invoke-Expression $posh_cmd | Invoke-Expression
} catch {
    Write-Error "Error loading Oh-My-Posh"
}
