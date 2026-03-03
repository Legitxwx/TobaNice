local Toba = {} Toba.__index = Toba

-- Services local Players = game:GetService("Players") local TweenService = game:GetService("TweenService") local UIS = game:GetService("UserInputService") local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer

-- Theme Toba.Theme = { Background = Color3.fromRGB(20,20,20), Topbar = Color3.fromRGB(30,30,30), Element = Color3.fromRGB(40,40,40), Accent = Color3.fromRGB(0,170,255), Text = Color3.fromRGB(255,255,255) }

function Toba:SetTheme(t) for k,v in pairs(t) do self.Theme[k] = v end end

-- Utils local function Create(i,p) local o = Instance.new(i) for k,v in pairs(p or {}) do o[k]=v end return o end

local function Tween(o,p,t) TweenService:Create(o,TweenInfo.new(t or 0.18,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p):Play() end

local function MakeDraggable(frame) local dragging, dragInput, startPos, startInput

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        startInput = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - startInput
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

end

-- Create Window function Toba:CreateWindow(cfg) cfg = cfg or {}

local ScreenGui = Create("ScreenGui",{
    Name="TobaUIV4",
    Parent=Player:WaitForChild("PlayerGui"),
    ResetOnSpawn=false
})

local Float = Create("TextButton",{
    Parent=ScreenGui,
    Size=UDim2.new(0,50,0,50),
    Position=UDim2.new(0,20,0.5,-25),
    Text="T",
    BackgroundColor3=self.Theme.Accent,
    TextColor3=Color3.new(1,1,1),
    Font=Enum.Font.GothamBold,
    TextSize=20,
    BorderSizePixel=0
})
Create("UICorner",{Parent=Float,CornerRadius=UDim.new(1,0)})
MakeDraggable(Float)

local Main = Create("Frame",{
    Parent=ScreenGui,
    Size=cfg.Size or UDim2.new(0.5,0,0.6,0),
    Position=UDim2.new(0.5,0,0.5,0),
    AnchorPoint=Vector2.new(0.5,0.5),
    BackgroundColor3=self.Theme.Background,
    BorderSizePixel=0,
    Visible=false
})
Create("UICorner",{Parent=Main,CornerRadius=UDim.new(0,12)})
Create("UIScale",{Parent=Main})
MakeDraggable(Main)

Float.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- Topbar
local Top = Create("Frame",{Parent=Main,Size=UDim2.new(1,0,0,45),BackgroundColor3=self.Theme.Topbar,BorderSizePixel=0})
Create("UICorner",{Parent=Top,CornerRadius=UDim.new(0,12)})

local Title = Create("TextLabel",{
    Parent=Top,
    Size=UDim2.new(1,-120,1,0),
    Position=UDim2.new(0,15,0,0),
    BackgroundTransparency=1,
    Text=cfg.Title or "Toba UI",
    Font=Enum.Font.GothamBold,
    TextSize=18,
    TextColor3=self.Theme.Text,
    TextXAlignment=Enum.TextXAlignment.Left
})

local function TopBtn(text,pos)
    local b = Create("TextButton",{
        Parent=Top,
        Size=UDim2.new(0,30,0,30),
        Position=pos,
        Text=text,
        BackgroundColor3=self.Theme.Element,
        TextColor3=self.Theme.Text,
        Font=Enum.Font.GothamBold,
        TextSize=16,
        BorderSizePixel=0
    })
    Create("UICorner",{Parent=b,CornerRadius=UDim.new(0,6)})
    return b
end

local Close = TopBtn("X",UDim2.new(1,-35,0.5,-15))
local Min = TopBtn("-",UDim2.new(1,-70,0.5,-15))
local Max = TopBtn("+",UDim2.new(1,-105,0.5,-15))

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local minimized=false
Min.MouseButton1Click:Connect(function()
    minimized=not minimized
    Main.Size = minimized and UDim2.new(Main.Size.X.Scale,0,0,45) or (cfg.Size or UDim2.new(0.5,0,0.6,0))
end)

Max.MouseButton1Click:Connect(function()
    Main.Size = UDim2.new(0.8,0,0.85,0)
end)

-- Tabs
local TabHolder = Create("Frame",{Parent=Main,Position=UDim2.new(0,0,0,45),Size=UDim2.new(0,140,1,-45),BackgroundColor3=self.Theme.Element,BorderSizePixel=0})
local LayoutTabs = Create("UIListLayout",{Parent=TabHolder,Padding=UDim.new(0,6)})

local Content = Create("Frame",{Parent=Main,Position=UDim2.new(0,140,0,45),Size=UDim2.new(1,-140,1,-45),BackgroundTransparency=1})

local Window = {}

function Window:Notify(text,time)
    local n = Create("TextLabel",{
        Parent=ScreenGui,
        Size=UDim2.new(0,260,0,50),
        Position=UDim2.new(1,-280,1,-60),
        BackgroundColor3=Toba.Theme.Element,
        Text=text,
        Font=Enum.Font.Gotham,
        TextSize=14,
        TextColor3=Toba.Theme.Text,
        BorderSizePixel=0
    })
    Create("UICorner",{Parent=n,CornerRadius=UDim.new(0,8)})
    task.delay(time or 3,function() n:Destroy() end)
end

function Window:CreateTab(name)
    local Btn = Create("TextButton",{Parent=TabHolder,Size=UDim2.new(1,-10,0,35),Text=name,BackgroundColor3=Toba.Theme.Background,TextColor3=Toba.Theme.Text,Font=Enum.Font.Gotham,TextSize=14,BorderSizePixel=0})
    Create("UICorner",{Parent=Btn,CornerRadius=UDim.new(0,6)})

    local Page = Create("ScrollingFrame",{Parent=Content,Size=UDim2.new(1,0,1,0),CanvasSize=UDim2.new(0,0,0,0),ScrollBarImageTransparency=0.5,Visible=false,BackgroundTransparency=1})
    local Layout = Create("UIListLayout",{Parent=Page,Padding=UDim.new(0,8)})
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize=UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y+10)
    end)

    Btn.MouseButton1Click:Connect(function()
        for _,v in pairs(Content:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible=false end end
        Page.Visible=true
    end)

    local Tab = {}

    function Tab:CreateSection(text)
        Create("TextLabel",{Parent=Page,Size=UDim2.new(1,-10,0,30),BackgroundTransparency=1,Text=text,Font=Enum.Font.GothamBold,TextSize=16,TextColor3=Toba.Theme.Accent,TextXAlignment=Enum.TextXAlignment.Left})
    end

    function Tab:CreateParagraph(text)
        local p = Create("TextLabel",{Parent=Page,Size=UDim2.new(1,-10,0,50),BackgroundColor3=Toba.Theme.Element,TextWrapped=true,Text=text,Font=Enum.Font.Gotham,TextSize=14,TextColor3=Toba.Theme.Text,BorderSizePixel=0})
        Create("UICorner",{Parent=p,CornerRadius=UDim.new(0,6)})
    end

    function Tab:CreateButton(cfg)
        local b = Create("TextButton",{Parent=Page,Size=UDim2.new(1,-10,0,40),Text=cfg.Name or "Button",BackgroundColor3=Toba.Theme.Element,TextColor3=Toba.Theme.Text,Font=Enum.Font.Gotham,TextSize=14,BorderSizePixel=0})
        Create("UICorner",{Parent=b,CornerRadius=UDim.new(0,6)})
        b.MouseButton1Click:Connect(function() if cfg.Callback then cfg.Callback() end end)
    end

    function Tab:CreateToggle(cfg)
        local state = cfg.Default or false
        local t = Create("TextButton",{Parent=Page,Size=UDim2.new(1,-10,0,40),Text=cfg.Name..": "..(state and "ON" or "OFF"),BackgroundColor3=Toba.Theme.Element,TextColor3=Toba.Theme.Text,Font=Enum.Font.Gotham,TextSize=14,BorderSizePixel=0})
        Create("UICorner",{Parent=t,CornerRadius=UDim.new(0,6)})
        t.MouseButton1Click:Connect(function()
            state=not state
            t.Text=cfg.Name..": "..(state and "ON" or "OFF")
            if cfg.Callback then cfg.Callback(state) end
        end)
    end

    function Tab:CreateInput(cfg)
        local box = Create("TextBox",{Parent=Page,Size=UDim2.new(1,-10,0,40),PlaceholderText=cfg.Placeholder or "Enter...",Text="",BackgroundColor3=Toba.Theme.Element,TextColor3=Toba.Theme.Text,Font=Enum.Font.Gotham,TextSize=14,BorderSizePixel=0})
        Create("UICorner",{Parent=box,CornerRadius=UDim.new(0,6)})
        box.FocusLost:Connect(function() if cfg.Callback then cfg.Callback(box.Text) end end)
    end

    function Tab:CreateSlider(cfg)
        local min,max = cfg.Min or 0,cfg.Max or 100
        local value = cfg.Default or min

        local holder = Create("Frame",{Parent=Page,Size=UDim2.new(1,-10,0,50),BackgroundColor3=Toba.Theme.Element,BorderSizePixel=0})
        Create("UICorner",{Parent=holder,CornerRadius=UDim.new(0,6)})

        local bar = Create("Frame",{Parent=holder,Position=UDim2.new(0,10,0,30),Size=UDim2.new(1,-20,0,6),BackgroundColor3=Toba.Theme.Background,BorderSizePixel=0})
        Create("UICorner",{Parent=bar,CornerRadius=UDim.new(1,0)})

        local fill = Create("Frame",{Parent=bar,Size=UDim2.new((value-min)/(max-min),0,1,0),BackgroundColor3=Toba.Theme.Accent,BorderSizePixel=0})
        Create("UICorner",{Parent=fill,CornerRadius=UDim.new(1,0)})

        bar.InputBegan:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                local move; move=UIS.InputChanged:Connect(function(i)
                    if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
                        local percent=math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
                        fill.Size=UDim2.new(percent,0,1,0)
                        value=math.floor(min+(max-min)*percent)
                        if cfg.Callback then cfg.Callback(value) end
                    end
                end)
                UIS.InputEnded:Wait()
                move:Disconnect()
            end
        end)
    end

    function Tab:CreateDropdown(cfg)
        local open=false
        local current=nil

        local main = Create("TextButton",{Parent=Page,Size=UDim2.new(1,-10,0,40),Text=cfg.Name,BackgroundColor3=Toba.Theme.Element,TextColor3=Toba.Theme.Text,Font=Enum.Font.Gotham,TextSize=14,BorderSizePixel=0})
        Create("UICorner",{Parent=main,CornerRadius=UDim.new(0,6)})

        local list = Create("Frame",{Parent=Page,Size=UDim2.new(1,-10,0,0),BackgroundColor3=Toba.Theme.Background,Visible=false,BorderSizePixel=0})
        Create("UICorner",{Parent=list,CornerRadius=UDim.new(0,6)})
        local layout = Create("UIListLayout",{Parent=list})

        main.MouseButton1Click:Connect(function()
            open=not open
            list.Visible=open
            list.Size=open and UDim2.new(1,-10,0,#cfg.Options*30) or UDim2.new(1,-10,0,0)
        end)

        for _,opt in pairs(cfg.Options or {}) do
            local o = Create("TextButton",{Parent=list,Size=UDim2.new(1,0,0,30),Text=opt,BackgroundColor3=Toba.Theme.Element,TextColor3=Toba.Theme.Text,Font=Enum.Font.Gotham,TextSize=13,BorderSizePixel=0})
            o.MouseButton1Click:Connect(function()
                current=opt
                main.Text=cfg.Name..": "..opt
                list.Visible=false
                if cfg.Callback then cfg.Callback(opt) end
            end)
        end
    end

    function Tab:CreateKeybind(cfg)
        local key = cfg.Default or Enum.KeyCode.E
        local waiting=false

        local b = Create("TextButton",{Parent=Page,Size=UDim2.new(1,-10,0,40),Text=cfg.Name..": "..key.Name,BackgroundColor3=Toba.Theme.Element,TextColor3=Toba.Theme.Text,Font=Enum.Font.Gotham,TextSize=14,BorderSizePixel=0})
        Create("UICorner",{Parent=b,CornerRadius=UDim.new(0,6)})

        b.MouseButton1Click:Connect(function()
            waiting=true
            b.Text="Press Key..."
        end)

        UIS.InputBegan:Connect(function(input,gp)
            if gp then return end
            if waiting then
                key=input.KeyCode
                b.Text=cfg.Name..": "..key.Name
                waiting=false
            elseif input.KeyCode==key then
                if cfg.Callback then cfg.Callback() end
            end
        end)
    end

    return Tab
end

return Window

end

return Toba
