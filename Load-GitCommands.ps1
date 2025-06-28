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
  [switch]$All = $false,
  [switch]$Dry = $false,
  [string]$Context = "",
  [switch]$Push = $false
) {
  if ($All) {
    git add -u
  }

  $branch = $(git branch --show-current)
  $branchContext = "This commit is on branch $branch."
  $policy = "Prefix the commit message with a commit type."
  $fullContext = @($policy, $branchContext, $Context) -join " "
  $draft = Invoke-Expression "lumen draft --context '$fullContext'"

  if (-not $draft) {
    Write-Host "No draft found"
    return
  }

  $commitCmd = "git commit -m '$draft'"

  if ($Dry) {
    Write-Host "Would run: $commitCmd"
  } else {
    Invoke-Expression $commitCmd
  }

  if ($Push) {
    $pushCmd = "git push"

    if ($Dry) {
      Write-Host "Would run: $pushCmd"
    } else {
      Invoke-Expression $pushCmd
    }
  }
}

# Loading up the posh-git
Import-Module posh-git

# Git
$env:GIT_SSH = (Get-Command ssh).Source
$env:GIT_EXTERNAL_DIFF = "difft"
Set-Alias -Name bash -Value "C:\Program Files\Git\bin\bash.exe"
