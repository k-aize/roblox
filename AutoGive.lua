local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local remote = ReplicatedStorage.GameEvents.PetGiftingService

-- ========== CONFIG ==========
local PET_LIST = {
    "[Common Egg] Golden Lab", "[Common Egg] Dog", "[Common Egg] Bunny",
    "[Uncommon Egg] Black Bunny", "[Uncommon Egg] Chicken", "[Uncommon Egg] Cat", "[Uncommon Egg] Deer",
    "[Rare Egg] Orange Tabby", "[Rare Egg] Spotted Deer", "[Rare Egg] Pig", "[Rare Egg] Rooster", "[Rare Egg] Monkey",
    "[Legendary Egg] Cow", "[Legendary Egg] Silver Monkey", "[Legendary Egg] Sea Otter", "[Legendary Egg] Turtle", "[Legendary Egg] Polar Bear",
    "[Mythical Egg] Grey Mouse", "[Mythical Egg] Brown Mouse", "[Mythical Egg] Squirrel", "[Mythical Egg] Red Giant Ant", "[Mythical Egg] Red Fox",
    "[Bug Egg] Caterpillar", "[Bug Egg] Snail", "[Bug Egg] Giant Ant", "[Bug Egg] Praying Mantis", "[Bug Egg] Dragonfly",
    "[Jungle Egg] Tree Frog", "[Jungle Egg] Hummingbird", "[Jungle Egg] Iguana", "[Jungle Egg] Chimpanzee", "[Jungle Egg] Tiger",
    "[Night Egg] Hedgehog", "[Night Egg] Mole", "[Night Egg] Frog", "[Night Egg] Echo Frog", "[Night Egg] Night Owl", "[Night Egg] Raccoon",
    "[Bee Egg] Bee", "[Bee Egg] Honey Bee", "[Bee Egg] Bear Bee", "[Bee Egg] Petal Bee", "[Bee Egg] Queen Bee (Pet)",
    "[Anti Bee Egg] Wasp", "[Anti Bee Egg] Tarantula Hawk", "[Anti Bee Egg] Moth", "[Anti Bee Egg] Butterfly", "[Anti Bee Egg] Disco Bee",
    "[Common Summer Egg] Starfish", "[Common Summer Egg] Seagull", "[Common Summer Egg] Crab",
    "[Rare Summer Egg] Flamingo", "[Rare Summer Egg] Toucan", "[Rare Summer Egg] Sea Turtle", "[Rare Summer Egg] Orangutan", "[Rare Summer Egg] Seal",
    "[Paradise Egg] Ostrich", "[Paradise Egg] Peacock", "[Paradise Egg] Capybara", "[Paradise Egg] Scarlet Macaw", "[Paradise Egg] Mimic Octopus",
    "[Oasis Egg] Meerkat", "[Oasis Egg] Sand Snake", "[Oasis Egg] Axolotl", "[Oasis Egg] Hyacinth Macaw", "[Oasis Egg] Fennec Fox",
    "[Dinosaur Egg] Raptor", "[Dinosaur Egg] Triceratops", "[Dinosaur Egg] Stegosaurus", "[Dinosaur Egg] Pterodactyl", "[Dinosaur Egg] Brontosaurus", "[Dinosaur Egg] T-Rex",
    "[Primal Egg] Parasaurolophus", "[Primal Egg] Iguanodon", "[Primal Egg] Pachycephalosaurus", "[Primal Egg] Dilophosaurus", "[Primal Egg] Ankylosaurus", "[Primal Egg] Spinosaurus",
    "[Zen Egg] Shiba Inu", "[Zen Egg] Nihonzaru", "[Zen Egg] Tanuki", "[Zen Egg] Tanchozuru", "[Zen Egg] Kappa", "[Zen Egg] Kitsune",
    "[Corrupted Zen Egg] Maneki-neko", "[Corrupted Zen Egg] Tsuchinoko", "[Corrupted Zen Egg] Kodama", "[Corrupted Zen Egg] Raiju", "[Corrupted Zen Egg] Mizuchi", "[Corrupted Zen Egg] Corrupted Kitsune",
    "[Gourmet Egg] Bagel Bunny", "[Gourmet Egg] Pancake Mole", "[Gourmet Egg] Sushi Bear", "[Gourmet Egg] Spaghetti Sloth", "[Gourmet Egg] French Fry Ferret",
    "[Sprout Egg] Dairy Cow", "[Sprout Egg] Jackalope", "[Sprout Egg] Seedling", "[Sprout Egg] Golem", "[Sprout Egg] Golden Goose",
    "[Enchanted Egg] Ladybug", "[Enchanted Egg] Pixie", "[Enchanted Egg] Imp", "[Enchanted Egg] Glimmering Sprite", "[Enchanted Egg] Cockatrice",
    "[Fall Egg] Robin", "[Fall Egg] Badger", "[Fall Egg] Grizzly Bear", "[Fall Egg] Barn Owl", "[Fall Egg] Swan",
    "[Spooky Egg] Bat", "[Spooky Egg] Bone Dog", "[Spooky Egg] Spider", "[Spooky Egg] Black Cat", "[Spooky Egg] Headless Horseman",
    "[Safari Egg] Oxpecker", "[Safari Egg] Zebra", "[Safari Egg] Giraffe", "[Safari Egg] Rhino", "[Safari Egg] Elephant",
    "[Gem Egg] Topaz Snail", "[Gem Egg] Amethyst Beetle", "[Gem Egg] Emerald Snake", "[Gem Egg] Sapphire Macaw", "[Gem Egg] Diamond Panther", "[Gem Egg] Ruby Squid",
    "[Lich Crystal Egg] Lich",
    "[Christmas Egg] Turtle Dove", "[Christmas Egg] Reindeer", "[Christmas Egg] Nutcracker", "[Christmas Egg] Yeti", "[Christmas Egg] Ice Golem",
    "[Winter Egg] Partridge", "[Winter Egg] Santa Bear", "[Winter Egg] Moose", "[Winter Egg] Frost Squirrel", "[Winter Egg] Wendigo",
    "[New Year's Egg] New Year's Bird", "[New Year's Egg] Firework Sprite", "[New Year's Egg] Celebration Puppy", "[New Year's Egg] New Year's Chimp", "[New Year's Egg] Star Wolf", "[New Year's Egg] New Year's Dragon",
    "[Carnival Egg] Unicycle Monkey", "[Carnival Egg] Performer Seal", "[Carnival Egg] Bear on Bike", "[Carnival Egg] Show Pony", "[Carnival Egg] Carnival Elephant",
    "[Bird Egg] Black Bird", "[Bird Egg] Cuckoo", "[Bird Egg] Brown Owl", "[Bird Egg] Gold Finch", "[Bird Egg] Birb",
    "[Golden Egg] Chocolate Bunny", "[Golden Egg] Easter Egg Chick", "[Golden Egg] Marshmallow Lamb", "[Golden Egg] Easter Bunny",
    "[Gilded Choc Golden Egg] Gilded Choc Chocolate Bunny", "[Gilded Choc Golden Egg] Gilded Choc Easter Egg Chick", "[Gilded Choc Golden Egg] Gilded Choc Marshmallow Lamb", "[Gilded Choc Golden Egg] Gilded Choc Easter Bunny",
    "[Springtide Egg] Spring Bee", "[Springtide Egg] Jerboa", "[Springtide Egg] Nyala", "[Springtide Egg] Peryton",
    "[Gilded Choc Springtide Egg] Gilded Choc Spring Bee", "[Gilded Choc Springtide Egg] Gilded Choc Jerboa", "[Gilded Choc Springtide Egg] Gilded Choc Nyala", "[Gilded Choc Springtide Egg] Gilded Choc Peryton"
}

