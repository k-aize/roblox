-- ╔══════════════════════════════════════════╗
-- ║        PET AUTO EQUIP/UNEQUIP MENU       ║
-- ║           by Script Generator            ║
-- ╚══════════════════════════════════════════╝

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack
local remote = ReplicatedStorage.GameEvents.PetsService

-- ══════════════════════════════════════════
--              STATE
-- ══════════════════════════════════════════
local State = {
    isRunning = false,
    selectedPets = {},       -- { [petName] = true }
    equippedPets = {},       -- { [petName] = uuid }
    equippedCount = 0,
    unequipDelay = 2,        -- seconds (hold duration)
    equipDelay = 0.5,        -- seconds (wait before next equip)
    thread = nil,
    petButtons = {},         -- { [petName] = frame }
    maxEquip = 4,
    searchQuery = "",
}

-- ══════════════════════════════════════════
--              HELPERS
-- ══════════════════════════════════════════

local function getPetUUID(petName)
    local item = Backpack:FindFirstChild(petName)
    if item then
        local attr = item:GetAttribute("PET_UUID")
        if attr then return tostring(attr) end
        for _, v in pairs(item:GetAttributes()) do
            if type(v) == "string" and v:match("^{%x+%-") then
                return v
            end
        end
    end
    return nil
end

local function getAllPets()
    local pets = {}
    for _, item in ipairs(Backpack:GetChildren()) do
        local itemType = item:GetAttribute("ItemType")
        local petType  = item:GetAttribute("PetType")
        if itemType == "Pet" or petType == "Pet" then
            table.insert(pets, item.Name)
        end
    end
    table.sort(pets)
    return pets
end

local function equipPet(petName)
    local uuid = getPetUUID(petName)
    if not uuid then return false end
    local ok = pcall(function()
        remote:FireServer("EquipPet", uuid, CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    end)
    if ok then
        State.equippedPets[petName] = uuid
        State.equippedCount = State.equippedCount + 1
    end
    return ok
end

local function unequipPet(petName)
    local uuid = State.equippedPets[petName] or getPetUUID(petName)
    if not uuid then return false end
    local ok = pcall(function()
        remote:FireServer("UnequipPet", uuid)
    end)
    if ok then
        State.equippedPets[petName] = nil
        State.equippedCount = math.max(0, State.equippedCount - 1)
    end
    return ok
end

local function unequipAll()
    for petName, _ in pairs(State.equippedPets) do
        unequipPet(petName)
        task.wait(0.1)
    end
    State.equippedPets = {}
    State.equippedCount = 0
end

-- ══════════════════════════════════════════
--              MAIN LOOP
-- ══════════════════════════════════════════

local function startLoop()
    if State.thread then
        task.cancel(State.thread)
        State.thread = nil
    end

    State.thread = task.spawn(function()
        while State.isRunning do
            -- Build list of selected pets
            local toEquip = {}
            for petName, selected in pairs(State.selectedPets) do
                if selected then
                    table.insert(toEquip, petName)
                end
            end

            if #toEquip == 0 then
                task.wait(1)
            else
                -- ── EQUIP SEMUA PET SEKALIGUS ──
                for _, petName in ipairs(toEquip) do
                    task.spawn(function()
                        local success = equipPet(petName)
                        if State.petButtons[petName] then
                            State.petButtons[petName].dot.BackgroundColor3 = success
                                and Color3.fromRGB(80, 255, 120)
                                or  Color3.fromRGB(50, 50, 70)
                        end
                    end)
                end

                -- ── TAHAN sesuai durasi (Delay Unequip) ──
                task.wait(State.unequipDelay)

                -- ── UNEQUIP SEMUA PET SEKALIGUS ──
                if State.isRunning then
                    for _, petName in ipairs(toEquip) do
                        task.spawn(function()
                            unequipPet(petName)
                            if State.petButtons[petName] then
                                State.petButtons[petName].dot.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                            end
                        end)
                    end
                end

                -- jeda sebelum siklus berikutnya (Delay Equip)
                task.wait(State.equipDelay)
            end
        end
    end)
end

-- ══════════════════════════════════════════
--              GUI
-- ══════════════════════════════════════════

local oldGui = LocalPlayer.PlayerGui:FindFirstChild("PetAutoEquipMenu")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PetAutoEquipMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer.PlayerGui

-- ── MAIN FRAME ──
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 340, 0, 490) -- Diperbesar untuk slider kedua
Main.Position = UDim2.new(0.5, -170, 0.5, -245)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Border = Instance.new("UIStroke", Main)
Border.Color = Color3.fromRGB(80, 200, 255)
Border.Thickness = 1.5
Border.Transparency = 0.4

