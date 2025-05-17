# Git aliases
function st {
  git status
}

function amend {
  git commit --amend
}

function revision {
  git describe --tags --always --dirty
}

function autocommit(
  [switch]$All = $false, [switch]$Dry = $false, [string]$Context = ""
) {
  $FullContext = "Use current branch name as a prefix if it is not main." + $Context

  if ($All) {
    git add -u
  }

  $draft = Invoke-Expression "lumen draft --context '$FullContext'"

  if (-not $draft) {
    Write-Host "No draft found"
    return
  }

  if ($Dry) {
    Write-Host "Would commit '$draft'"
  } else {
    git commit -m $draft
  }
}

# Loading up the posh-git
Import-Module posh-git

# Git
$env:GIT_SSH=(Get-Command ssh).Source
$env:GIT_EXTERNAL_DIFF = "difft"