-- ========== STATE ==========
local selectedPets = {}
local selectedPlayer = nil
local thresholdMode = "above"
local weightThreshold = 0
local ageThreshold = 0
local autoGiveEnabled = false
local autoGiveThread = nil

local autoAcceptEnabled = false
local autoAcceptThread = nil

-- ========== GUI (MOBILE OPTIMIZED) ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoGivePetGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game:GetService("CoreGui")

-- Toggle Button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 90, 0, 28)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -14)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "🐾 Menu"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 12
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleBtn

-- Main Frame (Smaller Size)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 260, 0, 320)
mainFrame.Position = UDim2.new(0, 110, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 34)
titleBar.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 8)
titleBarCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -34, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🐾 Auto Give Pet"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 4)
closeBtnCorner.Parent = closeBtn

-- Scrollable Content
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -34)
scrollFrame.Position = UDim2.new(0, 0, 0, 34)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 3
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 160)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

local listPadding = Instance.new("UIPadding")
listPadding.PaddingLeft = UDim.new(0, 8)
listPadding.PaddingRight = UDim.new(0, 8)
listPadding.PaddingTop = UDim.new(0, 8)
listPadding.PaddingBottom = UDim.new(0, 8)
listPadding.Parent = scrollFrame

-- Helper: Create section label
local function sectionLabel(text, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(160, 160, 200)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = order
    lbl.Parent = scrollFrame
    return lbl
end

-- Helper: Create styled container
local function createContainer(order, height)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
    frame.BorderSizePixel = 0
    frame.LayoutOrder = order
    frame.Parent = scrollFrame
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = frame
    return frame
end

-- ========== SECTION: SELECT PETS ==========
sectionLabel("SELECT PETS", 1)

local petMainContainer = createContainer(2, 34)

local petDropdownBtn = Instance.new("TextButton")
petDropdownBtn.Size = UDim2.new(1, -16, 0, 26)
petDropdownBtn.Position = UDim2.new(0, 8, 0, 4)
petDropdownBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
petDropdownBtn.BorderSizePixel = 0
petDropdownBtn.Text = "▼  Select Pets"
petDropdownBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
petDropdownBtn.TextSize = 11
petDropdownBtn.Font = Enum.Font.Gotham
petDropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
petDropdownBtn.Parent = petMainContainer

local petDpCorner = Instance.new("UICorner")
petDpCorner.CornerRadius = UDim.new(0, 4)
petDpCorner.Parent = petDropdownBtn

local petDpPadding = Instance.new("UIPadding")
petDpPadding.PaddingLeft = UDim.new(0, 8)
petDpPadding.Parent = petDropdownBtn

local petDropContent = Instance.new("Frame")
petDropContent.Name = "PetDropContent"
petDropContent.Size = UDim2.new(1, -16, 0, 150)
petDropContent.Position = UDim2.new(0, 8, 0, 34)
petDropContent.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
petDropContent.BorderSizePixel = 0
petDropContent.ClipsDescendants = true
petDropContent.Visible = false
petDropContent.Parent = petMainContainer

local petDropCorner = Instance.new("UICorner")
petDropCorner.CornerRadius = UDim.new(0, 4)
petDropCorner.Parent = petDropContent

local petSearchBox = Instance.new("TextBox")
petSearchBox.Size = UDim2.new(1, -8, 0, 24)
petSearchBox.Position = UDim2.new(0, 4, 0, 4)
petSearchBox.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
petSearchBox.BorderSizePixel = 0
petSearchBox.Text = ""
petSearchBox.PlaceholderText = "🔍 Search..."
petSearchBox.TextColor3 = Color3.fromRGB(220, 220, 240)
petSearchBox.TextSize = 11
petSearchBox.Font = Enum.Font.Gotham
petSearchBox.Parent = petDropContent

local petSearchCorner = Instance.new("UICorner")
petSearchCorner.CornerRadius = UDim.new(0, 4)
petSearchCorner.Parent = petSearchBox

local petScrollFrame = Instance.new("ScrollingFrame")
petScrollFrame.Size = UDim2.new(1, -8, 1, -34)
petScrollFrame.Position = UDim2.new(0, 4, 0, 32)
petScrollFrame.BackgroundTransparency = 1
petScrollFrame.BorderSizePixel = 0
petScrollFrame.ScrollBarThickness = 3
petScrollFrame.Parent = petDropContent

local petListLayout2 = Instance.new("UIListLayout")
petListLayout2.FillDirection = Enum.FillDirection.Vertical
petListLayout2.Padding = UDim.new(0, 3)
petListLayout2.Parent = petScrollFrame

local petCheckboxes = {}

for i, petName in ipairs(PET_LIST) do
    local petBtn = Instance.new("TextButton")
    petBtn.Size = UDim2.new(1, -6, 0, 26)
    petBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    petBtn.BorderSizePixel = 0
    petBtn.Parent = petScrollFrame

    local checkIcon = Instance.new("TextLabel")
    checkIcon.Size = UDim2.new(0, 16, 0, 16)
    checkIcon.Position = UDim2.new(0, 6, 0.5, -8)
    checkIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    checkIcon.Text = ""
    checkIcon.TextColor3 = Color3.fromRGB(100, 200, 100)
    checkIcon.TextSize = 11
    checkIcon.Parent = petBtn
    local checkCorner = Instance.new("UICorner") checkCorner.CornerRadius = UDim.new(0, 3) checkCorner.Parent = checkIcon

    local petLabel = Instance.new("TextLabel")
    petLabel.Size = UDim2.new(1, -30, 1, 0)
    petLabel.Position = UDim2.new(0, 28, 0, 0)
    petLabel.BackgroundTransparency = 1
    petLabel.Text = petName
    petLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
    petLabel.TextSize = 10
    petLabel.Font = Enum.Font.Gotham
    petLabel.TextXAlignment = Enum.TextXAlignment.Left
    petLabel.TextTruncate = Enum.TextTruncate.AtEnd
    petLabel.Parent = petBtn

    petCheckboxes[petName] = {btn = petBtn, icon = checkIcon, name = string.lower(petName)}

    petBtn.MouseButton1Click:Connect(function()
        if selectedPets[petName] then
            selectedPets[petName] = false
            checkIcon.Text = ""
            checkIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        else
            selectedPets[petName] = true
            checkIcon.Text = "✓"
            checkIcon.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
        end
    end)
end

petListLayout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    petScrollFrame.CanvasSize = UDim2.new(0, 0, 0, petListLayout2.AbsoluteContentSize.Y + 10)
end)

petSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(petSearchBox.Text)
    for _, data in pairs(petCheckboxes) do
        data.btn.Visible = (query == "" or string.find(data.name, query, 1, true) ~= nil)
    end
end)

local petDropOpen = false
petDropdownBtn.MouseButton1Click:Connect(function()
    petDropOpen = not petDropOpen
    petDropContent.Visible = petDropOpen
    if petDropOpen then
        petMainContainer.Size = UDim2.new(1, 0, 0, 190)
        petDropdownBtn.Text = "▲  Close Pet Selection"
    else
        petMainContainer.Size = UDim2.new(1, 0, 0, 34)
        petDropdownBtn.Text = "▼  Select Pets"
    end
end)

-- ========== SECTION: SELECT PLAYER ==========
sectionLabel("SELECT PLAYER", 3)
local playerContainer = createContainer(4, 34)

local playerDropdownBtn = Instance.new("TextButton")
playerDropdownBtn.Size = UDim2.new(1, -16, 0, 26)
playerDropdownBtn.Position = UDim2.new(0, 8, 0, 4)
playerDropdownBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
playerDropdownBtn.BorderSizePixel = 0
playerDropdownBtn.Text = "▼  Select Options"
playerDropdownBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
playerDropdownBtn.TextSize = 11
playerDropdownBtn.Font = Enum.Font.Gotham
playerDropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
playerDropdownBtn.Parent = playerContainer