-- ── TITLE BAR ──
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 10)
TitleFix.Position = UDim2.new(0, 0, 1, -10)
TitleFix.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🐾  PET AUTO EQUIP"
TitleLabel.TextColor3 = Color3.fromRGB(80, 200, 255)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -72, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.TextSize = 14
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- ── CONTENT ──
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -40)
Content.Position = UDim2.new(0, 0, 0, 40)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- ── SECTION LABEL: PETS ──
local PetSectionLabel = Instance.new("TextLabel")
PetSectionLabel.Size = UDim2.new(1, -20, 0, 20)
PetSectionLabel.Position = UDim2.new(0, 10, 0, 8)
PetSectionLabel.BackgroundTransparency = 1
PetSectionLabel.Text = "SELECT PETS  (click to toggle)"
PetSectionLabel.TextColor3 = Color3.fromRGB(80, 200, 255)
PetSectionLabel.TextSize = 11
PetSectionLabel.Font = Enum.Font.GothamBold
PetSectionLabel.TextXAlignment = Enum.TextXAlignment.Left
PetSectionLabel.Parent = Content

-- Refresh button
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0, 70, 0, 20)
RefreshBtn.Position = UDim2.new(1, -80, 0, 8)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(30, 100, 160)
RefreshBtn.Text = "🔁 Refresh"
RefreshBtn.TextColor3 = Color3.new(1, 1, 1)
RefreshBtn.TextSize = 11
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.BorderSizePixel = 0
RefreshBtn.Parent = Content
Instance.new("UICorner", RefreshBtn).CornerRadius = UDim.new(0, 5)

-- ── SEARCH BOX ──
local SearchContainer = Instance.new("Frame")
SearchContainer.Size = UDim2.new(1, -20, 0, 28)
SearchContainer.Position = UDim2.new(0, 10, 0, 32)
SearchContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
SearchContainer.BorderSizePixel = 0
SearchContainer.Parent = Content
Instance.new("UICorner", SearchContainer).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", SearchContainer).Color = Color3.fromRGB(50, 50, 75)

local SearchIcon = Instance.new("TextLabel")
SearchIcon.Size = UDim2.new(0, 24, 1, 0)
SearchIcon.Position = UDim2.new(0, 4, 0, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "🔍"
SearchIcon.TextSize = 13
SearchIcon.Font = Enum.Font.Gotham
SearchIcon.Parent = SearchContainer

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -36, 1, 0)
SearchBox.Position = UDim2.new(0, 28, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "Search pet..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 110)
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(220, 220, 240)
SearchBox.TextSize = 12
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = SearchContainer

-- Clear search button
local ClearSearchBtn = Instance.new("TextButton")
ClearSearchBtn.Size = UDim2.new(0, 20, 0, 20)
ClearSearchBtn.Position = UDim2.new(1, -24, 0.5, -10)
ClearSearchBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
ClearSearchBtn.Text = "✕"
ClearSearchBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
ClearSearchBtn.TextSize = 10
ClearSearchBtn.Font = Enum.Font.GothamBold
ClearSearchBtn.BorderSizePixel = 0
ClearSearchBtn.Visible = false
ClearSearchBtn.Parent = SearchContainer
Instance.new("UICorner", ClearSearchBtn).CornerRadius = UDim.new(1, 0)

-- ── PET LIST SCROLL ──
local PetListContainer = Instance.new("Frame")
PetListContainer.Size = UDim2.new(1, -20, 0, 178)
PetListContainer.Position = UDim2.new(0, 10, 0, 64)
PetListContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
PetListContainer.BorderSizePixel = 0
PetListContainer.ClipsDescendants = true
PetListContainer.Parent = Content
Instance.new("UICorner", PetListContainer).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", PetListContainer).Color = Color3.fromRGB(40, 40, 60)

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -6, 1, 0)
ScrollFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 200, 255)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent = PetListContainer

local ListLayout = Instance.new("UIListLayout", ScrollFrame)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 3)

local ListPadding = Instance.new("UIPadding", ScrollFrame)
ListPadding.PaddingLeft = UDim.new(0, 6)
ListPadding.PaddingRight = UDim.new(0, 6)
ListPadding.PaddingTop = UDim.new(0, 6)
ListPadding.PaddingBottom = UDim.new(0, 6)

