-- // ESP Highlight Script by Claude
-- // LocalScript (StarterPlayerScripts)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- ═══════════════════════════════════════
--           SETTINGS
-- ═══════════════════════════════════════
local Settings = {
    Enabled             = true,
    TeamCheck           = true,
    EnemyOutlineColor   = Color3.fromRGB(255, 255, 255), -- Putih
    TeamOutlineColor    = Color3.fromRGB(255, 255, 255), -- Putih
    EnemyFillColor      = Color3.fromRGB(255, 50, 50),   -- Merah
    TeamFillColor       = Color3.fromRGB(50, 255, 100),  -- Hijau
    FillTransparency    = 0.6,  -- 0 = solid, 1 = invisible
    OutlineTransparency = 0.2,
    DepthMode           = Enum.HighlightDepthMode.AlwaysOnTop, -- Keliatan di balik tembok
}

-- ═══════════════════════════════════════
--           ESP STORAGE
-- ═══════════════════════════════════════
local ESPList = {}

local function IsEnemy(player)
    if not Settings.TeamCheck then return true end
    return player.Team ~= LocalPlayer.Team
end

local function ApplyHighlight(player)
    if player == LocalPlayer then return end

    -- Hapus highlight lama kalau ada
    if ESPList[player] then
        ESPList[player]:Destroy()
        ESPList[player] = nil
    end

    local character = player.Character
    if not character then return end

    local highlight = Instance.new("Highlight")
    highlight.Name                = "ESP_Highlight"
    highlight.DepthMode           = Settings.DepthMode
    highlight.FillTransparency    = Settings.FillTransparency
    highlight.OutlineTransparency = Settings.OutlineTransparency

    local enemy = IsEnemy(player)
    highlight.OutlineColor = enemy and Settings.EnemyOutlineColor or Settings.TeamOutlineColor
    highlight.FillColor    = enemy and Settings.EnemyFillColor    or Settings.TeamFillColor

    highlight.Adornee = character
    highlight.Parent  = character

    ESPList[player] = highlight
end

local function RemoveHighlight(player)
    if ESPList[player] then
        ESPList[player]:Destroy()
        ESPList[player] = nil
    end
end

local function RefreshAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Settings.Enabled then
            local character = player.Character
            local humanoid  = character and character:FindFirstChildOfClass("Humanoid")
            if character and humanoid and humanoid.Health > 0 then
                ApplyHighlight(player)
            end
        else
            RemoveHighlight(player)
        end
    end
end

local function HideAll()
    for player, hl in pairs(ESPList) do
        hl:Destroy()
        ESPList[player] = nil
    end
end

-- ═══════════════════════════════════════
--           PLAYER EVENTS
-- ═══════════════════════════════════════
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if Settings.Enabled then
            ApplyHighlight(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveHighlight(player)
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player == LocalPlayer then continue end

    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if Settings.Enabled then
            ApplyHighlight(player)
        end
    end)

    if player.Character then
        task.wait(0.1)
        ApplyHighlight(player)
    end
end

-- ═══════════════════════════════════════
--       UPDATE LOOP (team warna)
-- ═══════════════════════════════════════
RunService.Heartbeat:Connect(function()
    for player, hl in pairs(ESPList) do
        if not hl or not hl.Parent then
            ESPList[player] = nil
            continue
        end

        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            RemoveHighlight(player)
            continue
        end

        local enemy = IsEnemy(player)

        -- Update warna sesuai setting
        hl.FillColor            = enemy and Settings.EnemyFillColor    or Settings.TeamFillColor
        hl.OutlineColor         = enemy and Settings.EnemyOutlineColor or Settings.TeamOutlineColor
        hl.FillTransparency     = Settings.FillTransparency
        hl.OutlineTransparency  = Settings.OutlineTransparency

        -- Sembunyikan saat ESP dimatikan
        if not Settings.Enabled then
            RemoveHighlight(player)
        end
    end
end)

