# Collab

Совместное редактирование кода через свой сервер: Visual Studio (Windows) и VS Code (Mac / Windows / Linux) в одной сессии.

## Установка

**Windows, Visual Studio 2022 / 2026** — в Visual Studio открой терминал (**Вид → Терминал**) и вставь:

```powershell
irm https://raw.githubusercontent.com/iwixw/collab/main/install.ps1 | iex
```

Откроется установщик — нажми **Install** и закрой Visual Studio, когда он попросит.

**Mac (VS Code)** — открой программу **Терминал** и вставь:

```sh
curl -fsSL https://raw.githubusercontent.com/iwixw/collab/main/install.sh | sh
```

Потом перезапусти VS Code.

## Как пользоваться

**Visual Studio:** меню **Средства → Collab: начать сессию** / **Collab: присоединиться**.

**VS Code:** кнопка **Collab** внизу слева → «Присоединиться» / «Начать сессию».

Начинающий придумывает пароль, второй вводит тот же пароль — и вы правите один файл вместе.
