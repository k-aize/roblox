local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local remote = ReplicatedStorage.GameEvents.PetGiftingService

-- ========== CONFIG ==========
local PET_LIST = {
    "[Common Egg] Golden Lab",
    "[Common Egg] Dog",
    "[Common Egg] Bunny",
    "[Uncommon Egg] Black Bunny",
    "[Uncommon Egg] Chicken",
    "[Uncommon Egg] Cat",
    "[Uncommon Egg] Deer",
    "[Rare Egg] Orange Tabby",
    "[Rare Egg] Spotted Deer",
    "[Rare Egg] Pig",
    "[Rare Egg] Rooster",
    "[Rare Egg] Monkey",
    "[Legendary Egg] Cow",
    "[Legendary Egg] Silver Monkey",
    "[Legendary Egg] Sea Otter",
    "[Legendary Egg] Turtle",
    "[Legendary Egg] Polar Bear",
    "[Mythical Egg] Grey Mouse",
    "[Mythical Egg] Brown Mouse",
    "[Mythical Egg] Squirrel",
    "[Mythical Egg] Red Giant Ant",
    "[Mythical Egg] Red Fox",
    "[Bug Egg] Caterpillar",
    "[Bug Egg] Snail",
    "[Bug Egg] Giant Ant",
    "[Bug Egg] Praying Mantis",
    "[Bug Egg] Dragonfly",
    "[Jungle Egg] Tree Frog",
    "[Jungle Egg] Hummingbird",
    "[Jungle Egg] Iguana",
    "[Jungle Egg] Chimpanzee",
    "[Jungle Egg] Tiger",
    "[Night Egg] Hedgehog",
    "[Night Egg] Mole",
    "[Night Egg] Frog",
    "[Night Egg] Echo Frog",
    "[Night Egg] Night Owl",
    "[Night Egg] Raccoon",
    "[Bee Egg] Bee",
    "[Bee Egg] Honey Bee",
    "[Bee Egg] Bear Bee",
    "[Bee Egg] Petal Bee",
    "[Bee Egg] Queen Bee (Pet)",
    "[Anti Bee Egg] Wasp",
    "[Anti Bee Egg] Tarantula Hawk",
    "[Anti Bee Egg] Moth",
    "[Anti Bee Egg] Butterfly",
    "[Anti Bee Egg] Disco Bee",
    "[Common Summer Egg] Starfish",
    "[Common Summer Egg] Seagull",
    "[Common Summer Egg] Crab",
    "[Rare Summer Egg] Flamingo",
    "[Rare Summer Egg] Toucan",
    "[Rare Summer Egg] Sea Turtle",
    "[Rare Summer Egg] Orangutan",
    "[Rare Summer Egg] Seal",
    "[Paradise Egg] Ostrich",
    "[Paradise Egg] Peacock",
    "[Paradise Egg] Capybara",
    "[Paradise Egg] Scarlet Macaw",
    "[Paradise Egg] Mimic Octopus",
    "[Oasis Egg] Meerkat",
    "[Oasis Egg] Sand Snake",
    "[Oasis Egg] Axolotl",
    "[Oasis Egg] Hyacinth Macaw",
    "[Oasis Egg] Fennec Fox",
    "[Dinosaur Egg] Raptor",
    "[Dinosaur Egg] Triceratops",
    "[Dinosaur Egg] Stegosaurus",
    "[Dinosaur Egg] Pterodactyl",
    "[Dinosaur Egg] Brontosaurus",
    "[Dinosaur Egg] T-Rex",
    "[Primal Egg] Parasaurolophus",
    "[Primal Egg] Iguanodon",
    "[Primal Egg] Pachycephalosaurus",
    "[Primal Egg] Dilophosaurus",
    "[Primal Egg] Ankylosaurus",
    "[Primal Egg] Spinosaurus",
    "[Zen Egg] Shiba Inu",
    "[Zen Egg] Nihonzaru",
    "[Zen Egg] Tanuki",
    "[Zen Egg] Tanchozuru",
    "[Zen Egg] Kappa",
    "[Zen Egg] Kitsune",
    "[Corrupted Zen Egg] Maneki-neko",
    "[Corrupted Zen Egg] Tsuchinoko",
    "[Corrupted Zen Egg] Kodama",
    "[Corrupted Zen Egg] Raiju",
    "[Corrupted Zen Egg] Mizuchi",
    "[Corrupted Zen Egg] Corrupted Kitsune",
    "[Gourmet Egg] Bagel Bunny",
    "[Gourmet Egg] Pancake Mole",
    "[Gourmet Egg] Sushi Bear",
    "[Gourmet Egg] Spaghetti Sloth",
    "[Gourmet Egg] French Fry Ferret",
    "[Sprout Egg] Dairy Cow",
    "[Sprout Egg] Jackalope",
    "[Sprout Egg] Seedling",
    "[Sprout Egg] Golem",
    "[Sprout Egg] Golden Goose",
    "[Enchanted Egg] Ladybug",
    "[Enchanted Egg] Pixie",
    "[Enchanted Egg] Imp",
    "[Enchanted Egg] Glimmering Sprite",
    "[Enchanted Egg] Cockatrice",
    "[Fall Egg] Robin",
    "[Fall Egg] Badger",
    "[Fall Egg] Grizzly Bear",
    "[Fall Egg] Barn Owl",
    "[Fall Egg] Swan",
    "[Spooky Egg] Bat",
    "[Spooky Egg] Bone Dog",
    "[Spooky Egg] Spider",
    "[Spooky Egg] Black Cat",
    "[Spooky Egg] Headless Horseman",
    "[Safari Egg] Oxpecker",
    "[Safari Egg] Zebra",
    "[Safari Egg] Giraffe",
    "[Safari Egg] Rhino",
    "[Safari Egg] Elephant",
    "[Gem Egg] Topaz Snail",
    "[Gem Egg] Amethyst Beetle",
    "[Gem Egg] Emerald Snake",
    "[Gem Egg] Sapphire Macaw",
    "[Gem Egg] Diamond Panther",
    "[Gem Egg] Ruby Squid",
    "[Lich Crystal Egg] Lich",
    "[Christmas Egg] Turtle Dove",
    "[Christmas Egg] Reindeer",
    "[Christmas Egg] Nutcracker",
    "[Christmas Egg] Yeti",
    "[Christmas Egg] Ice Golem",
    "[Winter Egg] Partridge",
    "[Winter Egg] Santa Bear",
    "[Winter Egg] Moose",
    "[Winter Egg] Frost Squirrel",
    "[Winter Egg] Wendigo",
    "[New Year's Egg] New Year's Bird",
    "[New Year's Egg] Firework Sprite",
    "[New Year's Egg] Celebration Puppy",
    "[New Year's Egg] New Year's Chimp",
    "[New Year's Egg] Star Wolf",
    "[New Year's Egg] New Year's Dragon",
    "[Carnival Egg] Unicycle Monkey",
    "[Carnival Egg] Performer Seal",
    "[Carnival Egg] Bear on Bike",
    "[Carnival Egg] Show Pony",
    "[Carnival Egg] Carnival Elephant",
    "[Bird Egg] Black Bird",
    "[Bird Egg] Cuckoo",
    "[Bird Egg] Brown Owl",
    "[Bird Egg] Gold Finch",
    "[Bird Egg] Birb",
    "[Golden Egg] Chocolate Bunny",
    "[Golden Egg] Easter Egg Chick",
    "[Golden Egg] Marshmallow Lamb",
    "[Golden Egg] Easter Bunny",
    "[Gilded Choc Golden Egg] Gilded Choc Chocolate Bunny",
    "[Gilded Choc Golden Egg] Gilded Choc Easter Egg Chick",
    "[Gilded Choc Golden Egg] Gilded Choc Marshmallow Lamb",
    "[Gilded Choc Golden Egg] Gilded Choc Easter Bunny",
    "[Springtide Egg] Spring Bee",
    "[Springtide Egg] Jerboa",
    "[Springtide Egg] Nyala",
    "[Springtide Egg] Peryton",
    "[Gilded Choc Springtide Egg] Gilded Choc Spring Bee",
    "[Gilded Choc Springtide Egg] Gilded Choc Jerboa",
    "[Gilded Choc Springtide Egg] Gilded Choc Nyala",
    "[Gilded Choc Springtide Egg] Gilded Choc Peryton"
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

-- Detect Pet State
local detectSelectedPet = nil
local detectPetDisplayName = "Select Pet"
local detectR1Min = 0.1
local detectR1Max = 1.99
local detectR2Min = 2.0
local detectR2Max = 2.99
local detectScanThread = nil
local detectScanEnabled = false

-- ========== GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoGivePetGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game:GetService("CoreGui")

-- Toggle Button (kecil, di kiri tengah)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 95, 0, 30)
toggleBtn.Position = UDim2.new(0, 6, 0.5, -15)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "🐾 AutoGive"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 12
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 7)
toggleCorner.Parent = toggleBtn

