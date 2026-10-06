# Установка расширения Collab для Visual Studio.
# Запуск: irm https://raw.githubusercontent.com/iwixw/collab/main/install.ps1 | iex
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$url  = 'https://github.com/iwixw/collab/releases/latest/download/CollabEdit.vsix'
$file = Join-Path $env:TEMP 'CollabEdit.vsix'

Write-Host 'Скачиваю Collab...' -ForegroundColor Cyan
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $url -OutFile $file -UseBasicParsing

# Ищем установщик расширений Visual Studio; если не нашли — открываем файл как обычно.
$installer = $null
$vswhere = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio\Installer\vswhere.exe'
if (Test-Path $vswhere) {
    $vs = & $vswhere -latest -prerelease -products * -property installationPath
    if ($vs) {
        $candidate = Join-Path $vs 'Common7\IDE\VSIXInstaller.exe'
        if (Test-Path $candidate) { $installer = $candidate }
    }
}

Write-Host ''
Write-Host 'Открываю установщик. Нажми Install, а когда он попросит - закрой Visual Studio' -ForegroundColor Green
Write-Host '(или нажми в установщике "End Tasks").' -ForegroundColor Green
if ($installer) { Start-Process $installer -ArgumentList "`"$file`"" } else { Start-Process $file }
