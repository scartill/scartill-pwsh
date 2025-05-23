# Git aliases
function st {
  git status
}

function amend {
  git commit --amend
}

function revision {
  $revision = $(git describe --always --dirty).Split("-").Get(0)
  Write-Output $revision
  Set-Clipboard $revision
}

function autocommit(
  [switch]$All = $false, [switch]$Dry = $false, [string]$Context = ""
) {
  if ($All) {
    git add -u
  }

  $branch = $(git branch --show-current)
  $branchContext = "This commit is on branch $branch."
  $policy = "Prefix the commit message with a commit type."
  $fullContext = @($policy, $branchContext, $Context) -join " "
  Write-Host "Context: $fullContext"
  $draft = Invoke-Expression "lumen draft --context '$fullContext'"

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