-- Main Frame (diperkecil untuk mobile)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 290, 0, 480)
mainFrame.Position = UDim2.new(0.5, -145, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 12)
titleBarCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -44, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🐾 Auto Give Pet"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 6)
closeBtnCorner.Parent = closeBtn

-- Scrollable Content
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -38)
scrollFrame.Position = UDim2.new(0, 0, 0, 38)
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
    lbl.TextSize = 10
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
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = frame
    return frame
end

-- ========== SECTION: SELECT PETS ==========
sectionLabel("SELECT PETS", 1)

local petMainContainer = createContainer(2, 38)

local petDropdownBtn = Instance.new("TextButton")
petDropdownBtn.Size = UDim2.new(1, -16, 0, 28)
petDropdownBtn.Position = UDim2.new(0, 8, 0, 5)
petDropdownBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
petDropdownBtn.BorderSizePixel = 0
petDropdownBtn.Text = "▼  Select Pets"
petDropdownBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
petDropdownBtn.TextSize = 11
petDropdownBtn.Font = Enum.Font.Gotham
petDropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
petDropdownBtn.Parent = petMainContainer

local petDpCorner = Instance.new("UICorner")
petDpCorner.CornerRadius = UDim.new(0, 6)
petDpCorner.Parent = petDropdownBtn

local petDpPadding = Instance.new("UIPadding")
petDpPadding.PaddingLeft = UDim.new(0, 8)
petDpPadding.Parent = petDropdownBtn

-- Pet Dropdown Content
local petDropContent = Instance.new("Frame")
petDropContent.Name = "PetDropContent"
petDropContent.Size = UDim2.new(1, -16, 0, 210)
petDropContent.Position = UDim2.new(0, 8, 0, 38)
petDropContent.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
petDropContent.BorderSizePixel = 0
petDropContent.ClipsDescendants = true
petDropContent.Visible = false
petDropContent.Parent = petMainContainer

local petDropCorner = Instance.new("UICorner")
petDropCorner.CornerRadius = UDim.new(0, 6)
petDropCorner.Parent = petDropContent

-- Pet Search Box
local petSearchBox = Instance.new("TextBox")
petSearchBox.Size = UDim2.new(1, -10, 0, 26)
petSearchBox.Position = UDim2.new(0, 5, 0, 5)
petSearchBox.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
petSearchBox.BorderSizePixel = 0
petSearchBox.Text = ""
petSearchBox.PlaceholderText = "🔍 Search Pet..."
petSearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 150)
petSearchBox.TextColor3 = Color3.fromRGB(220, 220, 240)
petSearchBox.TextSize = 11
petSearchBox.Font = Enum.Font.Gotham
petSearchBox.ClearTextOnFocus = false
petSearchBox.Parent = petDropContent

local petSearchCorner = Instance.new("UICorner")
petSearchCorner.CornerRadius = UDim.new(0, 5)
petSearchCorner.Parent = petSearchBox

local petSearchPadding = Instance.new("UIPadding")
petSearchPadding.PaddingLeft = UDim.new(0, 8)
petSearchPadding.Parent = petSearchBox

-- Pet Scrolling List
local petScrollFrame = Instance.new("ScrollingFrame")
petScrollFrame.Size = UDim2.new(1, -10, 1, -38)
petScrollFrame.Position = UDim2.new(0, 5, 0, 34)
petScrollFrame.BackgroundTransparency = 1
petScrollFrame.BorderSizePixel = 0
petScrollFrame.ScrollBarThickness = 3
petScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 160)
petScrollFrame.Parent = petDropContent

local petListLayout2 = Instance.new("UIListLayout")
petListLayout2.FillDirection = Enum.FillDirection.Vertical
petListLayout2.Padding = UDim.new(0, 3)
petListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
petListLayout2.Parent = petScrollFrame

local petCheckboxes = {}

for i, petName in ipairs(PET_LIST) do
    local petBtn = Instance.new("TextButton")
    petBtn.Size = UDim2.new(1, -6, 0, 28)
    petBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    petBtn.BorderSizePixel = 0
    petBtn.LayoutOrder = i
    petBtn.Parent = petScrollFrame

    local petBtnCorner = Instance.new("UICorner")
    petBtnCorner.CornerRadius = UDim.new(0, 5)
    petBtnCorner.Parent = petBtn

    local checkIcon = Instance.new("TextLabel")
    checkIcon.Size = UDim2.new(0, 16, 0, 16)
    checkIcon.Position = UDim2.new(0, 6, 0.5, -8)
    checkIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    checkIcon.BorderSizePixel = 0
    checkIcon.Text = ""
    checkIcon.TextColor3 = Color3.fromRGB(100, 200, 100)
    checkIcon.TextSize = 10
    checkIcon.Font = Enum.Font.GothamBold
    checkIcon.Parent = petBtn

    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 3)
    checkCorner.Parent = checkIcon

    local petLabel = Instance.new("TextLabel")
    petLabel.Size = UDim2.new(1, -32, 1, 0)
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
            petBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
        else
            selectedPets[petName] = true
            checkIcon.Text = "✓"
            checkIcon.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
            petBtn.BackgroundColor3 = Color3.fromRGB(30, 55, 30)
        end
    end)
end

-- Update scroll height
petListLayout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    petScrollFrame.CanvasSize = UDim2.new(0, 0, 0, petListLayout2.AbsoluteContentSize.Y + 8)
end)

-- Search Logic
petSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(petSearchBox.Text)
    for _, data in pairs(petCheckboxes) do
        if query == "" or string.find(data.name, query, 1, true) then
            data.btn.Visible = true
        else
            data.btn.Visible = false
        end
    end
