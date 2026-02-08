-- Roblox ESP Script dengan Keybind
-- [ = Toggle ESP Outline
-- ] = Toggle ESP Name
-- \ = Toggle ESP Team Check

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Konfigurasi ESP
local ESPSettings = {
    OutlineEnabled = false,
    NameEnabled = false,
    TeamCheck = false,
    OutlineColor = Color3.fromRGB(255, 0, 0),
    NameColor = Color3.fromRGB(255, 255, 255),
    TeamColor = true, -- Gunakan warna tim
    MaxDistance = 1000
}

-- Tabel untuk menyimpan ESP objects
local ESPObjects = {}

-- Fungsi untuk membuat highlight (outline)
local function createHighlight(player)
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = ESPSettings.OutlineColor
    highlight.Adornee = nil
    highlight.Parent = game.CoreGui
    return highlight
end

-- Fungsi untuk membuat name tag
local function createNameTag(player)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP_NameTag"
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = game.CoreGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = ESPSettings.NameColor
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 16
    textLabel.Text = player.Name
    textLabel.Parent = billboardGui
    
    return billboardGui, textLabel
end

-- Fungsi untuk menambahkan ESP ke player
local function addESP(player)
    if player == LocalPlayer then return end
    
    local espData = {
        Player = player,
        Highlight = createHighlight(player),
        NameTag = createNameTag(player)
    }
    
    ESPObjects[player] = espData
end

-- Fungsi untuk menghapus ESP dari player
local function removeESP(player)
    if ESPObjects[player] then
        if ESPObjects[player].Highlight then
            ESPObjects[player].Highlight:Destroy()
        end
        if ESPObjects[player].NameTag then
            ESPObjects[player].NameTag:Destroy()
        end
        ESPObjects[player] = nil
    end
end

-- Fungsi untuk update ESP
local function updateESP()
    for player, espData in pairs(ESPObjects) do
        if player and player.Character then
            local character = player.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if humanoidRootPart and humanoid and humanoid.Health > 0 then
                -- Cek jarak
                local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) 
                    and (LocalPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude 
                    or math.huge
                
                -- Cek team
                local showESP = true
                if ESPSettings.TeamCheck and LocalPlayer.Team and player.Team then
                    showESP = player.Team ~= LocalPlayer.Team
                end
                
                if distance <= ESPSettings.MaxDistance and showESP then
                    -- Update Highlight
                    if espData.Highlight then
                        espData.Highlight.Adornee = character
                        espData.Highlight.Enabled = ESPSettings.OutlineEnabled
                        
                        if ESPSettings.TeamColor and player.Team then
                            espData.Highlight.OutlineColor = player.Team.TeamColor.Color
                        else
                            espData.Highlight.OutlineColor = ESPSettings.OutlineColor
                        end
                    end
                    
                    -- Update NameTag
                    if espData.NameTag then
                        espData.NameTag.Adornee = humanoidRootPart
                        espData.NameTag.Enabled = ESPSettings.NameEnabled
                        
                        if ESPSettings.TeamColor and player.Team then
                            espData.NameTag.TextLabel.TextColor3 = player.Team.TeamColor.Color
                        else
                            espData.NameTag.TextLabel.TextColor3 = ESPSettings.NameColor
                        end
                        
                        -- Tambahkan info jarak
                        espData.NameTag.TextLabel.Text = player.Name .. "\n[" .. math.floor(distance) .. " studs]"
                    end
                else
                    -- Sembunyikan jika terlalu jauh atau satu tim
                    if espData.Highlight then
                        espData.Highlight.Enabled = false
                    end
                    if espData.NameTag then
                        espData.NameTag.Enabled = false
                    end
                end
            else
                -- Sembunyikan jika mati
                if espData.Highlight then
                    espData.Highlight.Enabled = false
                end
                if espData.NameTag then
                    espData.NameTag.Enabled = false
                end
            end
        end
    end
end

-- Fungsi notifikasi
local function notify(message)
    game.StarterGui:SetCore("SendNotification", {
        Title = "ESP Script";
        Text = message;
        Duration = 3;
    })
end

-- Setup ESP untuk semua player yang ada
for _, player in pairs(Players:GetPlayers()) do
    addESP(player)
end

-- Event ketika player baru join
Players.PlayerAdded:Connect(function(player)
    addESP(player)
end)

-- Event ketika player leave
Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

-- Update loop
RunService.RenderStepped:Connect(function()
    updateESP()
end)

-- Keybind handling
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- [ = Toggle Outline
    if input.KeyCode == Enum.KeyCode.LeftBracket then
        ESPSettings.OutlineEnabled = not ESPSettings.OutlineEnabled
        notify("ESP Outline: " .. (ESPSettings.OutlineEnabled and "ON" or "OFF"))
    end
    
    -- ] = Toggle Name
    if input.KeyCode == Enum.KeyCode.RightBracket then
        ESPSettings.NameEnabled = not ESPSettings.NameEnabled
        notify("ESP Name: " .. (ESPSettings.NameEnabled and "ON" or "OFF"))
    end
    
    -- \ = Toggle Team Check
    if input.KeyCode == Enum.KeyCode.BackSlash then
        ESPSettings.TeamCheck = not ESPSettings.TeamCheck
        notify("ESP Team Check: " .. (ESPSettings.TeamCheck and "ON" or "OFF"))
    end
end)

-- Notifikasi script loaded
notify("ESP Script Loaded!\n[ = Outline | ] = Name | \\ = Team Check")
print("ESP Script loaded successfully!")
