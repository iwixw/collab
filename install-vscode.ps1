# Установка расширения Collab для VS Code (Windows).
# Запуск: irm tinyurl.com/iwixw-vscode | iex
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$url  = 'https://github.com/iwixw/collab/releases/latest/download/collab-vscode.vsix'
$file = Join-Path $env:TEMP 'collab-vscode.vsix'

Write-Host 'Скачиваю Collab для VS Code...' -ForegroundColor Cyan
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $url -OutFile $file -UseBasicParsing

# Если команду запустили из терминала внутри VS Code, code.cmd иначе может не сработать.
Remove-Item Env:ELECTRON_RUN_AS_NODE -ErrorAction SilentlyContinue

$code = (Get-Command code -ErrorAction SilentlyContinue).Source
if (-not $code) {
    foreach ($p in @("$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd", "$env:ProgramFiles\Microsoft VS Code\bin\code.cmd")) {
        if (Test-Path $p) { $code = $p; break }
    }
}
if (-not $code) {
    Write-Host 'Не нашёл VS Code. Установи его с https://code.visualstudio.com/ и запусти команду ещё раз.' -ForegroundColor Yellow
    return
}

& $code --install-extension $file --force
Write-Host ''
Write-Host 'Готово! Перезагрузи окно VS Code: Ctrl+Shift+P -> Developer: Reload Window.' -ForegroundColor Green
Write-Host 'Слева появится значок Collab </>, а внизу — кнопка Collab.' -ForegroundColor Green