end)

-- Toggle Pet Dropdown
local petDropOpen = false
petDropdownBtn.MouseButton1Click:Connect(function()
    petDropOpen = not petDropOpen
    if petDropOpen then
        petDropContent.Visible = true
        petMainContainer.Size = UDim2.new(1, 0, 0, 254)
        petDropdownBtn.Text = "▲  Close Pet Selection"
        petDropdownBtn.TextColor3 = Color3.fromRGB(100, 220, 140)
    else
        petDropContent.Visible = false
        petMainContainer.Size = UDim2.new(1, 0, 0, 38)
        petDropdownBtn.Text = "▼  Select Pets"
        petDropdownBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
    end
end)

-- ========== SECTION: SELECT PLAYER ==========
sectionLabel("SELECT PLAYER", 3)

local playerContainer = createContainer(4, 38)

local playerDropdownBtn = Instance.new("TextButton")
playerDropdownBtn.Size = UDim2.new(1, -16, 0, 28)
playerDropdownBtn.Position = UDim2.new(0, 8, 0, 5)
playerDropdownBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
playerDropdownBtn.BorderSizePixel = 0
playerDropdownBtn.Text = "▼  Select Options"
playerDropdownBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
playerDropdownBtn.TextSize = 11
playerDropdownBtn.Font = Enum.Font.Gotham
playerDropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
playerDropdownBtn.Parent = playerContainer

local dpCorner = Instance.new("UICorner")
dpCorner.CornerRadius = UDim.new(0, 6)
dpCorner.Parent = playerDropdownBtn

local dpPadding = Instance.new("UIPadding")
dpPadding.PaddingLeft = UDim.new(0, 8)
dpPadding.Parent = playerDropdownBtn

local playerDropList = Instance.new("Frame")
playerDropList.Name = "PlayerDropList"
playerDropList.Size = UDim2.new(1, -16, 0, 0)
playerDropList.Position = UDim2.new(0, 8, 0, 38)
playerDropList.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
playerDropList.BorderSizePixel = 0
playerDropList.ClipsDescendants = true
playerDropList.ZIndex = 10
playerDropList.Visible = false
playerDropList.Parent = playerContainer

local dpListCorner = Instance.new("UICorner")
dpListCorner.CornerRadius = UDim.new(0, 6)
dpListCorner.Parent = playerDropList

local dpListLayout = Instance.new("UIListLayout")
dpListLayout.FillDirection = Enum.FillDirection.Vertical
dpListLayout.Padding = UDim.new(0, 2)
dpListLayout.SortOrder = Enum.SortOrder.LayoutOrder
dpListLayout.Parent = playerDropList

local dpListPadding = Instance.new("UIPadding")
dpListPadding.PaddingTop = UDim.new(0, 4)
dpListPadding.PaddingBottom = UDim.new(0, 4)
dpListPadding.PaddingLeft = UDim.new(0, 4)
dpListPadding.PaddingRight = UDim.new(0, 4)
dpListPadding.Parent = playerDropList

local playerDropOpen = false

local function getOtherPlayers()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(list, p.Name)
        end
    end
    return list
end

