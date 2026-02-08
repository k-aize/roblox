-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ESPOutlineToggle = Instance.new("TextButton")
local ESPNameToggle = Instance.new("TextButton")
local ESPTeamCheckToggle = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Properties ScreenGui
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "ESPMenu"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Properties MainFrame
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 8)

-- Properties Title
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "ESP Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

local TitleCorner = Instance.new("UICorner")
TitleCorner.Parent = Title
TitleCorner.CornerRadius = UDim.new(0, 8)

-- Properties ESP Outline Toggle
ESPOutlineToggle.Parent = MainFrame
ESPOutlineToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ESPOutlineToggle.BorderSizePixel = 0
ESPOutlineToggle.Position = UDim2.new(0.1, 0, 0.25, 0)
ESPOutlineToggle.Size = UDim2.new(0.8, 0, 0, 35)
ESPOutlineToggle.Font = Enum.Font.Gotham
ESPOutlineToggle.Text = "ESP Outline: OFF"
ESPOutlineToggle.TextColor3 = Color3.fromRGB(255, 75, 75)
ESPOutlineToggle.TextSize = 14

local OutlineCorner = Instance.new("UICorner")
OutlineCorner.Parent = ESPOutlineToggle
OutlineCorner.CornerRadius = UDim.new(0, 6)

-- Properties ESP Name Toggle
ESPNameToggle.Parent = MainFrame
ESPNameToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ESPNameToggle.BorderSizePixel = 0
ESPNameToggle.Position = UDim2.new(0.1, 0, 0.45, 0)
ESPNameToggle.Size = UDim2.new(0.8, 0, 0, 35)
ESPNameToggle.Font = Enum.Font.Gotham
ESPNameToggle.Text = "ESP Name: OFF"
ESPNameToggle.TextColor3 = Color3.fromRGB(255, 75, 75)
ESPNameToggle.TextSize = 14

local NameCorner = Instance.new("UICorner")
NameCorner.Parent = ESPNameToggle
NameCorner.CornerRadius = UDim.new(0, 6)

-- Properties ESP Team Check Toggle
ESPTeamCheckToggle.Parent = MainFrame
ESPTeamCheckToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ESPTeamCheckToggle.BorderSizePixel = 0
ESPTeamCheckToggle.Position = UDim2.new(0.1, 0, 0.65, 0)
ESPTeamCheckToggle.Size = UDim2.new(0.8, 0, 0, 35)
ESPTeamCheckToggle.Font = Enum.Font.Gotham
ESPTeamCheckToggle.Text = "Team Check: OFF"
ESPTeamCheckToggle.TextColor3 = Color3.fromRGB(255, 75, 75)
ESPTeamCheckToggle.TextSize = 14

local TeamCorner = Instance.new("UICorner")
TeamCorner.Parent = ESPTeamCheckToggle
TeamCorner.CornerRadius = UDim.new(0, 6)

