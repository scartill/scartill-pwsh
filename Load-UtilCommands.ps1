function chime([string]$What, [int]$Pause = 0) {
  Write-Host "Waiting $Pause seconds"
  Start-Sleep $Pause
  (New-Object -ComObject Sapi.spvoice).speak($What)
}

function Move-Files-From-Clipboard() {
  Add-Type -AssemblyName System.Windows.Forms
  $hasFile = [System.Windows.Forms.Clipboard]::ContainsFileDropList()	

  if (-not $hasFile) {
    Write-Output "No valid file copied in File Explorer."
    return
  }

  $files = [System.Windows.Forms.Clipboard]::GetFileDropList()

  foreach ($file in $files) {
    Write-Output "File: $file"
    Move-Item $file -Destination $(Get-Location)
  }
}

function vcat([string]$Video) {
  ffmpeg -i $Video -vframes 1 -vf "scale=640:400" -f image2pipe -c:v png - 2>$null | wezterm imgcat
}