local function buildPlayerDropdown()
    for _, child in ipairs(playerDropList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local otherPlayers = getOtherPlayers()
    if #otherPlayers == 0 then
        local noPlayers = Instance.new("TextLabel")
        noPlayers.Size = UDim2.new(1, 0, 0, 26)
        noPlayers.BackgroundTransparency = 1
        noPlayers.Text = "No other players found"
        noPlayers.TextColor3 = Color3.fromRGB(120, 120, 140)
        noPlayers.TextSize = 10
        noPlayers.Font = Enum.Font.Gotham
        noPlayers.Parent = playerDropList
        playerDropList.Size = UDim2.new(1, -16, 0, 34)
        return
    end
    local totalH = 8 + (#otherPlayers * 28) + (#otherPlayers - 1) * 2
    playerDropList.Size = UDim2.new(1, -16, 0, totalH)
    for i, pName in ipairs(otherPlayers) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(1, 0, 0, 26)
        pBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
        pBtn.BorderSizePixel = 0
        pBtn.Text = "  👤 " .. pName
        pBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
        pBtn.TextSize = 11
        pBtn.Font = Enum.Font.Gotham
        pBtn.TextXAlignment = Enum.TextXAlignment.Left
        pBtn.LayoutOrder = i
        pBtn.ZIndex = 11
        pBtn.Parent = playerDropList

        local pBtnCorner = Instance.new("UICorner")
        pBtnCorner.CornerRadius = UDim.new(0, 5)
        pBtnCorner.Parent = pBtn

        pBtn.MouseButton1Click:Connect(function()
            selectedPlayer = pName
            playerDropdownBtn.Text = "▼  " .. pName
            playerDropdownBtn.TextColor3 = Color3.fromRGB(100, 220, 140)
            playerDropList.Visible = false
            playerDropOpen = false
            playerContainer.Size = UDim2.new(1, 0, 0, 38)
        end)
    end
end

playerDropdownBtn.MouseButton1Click:Connect(function()
    if playerDropOpen then
        playerDropList.Visible = false
        playerDropOpen = false
        playerContainer.Size = UDim2.new(1, 0, 0, 38)
    else
        buildPlayerDropdown()
        playerDropList.Visible = true
        playerDropOpen = true
        local listH = playerDropList.Size.Y.Offset
        playerContainer.Size = UDim2.new(1, 0, 0, 38 + listH + 6)
    end
end)

-- ========== REFRESH PLAYER ==========
sectionLabel("", 5)

local refreshContainer = createContainer(6, 38)

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, 0, 1, 0)
refreshBtn.BackgroundTransparency = 1
refreshBtn.Text = ""
refreshBtn.Parent = refreshContainer

local refreshLabel = Instance.new("TextLabel")
refreshLabel.Size = UDim2.new(1, -50, 1, 0)
refreshLabel.Position = UDim2.new(0, 12, 0, 0)
refreshLabel.BackgroundTransparency = 1
refreshLabel.Text = "Refresh Players"
refreshLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
refreshLabel.TextSize = 12
refreshLabel.Font = Enum.Font.GothamBold
refreshLabel.TextXAlignment = Enum.TextXAlignment.Left
refreshLabel.Parent = refreshContainer

local refreshIcon = Instance.new("TextLabel")
refreshIcon.Size = UDim2.new(0, 26, 0, 26)
refreshIcon.Position = UDim2.new(1, -34, 0.5, -13)
refreshIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
refreshIcon.BorderSizePixel = 0
refreshIcon.Text = "↻"
refreshIcon.TextColor3 = Color3.fromRGB(160, 160, 220)
refreshIcon.TextSize = 16
refreshIcon.Font = Enum.Font.GothamBold
refreshIcon.Parent = refreshContainer

local refreshIconCorner = Instance.new("UICorner")
refreshIconCorner.CornerRadius = UDim.new(0, 5)
refreshIconCorner.Parent = refreshIcon

refreshBtn.MouseButton1Click:Connect(function()
    if playerDropOpen then
        playerDropList.Visible = false
        playerDropOpen = false
        playerContainer.Size = UDim2.new(1, 0, 0, 38)
    end
    if selectedPlayer then
        local found = false
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name == selectedPlayer then found = true break end
        end
        if not found then
            selectedPlayer = nil
            playerDropdownBtn.Text = "▼  Select Options"
            playerDropdownBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
        end
    end
    refreshIcon.TextColor3 = Color3.fromRGB(100, 220, 140)
    task.delay(0.5, function()
        refreshIcon.TextColor3 = Color3.fromRGB(160, 160, 220)
    end)
end)

-- ========== SECTION: THRESHOLD FILTER ==========
sectionLabel("THRESHOLD FILTER", 7)

local thresholdModeContainer = createContainer(8, 38)

local thresholdModeLabel = Instance.new("TextLabel")
thresholdModeLabel.Size = UDim2.new(0.5, -6, 1, 0)
thresholdModeLabel.Position = UDim2.new(0, 10, 0, 0)
thresholdModeLabel.BackgroundTransparency = 1
thresholdModeLabel.Text = "Threshold Mode"
thresholdModeLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
thresholdModeLabel.TextSize = 11
thresholdModeLabel.Font = Enum.Font.Gotham
thresholdModeLabel.TextXAlignment = Enum.TextXAlignment.Left
thresholdModeLabel.Parent = thresholdModeContainer

local modeToggleFrame = Instance.new("Frame")
modeToggleFrame.Size = UDim2.new(0, 128, 0, 26)
modeToggleFrame.Position = UDim2.new(1, -138, 0.5, -13)
modeToggleFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
modeToggleFrame.BorderSizePixel = 0
modeToggleFrame.Parent = thresholdModeContainer

local modeToggleCorner = Instance.new("UICorner")
modeToggleCorner.CornerRadius = UDim.new(0, 5)
modeToggleCorner.Parent = modeToggleFrame

local aboveBtn = Instance.new("TextButton")
aboveBtn.Size = UDim2.new(0.5, -2, 1, -4)
aboveBtn.Position = UDim2.new(0, 2, 0, 2)
aboveBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
aboveBtn.BorderSizePixel = 0
aboveBtn.Text = "Above"
aboveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aboveBtn.TextSize = 10
aboveBtn.Font = Enum.Font.GothamBold
aboveBtn.Parent = modeToggleFrame

local aboveBtnCorner = Instance.new("UICorner")
aboveBtnCorner.CornerRadius = UDim.new(0, 4)
aboveBtnCorner.Parent = aboveBtn

local belowBtn = Instance.new("TextButton")
belowBtn.Size = UDim2.new(0.5, -2, 1, -4)
belowBtn.Position = UDim2.new(0.5, 0, 0, 2)
belowBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
belowBtn.BorderSizePixel = 0
belowBtn.Text = "Below"
belowBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
belowBtn.TextSize = 10
belowBtn.Font = Enum.Font.Gotham
belowBtn.Parent = modeToggleFrame

local belowBtnCorner = Instance.new("UICorner")
belowBtnCorner.CornerRadius = UDim.new(0, 4)
belowBtnCorner.Parent = belowBtn

aboveBtn.MouseButton1Click:Connect(function()
    thresholdMode = "above"
    aboveBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
    aboveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    aboveBtn.Font = Enum.Font.GothamBold
    belowBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    belowBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
    belowBtn.Font = Enum.Font.Gotham
end)

belowBtn.MouseButton1Click:Connect(function()
    thresholdMode = "below"
    belowBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
    belowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    belowBtn.Font = Enum.Font.GothamBold
    aboveBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    aboveBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
    aboveBtn.Font = Enum.Font.Gotham
end)

-- Weight Threshold Input
local weightContainer = createContainer(9, 38)

local weightLabel = Instance.new("TextLabel")
weightLabel.Size = UDim2.new(0.6, 0, 1, 0)
weightLabel.Position = UDim2.new(0, 10, 0, 0)
weightLabel.BackgroundTransparency = 1
weightLabel.Text = "⚖ Weight Threshold (KG)"
weightLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
weightLabel.TextSize = 10
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
weightInput.PlaceholderText = "0"
weightInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
weightInput.ClearTextOnFocus = false
weightInput.Parent = weightContainer

local weightInputCorner = Instance.new("UICorner")
weightInputCorner.CornerRadius = UDim.new(0, 5)
weightInputCorner.Parent = weightInput

weightInput:GetPropertyChangedSignal("Text"):Connect(function()
    local val = tonumber(weightInput.Text)
    if val then weightThreshold = val end
end)

-- Age Threshold Input
local ageContainer = createContainer(10, 38)

local ageLabel = Instance.new("TextLabel")
ageLabel.Size = UDim2.new(0.6, 0, 1, 0)
ageLabel.Position = UDim2.new(0, 10, 0, 0)
ageLabel.BackgroundTransparency = 1
ageLabel.Text = "🎂 Age Threshold"
ageLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
ageLabel.TextSize = 10
ageLabel.Font = Enum.Font.Gotham
ageLabel.TextXAlignment = Enum.TextXAlignment.Left
ageLabel.Parent = ageContainer

local ageInput = Instance.new("TextBox")
ageInput.Size = UDim2.new(0, 60, 0, 24)
ageInput.Position = UDim2.new(1, -68, 0.5, -12)
ageInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
ageInput.BorderSizePixel = 0
ageInput.Text = "0"
ageInput.TextColor3 = Color3.fromRGB(220, 220, 240)
ageInput.TextSize = 11
ageInput.Font = Enum.Font.GothamBold
ageInput.PlaceholderText = "0"
ageInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
ageInput.ClearTextOnFocus = false
ageInput.Parent = ageContainer

local ageInputCorner = Instance.new("UICorner")
ageInputCorner.CornerRadius = UDim.new(0, 5)
ageInputCorner.Parent = ageInput

ageInput:GetPropertyChangedSignal("Text"):Connect(function()
    local val = tonumber(ageInput.Text)
    if val then ageThreshold = val end
end)

-- ========== STATUS LABEL (AUTO GIVE) ==========
local statusContainer = createContainer(11, 30)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -16, 1, 0)
statusLabel.Position = UDim2.new(0, 8, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Give Status: Idle"
statusLabel.TextColor3 = Color3.fromRGB(160, 160, 200)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = statusContainer

-- ========== START/STOP BUTTON (AUTO GIVE) ==========
local startStopContainer = createContainer(12, 38)

local startStopBtn = Instance.new("TextButton")
startStopBtn.Size = UDim2.new(1, -16, 0, 28)
startStopBtn.Position = UDim2.new(0, 8, 0, 5)
startStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
startStopBtn.BorderSizePixel = 0
startStopBtn.Text = "▶  Start Auto Give"
startStopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startStopBtn.TextSize = 12
startStopBtn.Font = Enum.Font.GothamBold
startStopBtn.Parent = startStopContainer

local startStopCorner = Instance.new("UICorner")
startStopCorner.CornerRadius = UDim.new(0, 6)
startStopCorner.Parent = startStopBtn

-- ========== SECTION: AUTO ACCEPT GIVE ==========
sectionLabel("AUTO ACCEPT GIVE", 13)

local acceptStatusContainer = createContainer(14, 30)

local acceptStatusLabel = Instance.new("TextLabel")
acceptStatusLabel.Size = UDim2.new(1, -16, 1, 0)
acceptStatusLabel.Position = UDim2.new(0, 8, 0, 0)
acceptStatusLabel.BackgroundTransparency = 1
acceptStatusLabel.Text = "Accept Status: Idle"
acceptStatusLabel.TextColor3 = Color3.fromRGB(160, 160, 200)
acceptStatusLabel.TextSize = 10
acceptStatusLabel.Font = Enum.Font.Gotham
acceptStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
acceptStatusLabel.Parent = acceptStatusContainer

local acceptStartStopContainer = createContainer(15, 38)

local acceptStartStopBtn = Instance.new("TextButton")
acceptStartStopBtn.Size = UDim2.new(1, -16, 0, 28)
acceptStartStopBtn.Position = UDim2.new(0, 8, 0, 5)
acceptStartStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
acceptStartStopBtn.BorderSizePixel = 0
acceptStartStopBtn.Text = "▶  Start Auto Accept"
acceptStartStopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
acceptStartStopBtn.TextSize = 12
acceptStartStopBtn.Font = Enum.Font.GothamBold
acceptStartStopBtn.Parent = acceptStartStopContainer

local acceptStartStopCorner = Instance.new("UICorner")
acceptStartStopCorner.CornerRadius = UDim.new(0, 6)
acceptStartStopCorner.Parent = acceptStartStopBtn

-- ========================================================
-- ========== SECTION: DETECT PET IN BACKPACK =============
-- ========================================================
sectionLabel("🔍 DETECT PET IN BACKPACK", 16)

-- --- Pet Selector for Detect ---
local detectPetContainer = createContainer(17, 38)

local detectPetBtn = Instance.new("TextButton")
detectPetBtn.Size = UDim2.new(1, -16, 0, 28)
detectPetBtn.Position = UDim2.new(0, 8, 0, 5)
detectPetBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
detectPetBtn.BorderSizePixel = 0
detectPetBtn.Text = "▼  Select Pet to Detect"
detectPetBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
detectPetBtn.TextSize = 11
detectPetBtn.Font = Enum.Font.Gotham
detectPetBtn.TextXAlignment = Enum.TextXAlignment.Left
detectPetBtn.Parent = detectPetContainer

local detectPetBtnCorner = Instance.new("UICorner")
detectPetBtnCorner.CornerRadius = UDim.new(0, 6)
detectPetBtnCorner.Parent = detectPetBtn

local detectPetBtnPadding = Instance.new("UIPadding")
detectPetBtnPadding.PaddingLeft = UDim.new(0, 8)
detectPetBtnPadding.Parent = detectPetBtn

-- Detect Pet Dropdown Content
local detectDropContent = Instance.new("Frame")
detectDropContent.Size = UDim2.new(1, -16, 0, 200)
detectDropContent.Position = UDim2.new(0, 8, 0, 38)
detectDropContent.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
detectDropContent.BorderSizePixel = 0
detectDropContent.ClipsDescendants = true
detectDropContent.Visible = false
detectDropContent.Parent = detectPetContainer

local detectDropCorner = Instance.new("UICorner")
detectDropCorner.CornerRadius = UDim.new(0, 6)
detectDropCorner.Parent = detectDropContent

-- Detect Search Box
local detectSearchBox = Instance.new("TextBox")
detectSearchBox.Size = UDim2.new(1, -10, 0, 24)
detectSearchBox.Position = UDim2.new(0, 5, 0, 5)
detectSearchBox.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
detectSearchBox.BorderSizePixel = 0
detectSearchBox.Text = ""
detectSearchBox.PlaceholderText = "🔍 Search..."
detectSearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 150)
detectSearchBox.TextColor3 = Color3.fromRGB(220, 220, 240)
detectSearchBox.TextSize = 11
detectSearchBox.Font = Enum.Font.Gotham
detectSearchBox.ClearTextOnFocus = false
detectSearchBox.Parent = detectDropContent

