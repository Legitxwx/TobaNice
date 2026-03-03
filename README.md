# 🚀 TOBA UI Library

<p align="center">
  <img src="https://img.shields.io/badge/version-4.0-blue" />
  <img src="https://img.shields.io/badge/status-active-brightgreen" />
  <img src="https://img.shields.io/badge/license-MIT-green" />
  <img src="https://img.shields.io/badge/made%20with-Lua-2C2D72?logo=lua&logoColor=white" />
</p>

---

# ✨ About

**TOBA is a modern, lightweight, and powerful UI library designed to create clean and interactive interfaces with ease.**

**Built for performance, smooth animations, and a clean developer-friendly API.**

---

# 🔥 Features

- 🎨 Modern & clean UI design
- ✨ Smooth animation system
- 🖱️ Draggable window support
- ⚡ Lightweight & optimized
- 📂 Tabs & sections layout
- 🔘 Buttons, Toggles, Sliders, Dropdowns
- ⌨️ Keybind system
- 🔔 Built-in notification system
- 🧩 Simple & readable API

---

# 📦 Installation
```
local Toba = require(path.To.Toba)
````
---

# 🪟 Window
```
local Window = Toba:CreateWindow({
    Title = "Toba UI V4",
    Size = UDim2.new(0.5, 0, 0.6, 0)
})
```
---

# 📑 Tab
```
local Main = Window:CreateTab("Main")
```
---

# 📂 Section
```
Main:CreateSection("Basic")
```
---

# 🔘 Button
```
Main:CreateButton({
    Name = "Print Hello",
    Callback = function()
        print("Hello World")
    end
})
```
---

# 🔁 Toggle
```
Main:CreateToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Toggle:", state)
    end
})
```
---

# 🎚️ Slider
```
Main:CreateSlider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 25,
    Callback = function(value)
        print("Slider:", value)
    end
})
```
---

# 📋 Dropdown
```
Main:CreateDropdown({
    Name = "Select Mode",
    Options = {"Easy", "Medium", "Hard"},
    Callback = function(option)
        print(option)
    end
})
```
---

# ⌨️ Input
```
Main:CreateInput({
    Placeholder = "Enter Name",
    Callback = function(text)
        print(text)
    end
})
```
---

# 🎮 Keybind
```
Main:CreateKeybind({
    Name = "Open/Close",
    Default = Enum.KeyCode.RightShift,
    Callback = function()
        print("Key pressed")
    end
})
```
---

# 🔔 Notification
```
Window:Notify("Loaded Successfully", 3)
```
---

# ⭐ Support

- If you like this project, consider giving it a star on GitHub!