local NoPetsLabel = Instance.new("TextLabel")
NoPetsLabel.Name = "NoPets"
NoPetsLabel.Size = UDim2.new(1, 0, 0, 40)
NoPetsLabel.BackgroundTransparency = 1
NoPetsLabel.Text = "No pets found in Backpack"
NoPetsLabel.TextColor3 = Color3.fromRGB(120, 120, 140)
NoPetsLabel.TextSize = 12
NoPetsLabel.Font = Enum.Font.Gotham
NoPetsLabel.Parent = ScrollFrame

-- ── SELECT ALL / DESELECT ALL ──
local SelectRow = Instance.new("Frame")
SelectRow.Size = UDim2.new(1, -20, 0, 26)
SelectRow.Position = UDim2.new(0, 10, 0, 247)
SelectRow.BackgroundTransparency = 1
SelectRow.Parent = Content

local SelectAllBtn = Instance.new("TextButton")
SelectAllBtn.Size = UDim2.new(0.48, 0, 1, 0)
SelectAllBtn.BackgroundColor3 = Color3.fromRGB(30, 90, 60)
SelectAllBtn.Text = "✔ Select All"
SelectAllBtn.TextColor3 = Color3.new(1, 1, 1)
SelectAllBtn.TextSize = 12
SelectAllBtn.Font = Enum.Font.GothamBold
SelectAllBtn.BorderSizePixel = 0
SelectAllBtn.Parent = SelectRow
Instance.new("UICorner", SelectAllBtn).CornerRadius = UDim.new(0, 6)

local DeselectAllBtn = Instance.new("TextButton")
DeselectAllBtn.Size = UDim2.new(0.48, 0, 1, 0)
DeselectAllBtn.Position = UDim2.new(0.52, 0, 0, 0)
DeselectAllBtn.BackgroundColor3 = Color3.fromRGB(90, 30, 30)
DeselectAllBtn.Text = "✖ Deselect All"
DeselectAllBtn.TextColor3 = Color3.new(1, 1, 1)
DeselectAllBtn.TextSize = 12
DeselectAllBtn.Font = Enum.Font.GothamBold
DeselectAllBtn.BorderSizePixel = 0
DeselectAllBtn.Parent = SelectRow
Instance.new("UICorner", DeselectAllBtn).CornerRadius = UDim.new(0, 6)

-- ── SETTINGS SECTION ──
local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Size = UDim2.new(1, -20, 0, 20)
SettingsLabel.Position = UDim2.new(0, 10, 0, 281)
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Text = "SETTINGS"
SettingsLabel.TextColor3 = Color3.fromRGB(80, 200, 255)
SettingsLabel.TextSize = 11
SettingsLabel.Font = Enum.Font.GothamBold
SettingsLabel.TextXAlignment = Enum.TextXAlignment.Left
SettingsLabel.Parent = Content

local function makeSliderRow(parent, yPos, labelText, defaultVal, minVal, maxVal, decimals, onChange)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -20, 0, 44)
    Row.Position = UDim2.new(0, 10, 0, yPos)
    Row.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
    Row.BorderSizePixel = 0
    Row.Parent = parent
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 7)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 4)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(180, 180, 210)
    Label.TextSize = 12
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local ValLabel = Instance.new("TextLabel")
    ValLabel.Size = UDim2.new(0.35, 0, 0, 20)
    ValLabel.Position = UDim2.new(0.65, 0, 0, 4)
    ValLabel.BackgroundTransparency = 1
    ValLabel.Text = string.format("%." .. decimals .. "f s", defaultVal)
    ValLabel.TextColor3 = Color3.fromRGB(80, 200, 255)
    ValLabel.TextSize = 12
    ValLabel.Font = Enum.Font.GothamBold
    ValLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValLabel.Parent = Row

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, -20, 0, 8)
    SliderBg.Position = UDim2.new(0, 10, 0, 28)
    SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = Row
    Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 4)

    local SliderFill = Instance.new("Frame")
    local initPct = (defaultVal - minVal) / (maxVal - minVal)
    SliderFill.Size = UDim2.new(initPct, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(80, 200, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBg
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 4)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new(initPct, -7, 0.5, -7)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 3
    Knob.Parent = SliderBg
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local dragging = false
    Knob.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or
           inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or
           inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or
                         inp.UserInputType == Enum.UserInputType.Touch) then
            local bgPos  = SliderBg.AbsolutePosition.X
            local bgSize = SliderBg.AbsoluteSize.X
            local relX   = math.clamp((inp.Position.X - bgPos) / bgSize, 0, 1)
            local value  = minVal + relX * (maxVal - minVal)
            local rounded = math.floor(value * (10^decimals) + 0.5) / (10^decimals)
            SliderFill.Size  = UDim2.new(relX, 0, 1, 0)
            Knob.Position    = UDim2.new(relX, -7, 0.5, -7)
            ValLabel.Text    = string.format("%." .. decimals .. "f s", rounded)
            onChange(rounded)
        end
    end)

    return Row