local detectSearchCorner = Instance.new("UICorner")
detectSearchCorner.CornerRadius = UDim.new(0, 5)
detectSearchCorner.Parent = detectSearchBox

local detectSearchPadding = Instance.new("UIPadding")
detectSearchPadding.PaddingLeft = UDim.new(0, 8)
detectSearchPadding.Parent = detectSearchBox

-- Detect Pet Scroll
local detectPetScroll = Instance.new("ScrollingFrame")
detectPetScroll.Size = UDim2.new(1, -10, 1, -34)
detectPetScroll.Position = UDim2.new(0, 5, 0, 30)
detectPetScroll.BackgroundTransparency = 1
detectPetScroll.BorderSizePixel = 0
detectPetScroll.ScrollBarThickness = 3
detectPetScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 160)
detectPetScroll.Parent = detectDropContent

local detectPetScrollLayout = Instance.new("UIListLayout")
detectPetScrollLayout.FillDirection = Enum.FillDirection.Vertical
detectPetScrollLayout.Padding = UDim.new(0, 3)
detectPetScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
detectPetScrollLayout.Parent = detectPetScroll

local detectPetBtns = {}

for i, petName in ipairs(PET_LIST) do
    local basePetName = petName:match("%]%s*(.+)$") or petName

    local dpBtn = Instance.new("TextButton")
    dpBtn.Size = UDim2.new(1, -6, 0, 24)
    dpBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    dpBtn.BorderSizePixel = 0
    dpBtn.Text = "  " .. petName
    dpBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
    dpBtn.TextSize = 10
    dpBtn.Font = Enum.Font.Gotham
    dpBtn.TextXAlignment = Enum.TextXAlignment.Left
    dpBtn.TextTruncate = Enum.TextTruncate.AtEnd
    dpBtn.LayoutOrder = i
    dpBtn.Parent = detectPetScroll

    local dpBtnCorner = Instance.new("UICorner")
    dpBtnCorner.CornerRadius = UDim.new(0, 4)
    dpBtnCorner.Parent = dpBtn

    table.insert(detectPetBtns, {btn = dpBtn, name = string.lower(petName), base = basePetName})

    dpBtn.MouseButton1Click:Connect(function()
        detectSelectedPet = basePetName
        detectPetDisplayName = basePetName
        detectPetBtn.Text = "▼  " .. basePetName
        detectPetBtn.TextColor3 = Color3.fromRGB(100, 220, 140)
        detectDropContent.Visible = false
        detectDropOpen = false
        detectPetContainer.Size = UDim2.new(1, 0, 0, 38)
        detectSearchBox.Text = ""
        -- Reset all btn colors
        for _, d in ipairs(detectPetBtns) do
            d.btn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
        end
        dpBtn.BackgroundColor3 = Color3.fromRGB(30, 55, 30)
    end)
end

detectPetScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    detectPetScroll.CanvasSize = UDim2.new(0, 0, 0, detectPetScrollLayout.AbsoluteContentSize.Y + 6)
end)

detectSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local q = string.lower(detectSearchBox.Text)
    for _, d in ipairs(detectPetBtns) do
        d.btn.Visible = (q == "" or string.find(d.name, q, 1, true))
    end
end)

