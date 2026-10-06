#!/bin/sh
# Установка расширения Collab для VS Code (macOS / Linux).
# Запуск: curl -fsSL https://raw.githubusercontent.com/iwixw/collab/main/install.sh | sh
set -e

URL="https://github.com/iwixw/collab/releases/latest/download/collab-vscode.vsix"
FILE="${TMPDIR:-/tmp}/collab-vscode.vsix"

echo "Скачиваю Collab..."
curl -fsSL "$URL" -o "$FILE"

CODE=""
if command -v code >/dev/null 2>&1; then
    CODE="code"
else
    for app in "/Applications/Visual Studio Code.app" "$HOME/Applications/Visual Studio Code.app"; do
        if [ -x "$app/Contents/Resources/app/bin/code" ]; then
            CODE="$app/Contents/Resources/app/bin/code"
            break
        fi
    done
fi

if [ -z "$CODE" ]; then
    echo ""
    echo "Не нашёл VS Code. Скачай его с https://code.visualstudio.com/ и запусти эту команду ещё раз."
    exit 1
fi

"$CODE" --install-extension "$FILE" --force
echo ""
echo "Готово! Перезапусти VS Code - внизу слева появится кнопка Collab."