end

-- Slider 1: Hold Time (Delay Unequip)
makeSliderRow(Content, 303, "⏳ Hold Time (before unequip)", State.unequipDelay, 0.1, 30, 1,
    function(v) State.unequipDelay = v end)

-- Slider 2: Wait Time (Delay Equip)
makeSliderRow(Content, 349, "⏳ Wait Time (before equip)", State.equipDelay, 0.1, 30, 1,
    function(v) State.equipDelay = v end)

-- ── TOGGLE BUTTON ──
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(1, -20, 0, 42)
ToggleBtn.Position = UDim2.new(0, 10, 0, 400) -- Digeser ke bawah
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 160, 80)
ToggleBtn.Text = "▶  START AUTO EQUIP"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 15
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Content
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

-- ══════════════════════════════════════════
--         PET LIST BUILDER
-- ══════════════════════════════════════════

local function buildPetList()
    for _, child in ipairs(ScrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    if NoPetsLabel.Parent ~= ScrollFrame then
        NoPetsLabel.Parent = ScrollFrame
    end
    State.petButtons = {}

    local pets = getAllPets()

    -- Filter by search query
    local query = State.searchQuery:lower()
    if query ~= "" then
        local filtered = {}
        for _, name in ipairs(pets) do
            if name:lower():find(query, 1, true) then
                table.insert(filtered, name)
            end
        end
        pets = filtered
    end

    if #pets == 0 then
        NoPetsLabel.Visible = true
        NoPetsLabel.Text = (State.searchQuery ~= "") and "No pets match search" or "No pets found in Backpack"
        return
    end
    NoPetsLabel.Visible = false

    for i, petName in ipairs(pets) do
        local isSelected = State.selectedPets[petName] == true

        local Row = Instance.new("Frame")
        Row.Name = petName
        Row.Size = UDim2.new(1, 0, 0, 34)
        Row.BackgroundColor3 = isSelected
            and Color3.fromRGB(30, 80, 120)
            or  Color3.fromRGB(28, 28, 42)
        Row.BorderSizePixel = 0
        Row.LayoutOrder = i
        Row.Parent = ScrollFrame
        Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)

        local Checkbox = Instance.new("Frame")
        Checkbox.Size = UDim2.new(0, 18, 0, 18)
        Checkbox.Position = UDim2.new(0, 8, 0.5, -9)
        Checkbox.BackgroundColor3 = isSelected
            and Color3.fromRGB(80, 200, 255)
            or  Color3.fromRGB(50, 50, 70)
        Checkbox.BorderSizePixel = 0
        Checkbox.Parent = Row
        Instance.new("UICorner", Checkbox).CornerRadius = UDim.new(0, 4)

        local CheckMark = Instance.new("TextLabel")
        CheckMark.Size = UDim2.new(1, 0, 1, 0)
        CheckMark.BackgroundTransparency = 1
        CheckMark.Text = isSelected and "✓" or ""
        CheckMark.TextColor3 = Color3.fromRGB(15, 15, 22)
        CheckMark.TextSize = 13
        CheckMark.Font = Enum.Font.GothamBold
        CheckMark.Parent = Checkbox

        local PetIcon = Instance.new("TextLabel")
        PetIcon.Size = UDim2.new(0, 22, 1, 0)
        PetIcon.Position = UDim2.new(0, 32, 0, 0)
        PetIcon.BackgroundTransparency = 1
        PetIcon.Text = "🐾"
        PetIcon.TextSize = 14
        PetIcon.Font = Enum.Font.Gotham
        PetIcon.Parent = Row

        local PetNameLabel = Instance.new("TextLabel")
        PetNameLabel.Size = UDim2.new(1, -80, 1, 0)
        PetNameLabel.Position = UDim2.new(0, 56, 0, 0)
        PetNameLabel.BackgroundTransparency = 1
        PetNameLabel.Text = petName
        PetNameLabel.TextColor3 = isSelected
            and Color3.fromRGB(255, 255, 255)
            or  Color3.fromRGB(180, 180, 200)
        PetNameLabel.TextSize = 12
        PetNameLabel.Font = Enum.Font.Gotham
        PetNameLabel.TextXAlignment = Enum.TextXAlignment.Left
        PetNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
        PetNameLabel.Parent = Row

        local EquippedDot = Instance.new("Frame")
        EquippedDot.Size = UDim2.new(0, 8, 0, 8)
        EquippedDot.Position = UDim2.new(1, -14, 0.5, -4)
        EquippedDot.BackgroundColor3 = State.equippedPets[petName]
            and Color3.fromRGB(80, 255, 120)
            or  Color3.fromRGB(50, 50, 70)
        EquippedDot.BorderSizePixel = 0
        EquippedDot.Parent = Row
        Instance.new("UICorner", EquippedDot).CornerRadius = UDim.new(1, 0)

        State.petButtons[petName] = {
            row      = Row,
            checkbox = Checkbox,
            check    = CheckMark,
            nameL    = PetNameLabel,
            dot      = EquippedDot,
        }

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 1, 0)
        Btn.BackgroundTransparency = 1
        Btn.Text = ""
        Btn.ZIndex = 5
        Btn.Parent = Row

        Btn.MouseButton1Click:Connect(function()
            State.selectedPets[petName] = not State.selectedPets[petName]
            local sel = State.selectedPets[petName]
            Row.BackgroundColor3 = sel
                and Color3.fromRGB(30, 80, 120)
                or  Color3.fromRGB(28, 28, 42)
            Checkbox.BackgroundColor3 = sel
                and Color3.fromRGB(80, 200, 255)
                or  Color3.fromRGB(50, 50, 70)
            CheckMark.Text = sel and "✓" or ""
            PetNameLabel.TextColor3 = sel
                and Color3.fromRGB(255, 255, 255)
                or  Color3.fromRGB(180, 180, 200)
        end)
    end
