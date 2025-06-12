function Test-InUvProject {
    # Check for pyproject.toml in current or parent directories
    $currentDir = Get-Location

    while ($currentDir.Path -ne $currentDir.Drive) {
        if (Test-Path (Join-Path $currentDir.Path "pyproject.toml")) {
            return $true
        }
        # Also check for a .venv directory directly
        if (Test-Path (Join-Path $currentDir.Path ".venv")) {
            return $true
        }
        $currentDir = Get-Item (Join-Path $currentDir.Path "..")
    }
    return $false
}

function pt() {
  $config = "$PSScriptRoot\ptpython_config.py"
  $ptpython = "ptpython --vi --config-file $config"

  $cmd = "uvx $ptpython"

  if (Test-InUvProject) {
    $cmd = "uv run $ptpython"
  }

  Invoke-Expression $cmd
}
