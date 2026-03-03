🚀 TOBA UI Library (V4)

"Version" (https://img.shields.io/badge/version-4.0-blue)
"Status" (https://img.shields.io/badge/status-active-success)
"License" (https://img.shields.io/badge/license-MIT-green)
"Made With Lua" (https://img.shields.io/badge/made%20with-Lua-2C2D72)
"Maintained" (https://img.shields.io/badge/maintained-yes-brightgreen)

---

✨ About

TOBA is a modern, lightweight, and powerful UI library designed to help you build clean and interactive interfaces quickly and easily.

Built with performance, smooth animations, and developer experience in mind.

---

🔥 Features

- 🎨 Clean & modern design
- ✨ Smooth built-in animations
- 🖱️ Draggable window support
- ⚡ Optimized and lightweight
- 🧩 Easy-to-use and simple API
- 🔄 Real-time callback system
- 🔔 Built-in notification system
- 🎮 Keybind support
- 📂 Organized tab & section layout

---

📦 Installation

local Toba = require(path.To.Toba)

---

🪟 Basic Example

local Toba = require(path.To.Toba)

local Window = Toba:CreateWindow({
    Title = "Toba UI V4",
    Size = UDim2.new(0.5, 0, 0.6, 0)
})

local Main = Window:CreateTab("Main")
Main:CreateSection("Basic")

Main:CreateButton({
    Name = "Print Hello",
    Callback = function()
        print("Hello World")
    end
})

Window:Notify("Loaded Successfully", 3)

---

⭐ If you like this project, consider giving it a star!