end

-- ══════════════════════════════════════════
--         SEARCH LOGIC
-- ══════════════════════════════════════════

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    State.searchQuery = SearchBox.Text
    ClearSearchBtn.Visible = SearchBox.Text ~= ""
    buildPetList()
end)

ClearSearchBtn.MouseButton1Click:Connect(function()
    SearchBox.Text = ""
    State.searchQuery = ""
    ClearSearchBtn.Visible = false
    buildPetList()
end)

-- ══════════════════════════════════════════
--         BUTTON LOGIC
-- ══════════════════════════════════════════

RefreshBtn.MouseButton1Click:Connect(function()
    buildPetList()
end)

SelectAllBtn.MouseButton1Click:Connect(function()
    -- Select all currently visible pets (respects search filter)
    for petName, _ in pairs(State.petButtons) do
        State.selectedPets[petName] = true
        local b = State.petButtons[petName]
        b.row.BackgroundColor3      = Color3.fromRGB(30, 80, 120)
        b.checkbox.BackgroundColor3 = Color3.fromRGB(80, 200, 255)
        b.check.Text                = "✓"
        b.nameL.TextColor3          = Color3.fromRGB(255, 255, 255)
    end
end)

DeselectAllBtn.MouseButton1Click:Connect(function()
    for petName, _ in pairs(State.petButtons) do
        State.selectedPets[petName] = false
        local b = State.petButtons[petName]
        b.row.BackgroundColor3      = Color3.fromRGB(28, 28, 42)
        b.checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        b.check.Text                = ""
        b.nameL.TextColor3          = Color3.fromRGB(180, 180, 200)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    State.isRunning = not State.isRunning
    if State.isRunning then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(160, 50, 50)
        ToggleBtn.Text = "⏹  STOP AUTO EQUIP"
        startLoop()
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 160, 80)
        ToggleBtn.Text = "▶  START AUTO EQUIP"
        if State.thread then
            task.cancel(State.thread)
            State.thread = nil
        end
        unequipAll()
        for _, b in pairs(State.petButtons) do
            b.dot.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        end
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    State.isRunning = false
    if State.thread then task.cancel(State.thread) end
    unequipAll()
    ScreenGui:Destroy()
end)

-- ── MINIMIZE ──
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(Main,
        TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        { Size = minimized and UDim2.new(0, 340, 0, 40) or UDim2.new(0, 340, 0, 490) }
    ):Play()
    MinBtn.Text = minimized and "□" or "—"
end)

-- ── DRAG ──
local dragging = false
local dragStart, startPos
TitleBar.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or
       inp.UserInputType == Enum.UserInputType.Touch then
        dragging  = true
        dragStart = inp.Position
        startPos  = Main.Position
    end
end)
TitleBar.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or
       inp.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or
                     inp.UserInputType == Enum.UserInputType.Touch) then
        local delta = inp.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ── INITIAL BUILD ──
buildPetList()

print("[PetAutoEquip] Script loaded successfully!")
