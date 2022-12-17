# Prototypes

Game prototypes made with LÖVE.

## Description

[LÖVE](https://love2d.org/) is an awesome framework you can use to make 2D games in Lua. It's free, open-source, and works on Windows, macOS, Linux, Android, and iOS.

[Lua](https://www.lua.org/) is a powerful, efficient, lightweight, embeddable scripting language. It supports procedural programming, object-oriented programming, functional programming, data-driven programming, and data description.

## Usage

How to run a game file in LÖVE: `<love-executable-path> <game-folder-path>`

For example, to run the `jumper` game in the filetree:

```text
prototypes
├─ jumper       ✔️
│  └─ main.lua  ❌
├─ runner
│  └─ main.lua
└─ LOVE
   └─ love.exe
```

✔️ Correct: `./LOVE/love.exe ./jumper/`

❌ Incorrect: `./LOVE/love.exe ./jumper/main.lua`

Also, you can drag and drop the `jumper` game folder on to the `love.exe` file in your file explorer.

Note that the default path to LÖVE on Windows is usually `C:/Program Files/LOVE/love.exe`.

Recommended Lua formatter for VSCode: [vscode-lua](https://marketplace.visualstudio.com/items?itemName=trixnz.vscode-lua)

Recommended LÖVE launcher for VSCode: [love-launcher](https://marketplace.visualstudio.com/items?itemName=JanW.love-launcher)
