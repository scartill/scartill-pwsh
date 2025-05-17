try {
    # Enabling Oh-My-Posh
    oh-my-posh --init --shell pwsh --config https://gist.githubusercontent.com/scartill/5b703c57d71aaff4364552344f64959a/raw/pwsh-7-posh-conf.json | Invoke-Expression
} catch {
    Write-Host "Error loading Oh-My-Posh"
}
