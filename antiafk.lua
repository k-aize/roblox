wait(0.5)

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Name = "AntiAFKGui"

-- Header (Main Container)
local header = Instance.new("Frame")
header.Name = "Header"
header.Parent = gui
header.Active = true
header.Draggable = true
header.BackgroundColor3 = Color3.fromRGB(20, 20, 80)
header.Position = UDim2.new(0.7, 0, 0.1, 0)
header.Size = UDim2.new(0, 420, 0, 50)
header.BackgroundTransparency = 0.1

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local headerStroke = Instance.new("UIStroke")
headerStroke.Color = Color3.fromRGB(100, 100, 255)
headerStroke.Thickness = 2
headerStroke.Transparency = 0.5
headerStroke.Parent = header

-- Title (Centered)
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = header
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 60, 0, 0)  -- Offset karena ada tombol minimize di kiri
title.Size = UDim2.new(1, -120, 1, 0)    -- Kurangi 120 (60 kiri + 60 kanan)
title.Font = Enum.Font.GothamBlack
title.Text = "Anti-AFK"
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Center

-- Minimize Button (Kiri)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "Minimize"
minimizeBtn.Parent = header
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Position = UDim2.new(0, 12, 0, 0)
minimizeBtn.Size = UDim2.new(0, 40, 1, 0)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Text = "–"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
minimizeBtn.TextSize = 36

-- Close Button (Kanan)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "Close"
closeBtn.Parent = header
closeBtn.BackgroundTransparency = 1
closeBtn.Position = UDim2.new(1, -45, 0, 0)
closeBtn.Size = UDim2.new(0, 40, 1, 0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.TextSize = 30

-- Body (Content yang bisa diminimize)
local body = Instance.new("Frame")
body.Name = "Body"
body.Parent = header
body.BackgroundColor3 = Color3.fromRGB(15, 15, 60)
body.Position = UDim2.new(0, 0, 1, 5)
body.Size = UDim2.new(0, 420, 0, 120)
body.Visible = true

local bodyCorner = Instance.new("UICorner")
bodyCorner.CornerRadius = UDim.new(0, 12)
bodyCorner.Parent = body

local bodyStroke = Instance.new("UIStroke")
bodyStroke.Color = Color3.fromRGB(80, 80, 200)
bodyStroke.Thickness = 1.5
bodyStroke.Transparency = 0.7
bodyStroke.Parent = body

-- Status
local status = Instance.new("TextLabel")
status.Parent = body
status.BackgroundTransparency = 1
status.Position = UDim2.new(0, 0, 0, 20)
status.Size = UDim2.new(1, 0, 0, 50)
status.Font = Enum.Font.Gotham
status.Text = "Status: Active"
status.TextColor3 = Color3.fromRGB(150, 255, 150)
status.TextSize = 24
status.TextXAlignment = Enum.TextXAlignment.Center

-- Footer
local footer = Instance.new("TextLabel")
footer.Parent = body
footer.BackgroundTransparency = 1
footer.Position = UDim2.new(0, 0, 1, -30)
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Font = Enum.Font.GothamSemibold
footer.Text = "Made by Kai"
footer.TextColor3 = Color3.fromRGB(140, 140, 255)
footer.TextSize = 18
footer.TextXAlignment = Enum.TextXAlignment.Center

-- Minimize / Restore Logic
local isMinimized = false

minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        body.Visible = false
        header.Size = UDim2.new(0, 420, 0, 50)
        minimizeBtn.Text = "+"
    else
        body.Visible = true
        header.Size = UDim2.new(0, 420, 0, 50)
        minimizeBtn.Text = "–"
    end
end)

-- Close Logic
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Anti-AFK Logic
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")

Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    
    status.Text = "AFK detection kicked! Still active."
    status.TextColor3 = Color3.fromRGB(255, 255, 150)
    
    wait(3)
    
    status.Text = "Status: Active"
    status.TextColor3 = Color3.fromRGB(150, 255, 150)
end)

-- Set initial expanded size
header.Size = UDim2.new(0, 420, 0, 50)