local detectDropOpen = false
detectPetBtn.MouseButton1Click:Connect(function()
    detectDropOpen = not detectDropOpen
    if detectDropOpen then
        detectDropContent.Visible = true
        detectPetContainer.Size = UDim2.new(1, 0, 0, 244)
        detectPetBtn.Text = "▲  Close"
        detectPetBtn.TextColor3 = Color3.fromRGB(100, 220, 140)
    else
        detectDropContent.Visible = false
        detectPetContainer.Size = UDim2.new(1, 0, 0, 38)
        if detectSelectedPet then
            detectPetBtn.Text = "▼  " .. detectPetDisplayName
            detectPetBtn.TextColor3 = Color3.fromRGB(100, 220, 140)
        else
            detectPetBtn.Text = "▼  Select Pet to Detect"
            detectPetBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
        end
    end
end)

-- --- Range 1 Settings ---
local range1Container = createContainer(18, 50)

local range1TitleLbl = Instance.new("TextLabel")
range1TitleLbl.Size = UDim2.new(1, -10, 0, 14)
range1TitleLbl.Position = UDim2.new(0, 8, 0, 4)
range1TitleLbl.BackgroundTransparency = 1
range1TitleLbl.Text = "Range 1 (kg):"
range1TitleLbl.TextColor3 = Color3.fromRGB(160, 160, 210)
range1TitleLbl.TextSize = 10
range1TitleLbl.Font = Enum.Font.GothamBold
range1TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
range1TitleLbl.Parent = range1Container

local r1MinLbl = Instance.new("TextLabel")
r1MinLbl.Size = UDim2.new(0, 22, 0, 22)
r1MinLbl.Position = UDim2.new(0, 8, 1, -28)
r1MinLbl.BackgroundTransparency = 1
r1MinLbl.Text = "Min:"
r1MinLbl.TextColor3 = Color3.fromRGB(180, 180, 210)
r1MinLbl.TextSize = 10
r1MinLbl.Font = Enum.Font.Gotham
r1MinLbl.Parent = range1Container

local r1MinInput = Instance.new("TextBox")
r1MinInput.Size = UDim2.new(0, 54, 0, 22)
r1MinInput.Position = UDim2.new(0, 34, 1, -28)
r1MinInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
r1MinInput.BorderSizePixel = 0
r1MinInput.Text = "0.1"
r1MinInput.TextColor3 = Color3.fromRGB(220, 220, 240)
r1MinInput.TextSize = 11
r1MinInput.Font = Enum.Font.GothamBold
r1MinInput.PlaceholderText = "0.1"
r1MinInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
r1MinInput.ClearTextOnFocus = false
r1MinInput.Parent = range1Container

local r1MinCorner = Instance.new("UICorner")
r1MinCorner.CornerRadius = UDim.new(0, 4)
r1MinCorner.Parent = r1MinInput

local r1MaxLbl = Instance.new("TextLabel")
r1MaxLbl.Size = UDim2.new(0, 26, 0, 22)
r1MaxLbl.Position = UDim2.new(0, 100, 1, -28)
r1MaxLbl.BackgroundTransparency = 1
r1MaxLbl.Text = "Max:"
r1MaxLbl.TextColor3 = Color3.fromRGB(180, 180, 210)
r1MaxLbl.TextSize = 10
r1MaxLbl.Font = Enum.Font.Gotham
r1MaxLbl.Parent = range1Container

local r1MaxInput = Instance.new("TextBox")
r1MaxInput.Size = UDim2.new(0, 54, 0, 22)
r1MaxInput.Position = UDim2.new(0, 130, 1, -28)
r1MaxInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
r1MaxInput.BorderSizePixel = 0
r1MaxInput.Text = "1.99"
r1MaxInput.TextColor3 = Color3.fromRGB(220, 220, 240)
r1MaxInput.TextSize = 11
r1MaxInput.Font = Enum.Font.GothamBold
r1MaxInput.PlaceholderText = "1.99"
r1MaxInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
r1MaxInput.ClearTextOnFocus = false
r1MaxInput.Parent = range1Container

local r1MaxCorner = Instance.new("UICorner")
r1MaxCorner.CornerRadius = UDim.new(0, 4)
r1MaxCorner.Parent = r1MaxInput

r1MinInput:GetPropertyChangedSignal("Text"):Connect(function()
    local v = tonumber(r1MinInput.Text)
    if v then detectR1Min = v end
end)
r1MaxInput:GetPropertyChangedSignal("Text"):Connect(function()
    local v = tonumber(r1MaxInput.Text)
    if v then detectR1Max = v end
end)

-- --- Range 2 Settings ---
local range2Container = createContainer(19, 50)

local range2TitleLbl = Instance.new("TextLabel")
range2TitleLbl.Size = UDim2.new(1, -10, 0, 14)
range2TitleLbl.Position = UDim2.new(0, 8, 0, 4)
range2TitleLbl.BackgroundTransparency = 1
range2TitleLbl.Text = "Range 2 (kg):"
range2TitleLbl.TextColor3 = Color3.fromRGB(160, 160, 210)
range2TitleLbl.TextSize = 10
range2TitleLbl.Font = Enum.Font.GothamBold
range2TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
range2TitleLbl.Parent = range2Container

local r2MinLbl = Instance.new("TextLabel")
r2MinLbl.Size = UDim2.new(0, 22, 0, 22)
r2MinLbl.Position = UDim2.new(0, 8, 1, -28)
r2MinLbl.BackgroundTransparency = 1
r2MinLbl.Text = "Min:"
r2MinLbl.TextColor3 = Color3.fromRGB(180, 180, 210)
r2MinLbl.TextSize = 10
r2MinLbl.Font = Enum.Font.Gotham
r2MinLbl.Parent = range2Container

local r2MinInput = Instance.new("TextBox")
r2MinInput.Size = UDim2.new(0, 54, 0, 22)
r2MinInput.Position = UDim2.new(0, 34, 1, -28)
r2MinInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
r2MinInput.BorderSizePixel = 0
r2MinInput.Text = "2.0"
r2MinInput.TextColor3 = Color3.fromRGB(220, 220, 240)
r2MinInput.TextSize = 11
r2MinInput.Font = Enum.Font.GothamBold
r2MinInput.PlaceholderText = "2.0"
r2MinInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
r2MinInput.ClearTextOnFocus = false
r2MinInput.Parent = range2Container

local r2MinCorner = Instance.new("UICorner")
r2MinCorner.CornerRadius = UDim.new(0, 4)
r2MinCorner.Parent = r2MinInput

local r2MaxLbl = Instance.new("TextLabel")
r2MaxLbl.Size = UDim2.new(0, 26, 0, 22)
r2MaxLbl.Position = UDim2.new(0, 100, 1, -28)
r2MaxLbl.BackgroundTransparency = 1
r2MaxLbl.Text = "Max:"
r2MaxLbl.TextColor3 = Color3.fromRGB(180, 180, 210)
r2MaxLbl.TextSize = 10
r2MaxLbl.Font = Enum.Font.Gotham
r2MaxLbl.Parent = range2Container

local r2MaxInput = Instance.new("TextBox")
r2MaxInput.Size = UDim2.new(0, 54, 0, 22)
r2MaxInput.Position = UDim2.new(0, 130, 1, -28)
r2MaxInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
r2MaxInput.BorderSizePixel = 0
r2MaxInput.Text = "2.99"
r2MaxInput.TextColor3 = Color3.fromRGB(220, 220, 240)
r2MaxInput.TextSize = 11
r2MaxInput.Font = Enum.Font.GothamBold
r2MaxInput.PlaceholderText = "2.99"
r2MaxInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
r2MaxInput.ClearTextOnFocus = false
r2MaxInput.Parent = range2Container

