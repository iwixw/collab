#!/bin/sh
# Установка расширения Collab для Visual Studio 2022 для Mac.
#   Установка:    curl -fsSL https://raw.githubusercontent.com/iwixw/collab/main/install-vsmac.sh | sh
#   Диагностика:  curl -fsSL https://raw.githubusercontent.com/iwixw/collab/main/install-vsmac.sh | sh -s diag
set -e

APP="/Applications/Visual Studio.app"
URL="https://github.com/iwixw/collab/releases/latest/download/collab-vsmac.zip"
SUPPORT="$HOME/Library/Application Support/VisualStudio"
CACHES="$HOME/Library/Caches/VisualStudio"
LOGS="$HOME/Library/Logs/VisualStudio"

[ -d "$APP" ] || APP="$HOME/Applications/Visual Studio.app"
if [ ! -d "$APP" ]; then
    echo "Не нашёл Visual Studio для Mac в /Applications."
    exit 1
fi

VS_VERSION=$(defaults read "$APP/Contents/Info" CFBundleShortVersionString 2>/dev/null || echo "?")
PROFILE=$(ls -d "$SUPPORT"/17.* 2>/dev/null | sort | tail -1)
[ -n "$PROFILE" ] || PROFILE="$SUPPORT/17.0"
TARGET="$PROFILE/LocalInstall/Addins/Collab"

# Версия аддинов IDE: из кэша Mono.Addins (файлы вида MonoDevelop.Ide,17.6.maddin), иначе из версии приложения.
addin_version() {
    v=$(find "$CACHES" -name "$1,*.maddin" 2>/dev/null | sed -e "s/.*$1,//" -e 's/\.maddin$//' | sort | tail -1)
    [ -n "$v" ] || v=$(echo "$VS_VERSION" | cut -d. -f1-2)
    echo "$v"
}

if [ "$1" = "diag" ]; then
    echo "== Visual Studio: $VS_VERSION"
    echo "== Профиль: $PROFILE"
    echo "== Версии аддинов: Core=$(addin_version MonoDevelop.Core) Ide=$(addin_version MonoDevelop.Ide)"
    echo "== Установлено:"; ls -la "$TARGET" 2>/dev/null || echo "(нет)"
    LOG=$(ls -t "$LOGS"/*/Ide.*.log "$LOGS"/Ide.*.log 2>/dev/null | head -1)
    echo "== Лог: $LOG"
    [ -n "$LOG" ] && grep -n -i -B2 -A8 "collab" "$LOG" | tail -80
    exit 0
fi

CORE_VERSION=$(addin_version MonoDevelop.Core)
IDE_VERSION=$(addin_version MonoDevelop.Ide)

echo "Visual Studio для Mac $VS_VERSION (аддины Core $CORE_VERSION, Ide $IDE_VERSION)"
echo "Скачиваю Collab..."
TMP=$(mktemp -d)
curl -fsSL "$URL" -o "$TMP/collab.zip"
unzip -q -o "$TMP/collab.zip" -d "$TMP/collab"

mkdir -p "$TARGET"
cp "$TMP/collab/Collab.VSMac.dll" "$TARGET/"
sed -e "s/@CORE_VERSION@/$CORE_VERSION/" -e "s/@IDE_VERSION@/$IDE_VERSION/" \
    "$TMP/collab/Collab.addin.xml" > "$TARGET/Collab.addin.xml"
rm -rf "$TMP"

echo ""
echo "Готово! Установлено в: $TARGET"
echo "Перезапусти Visual Studio — в меню «Средства» (Tools) появятся пункты Collab."
echo ""
echo "Если пунктов нет — запусти диагностику и пришли вывод:"
echo "  curl -fsSL https://raw.githubusercontent.com/iwixw/collab/main/install-vsmac.sh | sh -s diag"