local dpPadding = Instance.new("UIPadding")
dpPadding.PaddingLeft = UDim.new(0, 8)
dpPadding.Parent = playerDropdownBtn

local playerDropList = Instance.new("Frame")
playerDropList.Size = UDim2.new(1, -16, 0, 0)
playerDropList.Position = UDim2.new(0, 8, 0, 34)
playerDropList.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
playerDropList.BorderSizePixel = 0
playerDropList.ClipsDescendants = true
playerDropList.ZIndex = 10
playerDropList.Visible = false
playerDropList.Parent = playerContainer

local dpListLayout = Instance.new("UIListLayout")
dpListLayout.FillDirection = Enum.FillDirection.Vertical
dpListLayout.Padding = UDim.new(0, 2)
dpListLayout.Parent = playerDropList

local playerDropOpen = false

local function buildPlayerDropdown()
    for _, child in ipairs(playerDropList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local otherPlayers = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(otherPlayers, p.Name) end
    end

    if #otherPlayers == 0 then
        local noPlayers = Instance.new("TextLabel")
        noPlayers.Size = UDim2.new(1, 0, 0, 26)
        noPlayers.BackgroundTransparency = 1
        noPlayers.Text = "No other players found"
        noPlayers.TextColor3 = Color3.fromRGB(120, 120, 140)
        noPlayers.TextSize = 11
        noPlayers.Parent = playerDropList
        playerDropList.Size = UDim2.new(1, -16, 0, 26)
        return
    end

    playerDropList.Size = UDim2.new(1, -16, 0, (#otherPlayers * 28))

    for _, pName in ipairs(otherPlayers) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(1, 0, 0, 26)
        pBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
        pBtn.BorderSizePixel = 0
        pBtn.Text = "  👤 " .. pName
        pBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
        pBtn.TextSize = 11
        pBtn.TextXAlignment = Enum.TextXAlignment.Left
        pBtn.ZIndex = 11
        pBtn.Parent = playerDropList

        pBtn.MouseButton1Click:Connect(function()
            selectedPlayer = pName
            playerDropdownBtn.Text = "▼  " .. pName
            playerDropList.Visible = false
            playerDropOpen = false
            playerContainer.Size = UDim2.new(1, 0, 0, 34)
        end)
    end
end

playerDropdownBtn.MouseButton1Click:Connect(function()
    playerDropOpen = not playerDropOpen
    if playerDropOpen then
        buildPlayerDropdown()
        playerDropList.Visible = true
        playerContainer.Size = UDim2.new(1, 0, 0, 34 + playerDropList.Size.Y.Offset + 4)
    else
        playerDropList.Visible = false
        playerContainer.Size = UDim2.new(1, 0, 0, 34)
    end
end)

local refreshContainer = createContainer(6, 34)
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, 0, 1, 0)
refreshBtn.BackgroundTransparency = 1
refreshBtn.Text = "↻ Refresh Select Players"
refreshBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
refreshBtn.TextSize = 11
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.Parent = refreshContainer

refreshBtn.MouseButton1Click:Connect(function()
    if selectedPlayer and not Players:FindFirstChild(selectedPlayer) then
        selectedPlayer = nil
        playerDropdownBtn.Text = "▼  Select Options"
    end
end)

-- ========== SECTION: THRESHOLD FILTER ==========
sectionLabel("THRESHOLD FILTER", 7)

local thresholdModeContainer = createContainer(8, 34)
local thresholdModeLabel = Instance.new("TextLabel")
thresholdModeLabel.Size = UDim2.new(0.5, -8, 1, 0)
thresholdModeLabel.Position = UDim2.new(0, 8, 0, 0)
thresholdModeLabel.BackgroundTransparency = 1
thresholdModeLabel.Text = "Mode:"
thresholdModeLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
thresholdModeLabel.TextSize = 11
thresholdModeLabel.Font = Enum.Font.Gotham
thresholdModeLabel.TextXAlignment = Enum.TextXAlignment.Left
thresholdModeLabel.Parent = thresholdModeContainer

local modeToggleFrame = Instance.new("Frame")
modeToggleFrame.Size = UDim2.new(0, 110, 0, 24)
modeToggleFrame.Position = UDim2.new(1, -118, 0.5, -12)
modeToggleFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
modeToggleFrame.BorderSizePixel = 0
modeToggleFrame.Parent = thresholdModeContainer

local aboveBtn = Instance.new("TextButton")
aboveBtn.Size = UDim2.new(0.5, 0, 1, 0)
aboveBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
aboveBtn.BorderSizePixel = 0
aboveBtn.Text = "Above"
aboveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aboveBtn.TextSize = 10
aboveBtn.Font = Enum.Font.GothamBold
aboveBtn.Parent = modeToggleFrame

local belowBtn = Instance.new("TextButton")
belowBtn.Size = UDim2.new(0.5, 0, 1, 0)
belowBtn.Position = UDim2.new(0.5, 0, 0, 0)
belowBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
belowBtn.BorderSizePixel = 0
belowBtn.Text = "Below"
belowBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
belowBtn.TextSize = 10
belowBtn.Font = Enum.Font.Gotham
belowBtn.Parent = modeToggleFrame

aboveBtn.MouseButton1Click:Connect(function()
    thresholdMode = "above"
    aboveBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
    aboveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    belowBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    belowBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
end)
belowBtn.MouseButton1Click:Connect(function()
    thresholdMode = "below"
    belowBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
    belowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    aboveBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    aboveBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
end)

local weightContainer = createContainer(9, 34)
local weightLabel = Instance.new("TextLabel")
weightLabel.Size = UDim2.new(0.6, 0, 1, 0)
weightLabel.Position = UDim2.new(0, 8, 0, 0)
weightLabel.BackgroundTransparency = 1
weightLabel.Text = "⚖ Weight (KG)"
weightLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
weightLabel.TextSize = 11
weightLabel.Font = Enum.Font.Gotham
weightLabel.TextXAlignment = Enum.TextXAlignment.Left
weightLabel.Parent = weightContainer

local weightInput = Instance.new("TextBox")
weightInput.Size = UDim2.new(0, 60, 0, 24)
weightInput.Position = UDim2.new(1, -68, 0.5, -12)
weightInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
weightInput.BorderSizePixel = 0
weightInput.Text = "0"
weightInput.TextColor3 = Color3.fromRGB(220, 220, 240)
weightInput.TextSize = 11
weightInput.Font = Enum.Font.GothamBold
weightInput.Parent = weightContainer

weightInput:GetPropertyChangedSignal("Text"):Connect(function()
    weightThreshold = tonumber(weightInput.Text) or 0
end)

-- ========== CORE ACTIONS ==========
sectionLabel("ACTIONS", 11)

local startStopContainer = createContainer(12, 34)
local startStopBtn = Instance.new("TextButton")
startStopBtn.Size = UDim2.new(1, -16, 0, 26)
startStopBtn.Position = UDim2.new(0, 8, 0, 4)
startStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
startStopBtn.BorderSizePixel = 0
startStopBtn.Text = "▶ Start Auto Give"
startStopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startStopBtn.TextSize = 12
startStopBtn.Font = Enum.Font.GothamBold
startStopBtn.Parent = startStopContainer
local startCorner = Instance.new("UICorner") startCorner.CornerRadius = UDim.new(0, 4) startCorner.Parent = startStopBtn

local acceptStartStopContainer = createContainer(13, 34)
local acceptStartStopBtn = Instance.new("TextButton")
acceptStartStopBtn.Size = UDim2.new(1, -16, 0, 26)
acceptStartStopBtn.Position = UDim2.new(0, 8, 0, 4)
acceptStartStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
acceptStartStopBtn.BorderSizePixel = 0
acceptStartStopBtn.Text = "▶ Start Auto Accept"
acceptStartStopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
acceptStartStopBtn.TextSize = 12
acceptStartStopBtn.Font = Enum.Font.GothamBold
acceptStartStopBtn.Parent = acceptStartStopContainer
local accCorner = Instance.new("UICorner") accCorner.CornerRadius = UDim.new(0, 4) accCorner.Parent = acceptStartStopBtn

-- ========== SECTION: DETECT PET IN BACKPACK ==========
sectionLabel("DETECT PET IN BACKPACK", 14)

local detectRangeContainer = createContainer(15, 34)

local detectMinInput = Instance.new("TextBox")
detectMinInput.Size = UDim2.new(0, 50, 0, 24)
detectMinInput.Position = UDim2.new(0, 8, 0.5, -12)
detectMinInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
detectMinInput.BorderSizePixel = 0
detectMinInput.Text = "0.1"
detectMinInput.TextColor3 = Color3.fromRGB(220, 220, 240)
detectMinInput.TextSize = 11
detectMinInput.Font = Enum.Font.Gotham
detectMinInput.Parent = detectRangeContainer
local minUIC = Instance.new("UICorner") minUIC.CornerRadius = UDim.new(0, 4) minUIC.Parent = detectMinInput

local dashLabel = Instance.new("TextLabel")
dashLabel.Size = UDim2.new(0, 16, 0, 24)
dashLabel.Position = UDim2.new(0, 60, 0.5, -12)
dashLabel.BackgroundTransparency = 1
dashLabel.Text = "-"
dashLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
dashLabel.Parent = detectRangeContainer

local detectMaxInput = Instance.new("TextBox")
detectMaxInput.Size = UDim2.new(0, 50, 0, 24)
detectMaxInput.Position = UDim2.new(0, 78, 0.5, -12)
detectMaxInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
detectMaxInput.BorderSizePixel = 0
detectMaxInput.Text = "1.99"
detectMaxInput.TextColor3 = Color3.fromRGB(220, 220, 240)
detectMaxInput.TextSize = 11
detectMaxInput.Font = Enum.Font.Gotham
detectMaxInput.Parent = detectRangeContainer
local maxUIC = Instance.new("UICorner") maxUIC.CornerRadius = UDim.new(0, 4) maxUIC.Parent = detectMaxInput

local detectScanBtn = Instance.new("TextButton")
detectScanBtn.Size = UDim2.new(0, 60, 0, 24)
detectScanBtn.Position = UDim2.new(1, -68, 0.5, -12)
detectScanBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
detectScanBtn.BorderSizePixel = 0
detectScanBtn.Text = "Scan"
detectScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
detectScanBtn.TextSize = 11
detectScanBtn.Font = Enum.Font.GothamBold
detectScanBtn.Parent = detectRangeContainer
local scanUIC = Instance.new("UICorner") scanUIC.CornerRadius = UDim.new(0, 4) scanUIC.Parent = detectScanBtn

local detectResultContainer = createContainer(16, 34)
local detectResultLabel = Instance.new("TextLabel")
detectResultLabel.Size = UDim2.new(1, -16, 1, -10)
detectResultLabel.Position = UDim2.new(0, 8, 0, 5)
detectResultLabel.BackgroundTransparency = 1
detectResultLabel.Text = "Result will appear here..."
detectResultLabel.TextColor3 = Color3.fromRGB(160, 220, 160)
detectResultLabel.TextSize = 11
detectResultLabel.Font = Enum.Font.Gotham
detectResultLabel.TextXAlignment = Enum.TextXAlignment.Left
detectResultLabel.TextYAlignment = Enum.TextYAlignment.Top
detectResultLabel.TextWrapped = true
detectResultLabel.Parent = detectResultContainer


-- ========== LOGIC HELPER ==========
local function getBasePetName(petListEntry)
    return petListEntry:match("%]%s*(.+)$") or petListEntry
end

local function parsePetName(item)
    local fullName = item.Name
    local weight = tonumber(fullName:match("%[([%d%.]+)%s*KG%]"))
    local age = tonumber(fullName:match("%[Age%s*(%d+)%]"))
    local baseName = item:GetAttribute("f")
    if not baseName then
        baseName = fullName:match("^(.-)%s*%[") or fullName
        baseName = baseName:match("^%s*(.-)%s*$")
    end
    return baseName, weight or 0, age or 0
end

local function passesThreshold(weight, age)
    local wThresh = weightThreshold
    if thresholdMode == "above" then
        if wThresh > 0 and weight <= wThresh then return false end
    else
        if wThresh > 0 and weight >= wThresh then return false end
    end
    return true
end

-- ========== LOGIC: DETECT PET ==========
detectScanBtn.MouseButton1Click:Connect(function()
    local minStr = detectMinInput.Text
    local maxStr = detectMaxInput.Text
    local minVal = tonumber(minStr) or 0
    local maxVal = tonumber(maxStr) or 0
    
    local selectedBasePetNames = {}
    for petEntry, isSelected in pairs(selectedPets) do
        if isSelected then
            local baseName = getBasePetName(petEntry)
            selectedBasePetNames[baseName] = true
        end
    end

    if next(selectedBasePetNames) == nil then
        detectResultLabel.Text = "Please select a pet from the list first!"
        detectResultLabel.TextColor3 = Color3.fromRGB(220, 80, 80)
        detectResultContainer.Size = UDim2.new(1, 0, 0, 34)
        return
    end

    local counts = {}
    local backpack = LocalPlayer.Backpack

    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            local baseName, weight, _ = parsePetName(item)
            local matchName = nil
            
            if selectedBasePetNames[baseName] then
                matchName = baseName
            else
                for selName, _ in pairs(selectedBasePetNames) do
                    if string.find(string.lower(baseName), string.lower(selName), 1, true) then
                        matchName = selName
                        break
                    end
                end
            end

            if matchName and weight >= minVal and weight <= maxVal then
                counts[matchName] = (counts[matchName] or 0) + 1
            end
        end
    end

    local resultStr = ""
    local totalFound = 0
    for name, count in pairs(counts) do
        resultStr = resultStr .. string.format("%s %s - %skg = %d pet\n", string.lower(name), minStr, maxStr, count)
        totalFound = totalFound + 1
    end

    if totalFound == 0 then
        detectResultLabel.Text = "No pets found in that weight range."
        detectResultLabel.TextColor3 = Color3.fromRGB(200, 160, 60)
        detectResultContainer.Size = UDim2.new(1, 0, 0, 34)
    else
        detectResultLabel.Text = resultStr
        detectResultLabel.TextColor3 = Color3.fromRGB(160, 220, 160)
        local newHeight = math.max(34, totalFound * 16 + 10)
        detectResultContainer.Size = UDim2.new(1, 0, 0, newHeight)
    end
end)

-- ========== LOGIC: AUTO GIVE ==========
local function doAutoGive()
    if not selectedPlayer then return end
    local targetPlayer = Players:FindFirstChild(selectedPlayer)
    if not targetPlayer then return end

    local selectedBasePetNames = {}
    for petEntry, isSelected in pairs(selectedPets) do
        if isSelected then selectedBasePetNames[getBasePetName(petEntry)] = true end
    end
    if next(selectedBasePetNames) == nil then return end

    local backpack = LocalPlayer.Backpack
    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            local baseName, weight, age = parsePetName(item)
            local isMatch = selectedBasePetNames[baseName]
            if not isMatch then
                for selPet, _ in pairs(selectedBasePetNames) do
                    if string.find(string.lower(baseName), string.lower(selPet), 1, true) then
                        isMatch = true break
                    end
                end
            end

            if isMatch and passesThreshold(weight, age) then
                LocalPlayer.Character.Humanoid:EquipTool(item)
                task.wait(0.2)
                remote:FireServer("GivePet", targetPlayer)
                task.wait(0.5)
            end
        end
    end
end

startStopBtn.MouseButton1Click:Connect(function()
    autoGiveEnabled = not autoGiveEnabled
    if autoGiveEnabled then
        startStopBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        startStopBtn.Text = "■ Stop Auto Give"
        autoGiveThread = task.spawn(function()
            while autoGiveEnabled do doAutoGive() task.wait(1) end
        end)
    else
        startStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
        startStopBtn.Text = "▶ Start Auto Give"
        if autoGiveThread then task.cancel(autoGiveThread) autoGiveThread = nil end
    end
end)

-- ========== LOGIC: AUTO ACCEPT ==========
local function clickGUIButton(button)
    if firesignal then firesignal(button.MouseButton1Click)
    elseif getconnections then for _, conn in ipairs(getconnections(button.MouseButton1Click)) do conn:Fire() end
    else game:GetService("VirtualUser"):ClickButton(button) end
end

local function doAutoAccept()
    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not pGui then return end
    local giftNotif = pGui:FindFirstChild("Gift_Notification")
    if giftNotif and giftNotif:FindFirstChild("Frame") and giftNotif.Frame:FindFirstChild("Gift_Notification") then
        local mainGiftFrame = giftNotif.Frame.Gift_Notification
        if mainGiftFrame.Visible then
            local holder = mainGiftFrame:FindFirstChild("Holder")
            if holder and holder:FindFirstChild("Frame") then
                local acceptBtn = holder.Frame:FindFirstChild("Accept")
                if acceptBtn and acceptBtn:IsA("GuiButton") then
                    clickGUIButton(acceptBtn)
                    local timeout = tick() + 0.1
                    while autoAcceptEnabled and tick() < timeout do task.wait(0.1) end
                end
            end
        end
    end
end

acceptStartStopBtn.MouseButton1Click:Connect(function()
    autoAcceptEnabled = not autoAcceptEnabled
    if autoAcceptEnabled then
        acceptStartStopBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        acceptStartStopBtn.Text = "■ Stop Auto Accept"
        autoAcceptThread = task.spawn(function()
            while autoAcceptEnabled do doAutoAccept() task.wait(0.5) end
        end)
    else
        acceptStartStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
        acceptStartStopBtn.Text = "▶ Start Auto Accept"
        if autoAcceptThread then task.cancel(autoAcceptThread) autoAcceptThread = nil end
    end
end)

-- ========== DYNAMIC CANVAS ==========
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
end)

-- ========== WINDOW CONTROL & DRAG ==========
toggleBtn.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

local dragging = false
local dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = mainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("[AutoGivePet] Compact Mobile Version Loaded!")
