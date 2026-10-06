# Collab

Совместное редактирование кода через свой сервер: Visual Studio (Windows), Visual Studio для Mac и VS Code — в одной сессии.

## Установка

**Windows, Visual Studio 2022 / 2026** — в Visual Studio открой терминал (**Вид → Терминал**) и вставь:

```powershell
irm https://raw.githubusercontent.com/iwixw/collab/main/install.ps1 | iex
```

Откроется установщик — нажми **Install** и закрой Visual Studio, когда он попросит.

**Mac, Visual Studio 2022 для Mac** — открой программу **Терминал** и вставь:

```sh
curl -fsSL https://raw.githubusercontent.com/iwixw/collab/main/install-vsmac.sh | sh
```

Потом перезапусти Visual Studio. Если пункты Collab не появились — запусти диагностику и пришли вывод:

```sh
curl -fsSL https://raw.githubusercontent.com/iwixw/collab/main/install-vsmac.sh | sh -s diag
```

**Mac / Linux, VS Code** — в **Терминале**:

```sh
curl -fsSL https://raw.githubusercontent.com/iwixw/collab/main/install.sh | sh
```

## Как пользоваться

**Visual Studio (Windows и Mac):** меню **Средства → Collab: начать сессию** / **Collab: присоединиться**.

**VS Code:** кнопка **Collab** внизу слева → «Присоединиться» / «Начать сессию».

Начинающий придумывает пароль, второй вводит тот же пароль — и вы правите один файл вместе.
