--// SETTINGS
local SHOW_TEAM = false -- false = tidak tampilkan tim sendiri
local OUTLINE_COLOR = Color3.fromRGB(255, 0, 0)
local NAME_COLOR = Color3.fromRGB(255, 255, 255)

--// SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// FUNCTION ESP
local function createESP(player)
    if player == LocalPlayer then return end

    local function onCharacterAdded(character)
        if SHOW_TEAM == false and player.Team == LocalPlayer.Team then
            return
        end

        -- Highlight (Outline ESP)
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillTransparency = 1
        highlight.OutlineColor = OUTLINE_COLOR
        highlight.OutlineTransparency = 0
        highlight.Parent = character

        -- Name ESP
        local head = character:WaitForChild("Head", 5)
        if not head then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Name"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head

        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = player.Name
        text.TextColor3 = NAME_COLOR
        text.TextStrokeTransparency = 0
        text.TextScaled = true
        text.Font = Enum.Font.SourceSansBold
        text.Parent = billboard
    end

    if player.Character then
        onCharacterAdded(player.Character)
    end

    player.CharacterAdded:Connect(onCharacterAdded)
end

--// PLAYER LOOP
for _, player in ipairs(Players:GetPlayers()) do
    createESP(player)
end

Players.PlayerAdded:Connect(createESP)