local r2MaxCorner = Instance.new("UICorner")
r2MaxCorner.CornerRadius = UDim.new(0, 4)
r2MaxCorner.Parent = r2MaxInput

r2MinInput:GetPropertyChangedSignal("Text"):Connect(function()
    local v = tonumber(r2MinInput.Text)
    if v then detectR2Min = v end
end)
r2MaxInput:GetPropertyChangedSignal("Text"):Connect(function()
    local v = tonumber(r2MaxInput.Text)
    if v then detectR2Max = v end
end)

-- --- Detect Result Display ---
local detectResultContainer = createContainer(20, 68)

local detectLine1 = Instance.new("TextLabel")
detectLine1.Size = UDim2.new(1, -16, 0, 24)
detectLine1.Position = UDim2.new(0, 8, 0, 8)
detectLine1.BackgroundTransparency = 1
detectLine1.Text = "[---] 0.1 - 1.99kg = 0 pet"
detectLine1.TextColor3 = Color3.fromRGB(100, 220, 200)
detectLine1.TextSize = 11
detectLine1.Font = Enum.Font.GothamBold
detectLine1.TextXAlignment = Enum.TextXAlignment.Left
detectLine1.TextTruncate = Enum.TextTruncate.AtEnd
detectLine1.Parent = detectResultContainer

local detectLine2 = Instance.new("TextLabel")
detectLine2.Size = UDim2.new(1, -16, 0, 24)
detectLine2.Position = UDim2.new(0, 8, 0, 36)
detectLine2.BackgroundTransparency = 1
detectLine2.Text = "[---] 2.0 - 2.99kg = 0 pet"
detectLine2.TextColor3 = Color3.fromRGB(100, 200, 255)
detectLine2.TextSize = 11
detectLine2.Font = Enum.Font.GothamBold
detectLine2.TextXAlignment = Enum.TextXAlignment.Left
detectLine2.TextTruncate = Enum.TextTruncate.AtEnd
detectLine2.Parent = detectResultContainer

-- --- Detect Scan + Toggle ---
local detectBtnContainer = createContainer(21, 38)
detectBtnContainer.BackgroundTransparency = 1

local detectScanBtn = Instance.new("TextButton")
detectScanBtn.Size = UDim2.new(0.55, -4, 0, 28)
detectScanBtn.Position = UDim2.new(0, 0, 0, 5)
detectScanBtn.BackgroundColor3 = Color3.fromRGB(50, 80, 180)
detectScanBtn.BorderSizePixel = 0
detectScanBtn.Text = "🔍 Auto Scan: OFF"
detectScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
detectScanBtn.TextSize = 10
detectScanBtn.Font = Enum.Font.GothamBold
detectScanBtn.Parent = detectBtnContainer

local detectScanBtnCorner = Instance.new("UICorner")
detectScanBtnCorner.CornerRadius = UDim.new(0, 6)
detectScanBtnCorner.Parent = detectScanBtn

local detectManualBtn = Instance.new("TextButton")
detectManualBtn.Size = UDim2.new(0.45, -4, 0, 28)
detectManualBtn.Position = UDim2.new(0.55, 4, 0, 5)
detectManualBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
detectManualBtn.BorderSizePixel = 0
detectManualBtn.Text = "↻ Scan Now"
detectManualBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
detectManualBtn.TextSize = 10
detectManualBtn.Font = Enum.Font.GothamBold
detectManualBtn.Parent = detectBtnContainer

local detectManualBtnCorner = Instance.new("UICorner")
detectManualBtnCorner.CornerRadius = UDim.new(0, 6)
detectManualBtnCorner.Parent = detectManualBtn

-- ========== DETECT LOGIC ==========
local function getBasePetNameDetect(item)
    local baseName = item:GetAttribute("f")
    if not baseName then
        local fullName = item.Name
        baseName = fullName:match("^(.-)%s*%[")
        if not baseName then baseName = fullName end
        baseName = baseName:match("^%s*(.-)%s*$")
    end
    return baseName
end

local function getPetWeight(item)
    local fullName = item.Name
    return tonumber(fullName:match("%[([%d%.]+)%s*KG%]")) or 0
end

local function runDetectScan()
    if not detectSelectedPet then
        detectLine1.Text = "[No pet selected] - - = - pet"
        detectLine2.Text = "[No pet selected] - - = - pet"
        return
    end

    local backpack = LocalPlayer.Backpack
    local count1 = 0
    local count2 = 0
    local lowerDetect = string.lower(detectSelectedPet)

    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            local baseName = getBasePetNameDetect(item)
            local weight = getPetWeight(item)
            if string.find(string.lower(baseName), lowerDetect, 1, true) then
                if weight >= detectR1Min and weight <= detectR1Max then
                    count1 = count1 + 1
                end
                if weight >= detectR2Min and weight <= detectR2Max then
                    count2 = count2 + 1
                end
            end
        end
    end

    local r1MinStr = tostring(detectR1Min)
    local r1MaxStr = tostring(detectR1Max)
    local r2MinStr = tostring(detectR2Min)
    local r2MaxStr = tostring(detectR2Max)
    local shortName = detectSelectedPet

    detectLine1.Text = string.format("[%s] %s - %skg = %d pet", shortName, r1MinStr, r1MaxStr, count1)
    detectLine2.Text = string.format("[%s] %s - %skg = %d pet", shortName, r2MinStr, r2MaxStr, count2)
end

-- Manual scan button
detectManualBtn.MouseButton1Click:Connect(function()
    runDetectScan()
    detectManualBtn.TextColor3 = Color3.fromRGB(100, 220, 140)
    task.delay(0.3, function()
        detectManualBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
    end)
end)

-- Auto scan toggle
detectScanBtn.MouseButton1Click:Connect(function()
    detectScanEnabled = not detectScanEnabled
    if detectScanEnabled then
        detectScanBtn.Text = "🔍 Auto Scan: ON"
        detectScanBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
        if detectScanThread then task.cancel(detectScanThread) end
        detectScanThread = task.spawn(function()
            while detectScanEnabled do
                runDetectScan()
                task.wait(2)
            end
        end)
    else
        detectScanEnabled = false
        detectScanBtn.Text = "🔍 Auto Scan: OFF"
        detectScanBtn.BackgroundColor3 = Color3.fromRGB(50, 80, 180)
        if detectScanThread then
            task.cancel(detectScanThread)
            detectScanThread = nil
        end
    end
end)

-- ========================================================
-- ========== CLOSE & DISABLE ALL BUTTON ==================
-- ========================================================
local closeAllContainer = createContainer(22, 42)

local closeAllBtn = Instance.new("TextButton")
closeAllBtn.Size = UDim2.new(1, -16, 0, 32)
closeAllBtn.Position = UDim2.new(0, 8, 0, 5)
closeAllBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
closeAllBtn.BorderSizePixel = 0
closeAllBtn.Text = "✕  Close & Disable All"
closeAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeAllBtn.TextSize = 12
closeAllBtn.Font = Enum.Font.GothamBold
closeAllBtn.Parent = closeAllContainer

local closeAllCorner = Instance.new("UICorner")
closeAllCorner.CornerRadius = UDim.new(0, 6)
closeAllCorner.Parent = closeAllBtn