-- ═══════════════════════════════════════
--           GUI MENU
-- ═══════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name              = "ESP_Menu"
ScreenGui.ResetOnSpawn      = false
ScreenGui.ZIndexBehavior    = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent            = LocalPlayer.PlayerGui

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size                      = UDim2.new(0, 230, 0, 290)
Frame.Position                  = UDim2.new(0.5, -115, 0.5, -145)
Frame.BackgroundColor3          = Color3.fromRGB(12, 12, 12)
Frame.BackgroundTransparency    = 0.1
Frame.BorderSizePixel           = 0
Frame.Active                    = true
Frame.Draggable                 = true
Frame.Parent                    = ScreenGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke")
stroke.Color        = Color3.fromRGB(255, 255, 255)
stroke.Transparency = 0.75
stroke.Thickness    = 1
stroke.Parent       = Frame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size                   = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3       = Color3.fromRGB(28, 28, 28)
TitleBar.BackgroundTransparency = 0.05
TitleBar.BorderSizePixel        = 0
TitleBar.Parent                 = Frame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

-- fix rounded bottom of title
local BarFix = Instance.new("Frame")
BarFix.Size                     = UDim2.new(1, 0, 0.5, 0)
BarFix.Position                 = UDim2.new(0, 0, 0.5, 0)
BarFix.BackgroundColor3         = Color3.fromRGB(28, 28, 28)
BarFix.BackgroundTransparency   = 0.05
BarFix.BorderSizePixel          = 0
BarFix.Parent                   = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text                 = "  🎯  ESP Highlight"
TitleLabel.Size                 = UDim2.new(1, -38, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3           = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize             = 14
TitleLabel.Font                 = Enum.Font.GothamBold
TitleLabel.TextXAlignment       = Enum.TextXAlignment.Left
TitleLabel.Parent               = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size                   = UDim2.new(0, 26, 0, 26)
CloseBtn.Position               = UDim2.new(1, -31, 0.5, -13)
CloseBtn.BackgroundColor3       = Color3.fromRGB(200, 40, 40)
CloseBtn.BorderSizePixel        = 0
CloseBtn.Text                   = "✕"
CloseBtn.TextColor3             = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize               = 13
CloseBtn.Font                   = Enum.Font.GothamBold
CloseBtn.Parent                 = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- ═══════════════════════════════════════
--         HELPER FUNCTIONS
-- ═══════════════════════════════════════
local function MakeToggle(parent, yPos, labelText, default, callback)
    local bg = Instance.new("Frame")
    bg.Size                     = UDim2.new(1, -20, 0, 40)
    bg.Position                 = UDim2.new(0, 10, 0, yPos)
    bg.BackgroundColor3         = Color3.fromRGB(22, 22, 22)
    bg.BackgroundTransparency   = 0.2
    bg.BorderSizePixel          = 0
    bg.Parent                   = parent
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Text                    = labelText
    lbl.Size                    = UDim2.new(0.68, 0, 1, 0)
    lbl.Position                = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency  = 1
    lbl.TextColor3              = Color3.fromRGB(220, 220, 220)
    lbl.TextSize                = 13
    lbl.Font                    = Enum.Font.Gotham
    lbl.TextXAlignment          = Enum.TextXAlignment.Left
    lbl.Parent                  = bg

    local state = default

    local toggle = Instance.new("TextButton")
    toggle.Size                 = UDim2.new(0, 46, 0, 24)
    toggle.Position             = UDim2.new(1, -56, 0.5, -12)
    toggle.BackgroundColor3     = state and Color3.fromRGB(70, 200, 110) or Color3.fromRGB(70, 70, 70)
    toggle.BorderSizePixel      = 0
    toggle.Text                 = ""
    toggle.Parent               = bg
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size                   = UDim2.new(0, 18, 0, 18)
    knob.Position               = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3       = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel        = 0
    knob.Parent                 = toggle
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(70, 200, 110) or Color3.fromRGB(70, 70, 70)
        knob.Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        callback(state)
    end)
