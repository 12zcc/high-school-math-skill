# Install the high-school-math skill for common AI coding tools.
# Usage: powershell -ExecutionPolicy Bypass -File install.ps1 [-Project]

param(
    [switch]$Project
)

$ErrorActionPreference = "Stop"
$Name = "high-school-math"
$Root = Split-Path -Parent $PSScriptRoot
$SkillDir = Join-Path $Root "high-school-math"
$CursorRule = Join-Path $Root ".cursor\rules\$Name.mdc"
$WindsurfRule = Join-Path $Root ".windsurf\rules\$Name.md"
$CopilotMd = Join-Path $Root ".github\copilot-instructions.md"
$HomeDir = if ($env:USERPROFILE) { $env:USERPROFILE } else { $HOME }

function Install-Skill($label, $dst) {
    New-Item -ItemType Directory -Path (Split-Path -Parent $dst) -Force | Out-Null
    if (Test-Path -LiteralPath $dst) { Remove-Item -LiteralPath $dst -Recurse -Force }
    Copy-Item -LiteralPath $SkillDir -Destination $dst -Recurse -Force
    Write-Host "  [ok] $label : $dst"
}

function Install-Rule($label, $src, $dst) {
    New-Item -ItemType Directory -Path (Split-Path -Parent $dst) -Force | Out-Null
    Copy-Item -LiteralPath $src -Destination $dst -Force
    Write-Host "  [ok] $label : $dst"
}

Write-Host "high-school-math skill installer"
Write-Host ("=" * 50)

Install-Skill "claude code"   (Join-Path $HomeDir ".claude\skills\$Name")
Install-Skill "opencode"      (Join-Path $HomeDir ".config\opencode\skills\$Name")
Install-Skill "agents/skills" (Join-Path $HomeDir ".agents\skills\$Name")
Install-Rule  "cursor (rule)" $CursorRule (Join-Path $HomeDir ".cursor\rules\$Name.mdc")
Install-Rule  "windsurf (rule)" $WindsurfRule (Join-Path $HomeDir ".windsurf\rules\$Name.md")

if ($Project) {
    $Cwd = (Get-Location).Path
    Install-Skill "opencode (project)" (Join-Path $Cwd ".opencode\skills\$Name")
    Install-Skill "claude (project)"   (Join-Path $Cwd ".claude\skills\$Name")
    Install-Rule  "copilot (project)"  $CopilotMd (Join-Path $Cwd ".github\copilot-instructions.md")
}

Write-Host ("=" * 50)
Write-Host "Done. Restart your AI tool(s) to (re)load the skill."