closeAllBtn.MouseButton1Click:Connect(function()
    -- Stop Auto Give
    autoGiveEnabled = false
    if autoGiveThread then
        task.cancel(autoGiveThread)
        autoGiveThread = nil
    end
    -- Stop Auto Accept
    autoAcceptEnabled = false
    if autoAcceptThread then
        task.cancel(autoAcceptThread)
        autoAcceptThread = nil
    end
    -- Stop Detect Scan
    detectScanEnabled = false
    if detectScanThread then
        task.cancel(detectScanThread)
        detectScanThread = nil
    end
    -- Destroy GUI
    screenGui:Destroy()
end)

-- ========== CORE LOGIC: AUTO GIVE ==========

local function parsePetName(item)
    local fullName = item.Name
    local weight = tonumber(fullName:match("%[([%d%.]+)%s*KG%]"))
    local age = tonumber(fullName:match("%[Age%s*(%d+)%]"))
    local baseName = item:GetAttribute("f")
    if not baseName then
        baseName = fullName:match("^(.-)%s*%[")
        if not baseName then baseName = fullName end
        baseName = baseName:match("^%s*(.-)%s*$")
    end
    return baseName, weight or 0, age or 0
end

local function getBasePetName(petListEntry)
    return petListEntry:match("%]%s*(.+)$") or petListEntry
end

local function passesThreshold(weight, age)
    local wThresh = weightThreshold
    local aThresh = ageThreshold
    if thresholdMode == "above" then
        if wThresh > 0 and weight <= wThresh then return false end
        if aThresh > 0 and age <= aThresh then return false end
    else
        if wThresh > 0 and weight >= wThresh then return false end
        if aThresh > 0 and age >= aThresh then return false end
    end
    return true
end

local function setGiveStatus(msg, color)
    statusLabel.Text = "Give Status: " .. msg
    statusLabel.TextColor3 = color or Color3.fromRGB(160, 160, 200)
end

local function doAutoGive()
    if not selectedPlayer then
        setGiveStatus("No player selected!", Color3.fromRGB(220, 80, 80))
        return
    end

    local targetPlayer = Players:FindFirstChild(selectedPlayer)
    if not targetPlayer then
        setGiveStatus("Player not found: " .. selectedPlayer, Color3.fromRGB(220, 80, 80))
        return
    end

    local selectedBasePetNames = {}
    for petEntry, isSelected in pairs(selectedPets) do
        if isSelected then
            local baseName = getBasePetName(petEntry)
            selectedBasePetNames[baseName] = true
        end
    end

    if next(selectedBasePetNames) == nil then
        setGiveStatus("No pets selected!", Color3.fromRGB(220, 80, 80))
        return
    end

    local backpack = LocalPlayer.Backpack
    local given = 0

    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            local baseName, weight, age = parsePetName(item)
            local isMatch = selectedBasePetNames[baseName]
            if not isMatch then
                for selectedPet, _ in pairs(selectedBasePetNames) do
                    if string.find(string.lower(baseName), string.lower(selectedPet), 1, true) then
                        isMatch = true
                        break
                    end
                end
            end

            if isMatch and passesThreshold(weight, age) then
                LocalPlayer.Character.Humanoid:EquipTool(item)
                task.wait(0.2)
                local args = {[1] = "GivePet", [2] = targetPlayer}
                remote:FireServer(unpack(args))
                given = given + 1
                setGiveStatus(string.format("Gave %s to %s (%d given)", baseName, selectedPlayer, given), Color3.fromRGB(100, 220, 140))
                task.wait(0.5)
            end
        end
    end

    if given == 0 then
        setGiveStatus("No matching pets found in backpack.", Color3.fromRGB(200, 160, 60))
    end
end

startStopBtn.MouseButton1Click:Connect(function()
    if autoGiveEnabled then
        autoGiveEnabled = false
        if autoGiveThread then
            task.cancel(autoGiveThread)
            autoGiveThread = nil
        end
        startStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
        startStopBtn.Text = "▶  Start Auto Give"
        setGiveStatus("Stopped.", Color3.fromRGB(200, 160, 60))
    else
        autoGiveEnabled = true
        startStopBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        startStopBtn.Text = "■  Stop Auto Give"
        setGiveStatus("Running...", Color3.fromRGB(100, 220, 140))
        autoGiveThread = task.spawn(function()
            while autoGiveEnabled do
                doAutoGive()
                task.wait(1)
            end
        end)
    end
end)

-- ========== CORE LOGIC: AUTO ACCEPT GIVE ==========

local function setAcceptStatus(msg, color)
    acceptStatusLabel.Text = "Accept Status: " .. msg
    acceptStatusLabel.TextColor3 = color or Color3.fromRGB(160, 160, 200)
end

local function clickGUIButton(button)
    if firesignal then
        firesignal(button.MouseButton1Click)
    elseif getconnections then
        for _, conn in ipairs(getconnections(button.MouseButton1Click)) do
            conn:Fire()
        end
    else
        game:GetService("VirtualUser"):ClickButton(button)
    end
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
                    setAcceptStatus("Accepting gift...", Color3.fromRGB(100, 220, 140))
                    clickGUIButton(acceptBtn)
                    setAcceptStatus("Waiting for completion...", Color3.fromRGB(200, 160, 60))
                    local timeout = tick() + 0.1
                    local success = false
                    while autoAcceptEnabled and tick() < timeout do
                        local topNotif = pGui:FindFirstChild("Top_Notification")
                        if topNotif and topNotif:FindFirstChild("Frame") then
                            local notifUI = topNotif.Frame:FindFirstChild("Notification_UI")
                            if notifUI and notifUI:GetAttribute("OG") == "Trade completed!" then
                                success = true
                                break
                            end
                        end
                        task.wait(0.1)
                    end
                    if success then
                        setAcceptStatus("Trade Completed!", Color3.fromRGB(100, 220, 140))
                        task.wait(0.0)
                    else
                        setAcceptStatus("Timeout waiting for completion.", Color3.fromRGB(220, 80, 80))
                        task.wait(0.1)
                    end
                end
            end
        end
    else
        setAcceptStatus("Waiting for gift...", Color3.fromRGB(160, 160, 200))
    end
end

acceptStartStopBtn.MouseButton1Click:Connect(function()
    if autoAcceptEnabled then
        autoAcceptEnabled = false
        if autoAcceptThread then
            task.cancel(autoAcceptThread)
            autoAcceptThread = nil
        end
        acceptStartStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
        acceptStartStopBtn.Text = "▶  Start Auto Accept"
        setAcceptStatus("Stopped.", Color3.fromRGB(200, 160, 60))
    else
        autoAcceptEnabled = true
        acceptStartStopBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        acceptStartStopBtn.Text = "■  Stop Auto Accept"
        setAcceptStatus("Running...", Color3.fromRGB(100, 220, 140))
        autoAcceptThread = task.spawn(function()
            while autoAcceptEnabled do
                doAutoAccept()
                task.wait(0.5)
            end
        end)
    end
end)

-- ========== CANVAS SIZE AUTO UPDATE ==========
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
end)

-- ========== TOGGLE VISIBILITY ==========
toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- ========== DRAG (Touch & Mouse) ==========
local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

print("[AutoGivePet] Script loaded! Tap '🐾 AutoGive' to open.")