end

local function MakeSlider(parent, yPos, labelText, min, max, default, callback)
    local bg = Instance.new("Frame")
    bg.Size                     = UDim2.new(1, -20, 0, 55)
    bg.Position                 = UDim2.new(0, 10, 0, yPos)
    bg.BackgroundColor3         = Color3.fromRGB(22, 22, 22)
    bg.BackgroundTransparency   = 0.2
    bg.BorderSizePixel          = 0
    bg.Parent                   = parent
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Text                    = labelText .. ":  " .. default .. "%"
    lbl.Size                    = UDim2.new(1, -10, 0, 22)
    lbl.Position                = UDim2.new(0, 12, 0, 6)
    lbl.BackgroundTransparency  = 1
    lbl.TextColor3              = Color3.fromRGB(220, 220, 220)
    lbl.TextSize                = 12
    lbl.Font                    = Enum.Font.Gotham
    lbl.TextXAlignment          = Enum.TextXAlignment.Left
    lbl.Parent                  = bg

    local track = Instance.new("TextButton")
    track.Size                  = UDim2.new(1, -24, 0, 8)
    track.Position              = UDim2.new(0, 12, 0, 34)
    track.BackgroundColor3      = Color3.fromRGB(55, 55, 55)
    track.BorderSizePixel       = 0
    track.Text                  = ""
    track.Parent                = bg
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size                   = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3       = Color3.fromRGB(70, 200, 110)
    fill.BorderSizePixel        = 0
    fill.Parent                 = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local UIS = game:GetService("UserInputService")
    local dragging = false

    local function updateSlider(inputX)
        local rel = math.clamp((inputX - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local val = math.round(min + rel * (max - min))
        fill.Size = UDim2.new(rel, 0, 1, 0)
        lbl.Text  = labelText .. ":  " .. val .. "%"
        callback(val / 100)
    end

    track.MouseButton1Down:Connect(function(x)
        dragging = true
        updateSlider(x)
    end)

    UIS.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(inp.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- ═══════════════════════════════════════
--         BUILD MENU CONTENT
-- ═══════════════════════════════════════
local Content = Instance.new("Frame")
Content.Size                    = UDim2.new(1, 0, 1, -38)
Content.Position                = UDim2.new(0, 0, 0, 38)
Content.BackgroundTransparency  = 1
Content.BorderSizePixel         = 0
Content.Parent                  = Frame

-- Toggle: ESP Aktif
MakeToggle(Content, 8, "ESP Aktif", Settings.Enabled, function(v)
    Settings.Enabled = v
    if v then
        RefreshAll()
    else
        HideAll()
    end
end)

-- Toggle: Team Check
MakeToggle(Content, 58, "Team Check", Settings.TeamCheck, function(v)
    Settings.TeamCheck = v
    RefreshAll()
end)

-- Slider: Fill Transparency
MakeSlider(Content, 108, "Fill Transparan", 0, 100,
    math.round(Settings.FillTransparency * 100),
    function(v)
        Settings.FillTransparency = v
    end
)

-- Slider: Outline Transparency
MakeSlider(Content, 173, "Outline Transparan", 0, 100,
    math.round(Settings.OutlineTransparency * 100),
    function(v)
        Settings.OutlineTransparency = v
    end
)

-- ═══════════════════════════════════════
--         CLOSE BUTTON
-- ═══════════════════════════════════════
CloseBtn.MouseButton1Click:Connect(function()
    Settings.Enabled = false
    HideAll()
    ScreenGui:Destroy()
end)

-- ═══════════════════════════════════════
--         HIDE MENU
-- ═══════════════════════════════════════

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Insert and not gameProcessed then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ═══════════════════════════════════════
--         INIT
-- ═══════════════════════════════════════
RefreshAll()
print("✅ ESP Highlight Script Loaded!")