-- Properties Close Button
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.1, 0, 0.85, 0)
CloseButton.Size = UDim2.new(0.8, 0, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "CLOSE"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.Parent = CloseButton
CloseCorner.CornerRadius = UDim.new(0, 6)

-- Variables
local ESPEnabled = {
    Outline = false,
    Name = false,
    TeamCheck = false
}

local ESPObjects = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Fungsi untuk membuat ESP
local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local espFolder = Instance.new("Folder")
    espFolder.Name = "ESP_" .. player.Name
    espFolder.Parent = game.CoreGui
    
    ESPObjects[player] = {
        Folder = espFolder,
        Highlight = nil,
        BillboardGui = nil
    }
    
    local function UpdateESP()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
        
        -- ESP Outline (Highlight)
        if ESPEnabled.Outline then
            if not ESPObjects[player].Highlight then
                local highlight = Instance.new("Highlight")
                highlight.Parent = espFolder
                highlight.Adornee = player.Character
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                ESPObjects[player].Highlight = highlight
            end
            
            -- Team Check
            if ESPEnabled.TeamCheck and player.Team == LocalPlayer.Team then
                ESPObjects[player].Highlight.OutlineColor = Color3.fromRGB(75, 255, 75)
            else
                ESPObjects[player].Highlight.OutlineColor = Color3.fromRGB(255, 75, 75)
            end
        elseif ESPObjects[player].Highlight then
            ESPObjects[player].Highlight:Destroy()
            ESPObjects[player].Highlight = nil
        end
        
        -- ESP Name
        if ESPEnabled.Name then
            if not ESPObjects[player].BillboardGui then
                local billboard = Instance.new("BillboardGui")
                billboard.Parent = espFolder
                billboard.Adornee = player.Character.HumanoidRootPart
                billboard.Size = UDim2.new(0, 100, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Parent = billboard
                textLabel.BackgroundTransparency = 1
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Font = Enum.Font.GothamBold
                textLabel.TextSize = 14
                textLabel.TextStrokeTransparency = 0.5
                textLabel.Text = player.Name
                
                ESPObjects[player].BillboardGui = billboard
            end
            
            -- Team Check untuk warna nama
            if ESPEnabled.TeamCheck and player.Team == LocalPlayer.Team then
                ESPObjects[player].BillboardGui.TextLabel.TextColor3 = Color3.fromRGB(75, 255, 75)
            else
                ESPObjects[player].BillboardGui.TextLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
            end
        elseif ESPObjects[player].BillboardGui then
            ESPObjects[player].BillboardGui:Destroy()
            ESPObjects[player].BillboardGui = nil
        end
    end
    
    player.CharacterAdded:Connect(function()
        wait(0.1)
        UpdateESP()
    end)
    
    UpdateESP()
end

-- Fungsi untuk update semua ESP
local function UpdateAllESP()
    for player, espData in pairs(ESPObjects) do
        if player and player.Character then
            -- Hapus ESP lama
            if espData.Highlight then
                espData.Highlight:Destroy()
                espData.Highlight = nil
            end
            if espData.BillboardGui then
                espData.BillboardGui:Destroy()
                espData.BillboardGui = nil
            end
            
            -- Buat ESP baru dengan setting terbaru
            CreateESP(player)
        end
    end
end

-- Fungsi untuk hapus semua ESP
local function RemoveAllESP()
    for player, espData in pairs(ESPObjects) do
        if espData.Folder then
            espData.Folder:Destroy()
        end
    end
    ESPObjects = {}
end

-- Toggle ESP Outline
ESPOutlineToggle.MouseButton1Click:Connect(function()
    ESPEnabled.Outline = not ESPEnabled.Outline
    ESPOutlineToggle.Text = "ESP Outline: " .. (ESPEnabled.Outline and "ON" or "OFF")
    ESPOutlineToggle.TextColor3 = ESPEnabled.Outline and Color3.fromRGB(75, 255, 75) or Color3.fromRGB(255, 75, 75)
    UpdateAllESP()
end)

-- Toggle ESP Name
ESPNameToggle.MouseButton1Click:Connect(function()
    ESPEnabled.Name = not ESPEnabled.Name
    ESPNameToggle.Text = "ESP Name: " .. (ESPEnabled.Name and "ON" or "OFF")
    ESPNameToggle.TextColor3 = ESPEnabled.Name and Color3.fromRGB(75, 255, 75) or Color3.fromRGB(255, 75, 75)
    UpdateAllESP()
end)

-- Toggle Team Check
ESPTeamCheckToggle.MouseButton1Click:Connect(function()
    ESPEnabled.TeamCheck = not ESPEnabled.TeamCheck
    ESPTeamCheckToggle.Text = "Team Check: " .. (ESPEnabled.TeamCheck and "ON" or "OFF")
    ESPTeamCheckToggle.TextColor3 = ESPEnabled.TeamCheck and Color3.fromRGB(75, 255, 75) or Color3.fromRGB(255, 75, 75)
    UpdateAllESP()
end)

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
    -- Matikan semua fitur
    ESPEnabled.Outline = false
    ESPEnabled.Name = false
    ESPEnabled.TeamCheck = false
    
    -- Hapus semua ESP
    RemoveAllESP()
    
    -- Hapus GUI
    ScreenGui:Destroy()
end)

-- Inisialisasi ESP untuk semua player yang ada
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end

-- ESP untuk player baru yang join
Players.PlayerAdded:Connect(function(player)
    CreateESP(player)
end)

-- Hapus ESP saat player leave
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        if ESPObjects[player].Folder then
            ESPObjects[player].Folder:Destroy()
        end
        ESPObjects[player] = nil
    end
end)

print("ESP Menu loaded successfully!")
