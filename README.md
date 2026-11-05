<p align="center">
  <img src="assets/logo.png" width="84" alt="Oblivion">
</p>

<h1 align="center">Oblivion Hub UI Library</h1>

<p align="center">
  A clean, modern UI library for Roblox scripts.<br>
  One line to load, a few lines to build a full menu.
</p>

<p align="center">
  <a href="https://ossdiablo.github.io/OblivionHub-UI/"><b>Website and full guide</b></a>
</p>

---

## 1. Load the library

Put this at the top of your script.

```lua
local Oblivion = loadstring(game:HttpGet("https://raw.githubusercontent.com/OSSDiablo/OblivionHub-UI/main/Source.luau"))()
```

## 2. Make a window

```lua
local Window = Oblivion:CreateWindow({
    Name = "My Hub",
    Subtitle = "v1.0",
    ToggleUIKeybind = "RightControl",
})
```

That's a working menu. It comes with the Oblivion button to hide and show it, and ready-made **Server**, **ESP** and **Settings** tabs. Add `Home = true` for a Home tab too.

Drag any empty spot to move it. Drag the bottom-right corner to resize it.

## 3. Add a tab

```lua
local Main = Window:CreateTab({ Name = "Main", Icon = "zap" })
```

`Icon` is any [Lucide](https://lucide.dev/icons) icon name.

## 4. Add things to the tab

```lua
Main:CreateSection("Player")

Main:CreateButton({
    Name = "Say hi",
    Callback = function()
        print("hi")
    end,
})

Main:CreateToggle({
    Name = "Auto sprint",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto sprint is", Value)
    end,
})

Main:CreateSlider({
    Name = "Walk speed",
    Range = { 16, 100 },
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})
```

Every element works the same way: give it a `Name`, and a `Callback` that runs when the user changes it.

## 5. Show a notification

```lua
Oblivion:Notify({
    Title = "Loaded",
    Content = "Everything is ready",
    Type = "Success", -- "Info", "Success", "Warning" or "Error"
    Duration = 4,
})
```

## 6. Save the user's settings

Turn saving on in the window, give each element a `Flag`, then load at the end.

```lua
local Window = Oblivion:CreateWindow({
    Name = "My Hub",
    ConfigurationSaving = { Enabled = true, FolderName = "MyHub" },
})

local Main = Window:CreateTab({ Name = "Main", Icon = "zap" })

Main:CreateToggle({ Name = "Auto sprint", Flag = "AutoSprint", Callback = function(v) end })

Window:LoadConfig() -- always last
```

---

## Full example

```lua
local Oblivion = loadstring(game:HttpGet("https://raw.githubusercontent.com/OSSDiablo/OblivionHub-UI/main/Source.luau"))()

local Window = Oblivion:CreateWindow({
    Name = "My Hub",
    Subtitle = "v1.0",
    ConfigurationSaving = { Enabled = true, FolderName = "MyHub" },
})

local Main = Window:CreateTab({ Name = "Main", Icon = "zap" })

Main:CreateSection("Movement")

Main:CreateSlider({
    Name = "Walk speed",
    Range = { 16, 100 },
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = Value end
    end,
})

Main:CreateToggle({
    Name = "Infinite jump",
    Flag = "InfJump",
    Callback = function(Value)
        print("Infinite jump", Value)
    end,
})

Main:CreateButton({
    Name = "Reset character",
    Style = "Danger",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end,
})

Oblivion:Notify({ Title = "My Hub", Content = "Loaded", Type = "Success" })

Window:LoadConfig()
```

[`Example.luau`](Example.luau) shows every element at once.

---

## All elements

| Element | Code | Callback gets |
| --- | --- | --- |
| Section | `Tab:CreateSection("Title")` | |
| Divider | `Tab:CreateDivider()` | |
| Label | `Tab:CreateLabel("Text")` | |
| Paragraph | `Tab:CreateParagraph({ Title, Content })` | |
| Button | `Tab:CreateButton({ Name, Callback })` | nothing |
| Toggle | `Tab:CreateToggle({ Name, CurrentValue, Callback })` | `true` / `false` |
| Slider | `Tab:CreateSlider({ Name, Range = {min, max}, Increment, CurrentValue, Callback })` | number |
| Stepper | `Tab:CreateStepper({ Name, Range, Increment, CurrentValue, Callback })` | number |
| Progress | `Tab:CreateProgress({ Name, CurrentValue })` | |
| Dropdown | `Tab:CreateDropdown({ Name, Options = {...}, CurrentOption, MultipleOptions, Callback })` | option, or a list |
| Input | `Tab:CreateInput({ Name, PlaceholderText, Callback })` | text |
| Keybind | `Tab:CreateKeybind({ Name, CurrentKeybind = "F", Callback })` | key |
| Color picker | `Tab:CreateColorPicker({ Name, Color, Callback })` | Color3 |

Every element also takes:

- `Desc` for a small grey line under the name
- `Flag` so it gets saved
- `Locked = true` and `LockedReason = "Premium"` to lock it

And every element you create can be changed later:

```lua
local Speed = Main:CreateSlider({ Name = "Walk speed", Range = { 16, 100 } })

Speed:Set(50)          -- change the value
print(Speed:Get())     -- read the value
Speed:SetLocked(true)  -- lock it
Speed:SetVisible(false) -- hide it
```

## Built-in tabs

| Tab | What it does | Turn it off |
| --- | --- | --- |
| Home | Greeting and live stats (FPS, ping, time in server) | off unless `Home = true` |
| Server | Rejoin, server hop, join the smallest server, live server list | `Server = false` |
| ESP | Boxes, names, distance, health, tracers, chams and outlines, with a live avatar preview | `Esp = false` |
| Settings | Theme, hide key, saved configs, unload | `Settings = false` |

```lua
Oblivion:CreateWindow({ Name = "My Hub", Home = true, Server = false })
```

## Popups

```lua
Oblivion:Confirm({
    Title = "Unload?",
    Content = "The menu will close.",
    Callback = function()
        Window:Destroy()
    end,
})
```

## Themes

Built in: `Default`, `Midnight`, `Crimson`, `Ember`, `Rose`, `Mono`.

```lua
Oblivion:SetTheme("Midnight")
Oblivion:SetTheme({ Accent = Color3.fromRGB(0, 227, 255) })
```

## Window options

| Option | What it does | Default |
| --- | --- | --- |
| `Name` | Name of the ScreenGui. The sidebar title is always Oblivion, use `Subtitle` for your script name | `"Oblivion"` |
| `Subtitle` | Small line under the title | none |
| `Icon` | Logo next to the title | Oblivion logo |
| `Theme` | Starting theme | `"Default"` |
| `ToggleUIKeybind` | Key that hides and shows the menu | `"RightControl"` |
| `Size` | Starting size | `UDim2.fromOffset(640, 480)` |
| `ConfigurationSaving` | `{ Enabled, FolderName, FileName, AutoSave }` | off |
| `OpenButton` | The draggable Oblivion button. `false` removes it | on |
| `Loading` | Loading screen. `false` skips it | on |
| `Home`, `Server`, `Esp`, `Settings` | Built-in tabs | see above |

## Window functions

| Code | What it does |
| --- | --- |
| `Window:Toggle()` | Hide or show the menu |
| `Window:SelectTab("Main")` | Open a tab |
| `Window:SetKeybind("RightShift")` | Change the hide key |
| `Window:SaveConfig()` / `Window:LoadConfig()` | Save or load settings |
| `Window:Destroy()` | Close and remove everything |

---

<p align="center">
  Based on <a href="https://github.com/PookiePepelsss/Airflow-UI">Airflow UI</a> by Pookie.
</p>
