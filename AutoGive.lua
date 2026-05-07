-- Auto Give Pet Script (FIXED & ADDED AUTO ACCEPT + DESTROY MENU)
-- UI: Toggle Menu, Dropdown + Search Multi-Select Pets, Select Player, Weight/Age Threshold Filter, Auto Accept, Close Script

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
local thresholdMode = "above" -- "above" or "below"
local weightThreshold = 0
local ageThreshold = 0
local autoGiveEnabled = false
local autoGiveThread = nil

local autoAcceptEnabled = false
local autoAcceptThread = nil

-- ========== GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoGivePetGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game:GetService("CoreGui")

-- Toggle Button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 120, 0, 36)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -18)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "🐾 AutoGive"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 14
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleBtn

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 560)
mainFrame.Position = UDim2.new(0, 140, 0.5, -280)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 44)
titleBar.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 12)
titleBarCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -44, 1, 0)
titleLabel.Position = UDim2.new(0, 14, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🐾 Auto Give Pet"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 15
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 13
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 6)
closeBtnCorner.Parent = closeBtn

-- Scrollable Content
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -44)
scrollFrame.Position = UDim2.new(0, 0, 0, 44)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 160)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

local listPadding = Instance.new("UIPadding")
listPadding.PaddingLeft = UDim.new(0, 12)
listPadding.PaddingRight = UDim.new(0, 12)
listPadding.PaddingTop = UDim.new(0, 10)
listPadding.PaddingBottom = UDim.new(0, 10)
listPadding.Parent = scrollFrame

-- Helper: Create section label
local function sectionLabel(text, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(160, 160, 200)
    lbl.TextSize = 12
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

-- ========== SECTION: SELECT PETS (Dropdown + Search) ==========
sectionLabel("SELECT PETS", 1)

local petMainContainer = createContainer(2, 44)

local petDropdownBtn = Instance.new("TextButton")
petDropdownBtn.Size = UDim2.new(1, -20, 0, 34)
petDropdownBtn.Position = UDim2.new(0, 10, 0, 5)
petDropdownBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
petDropdownBtn.BorderSizePixel = 0
petDropdownBtn.Text = "▼  Select Pets"
petDropdownBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
petDropdownBtn.TextSize = 13
petDropdownBtn.Font = Enum.Font.Gotham
petDropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
petDropdownBtn.Parent = petMainContainer

local petDpCorner = Instance.new("UICorner")
petDpCorner.CornerRadius = UDim.new(0, 6)
petDpCorner.Parent = petDropdownBtn

local petDpPadding = Instance.new("UIPadding")
petDpPadding.PaddingLeft = UDim.new(0, 10)
petDpPadding.Parent = petDropdownBtn

-- Pet Dropdown Content
local petDropContent = Instance.new("Frame")
petDropContent.Name = "PetDropContent"
petDropContent.Size = UDim2.new(1, -20, 0, 240)
petDropContent.Position = UDim2.new(0, 10, 0, 44)
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
petSearchBox.Size = UDim2.new(1, -12, 0, 30)
petSearchBox.Position = UDim2.new(0, 6, 0, 6)
petSearchBox.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
petSearchBox.BorderSizePixel = 0
petSearchBox.Text = ""
petSearchBox.PlaceholderText = "🔍 Search Pet..."
petSearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 150)
petSearchBox.TextColor3 = Color3.fromRGB(220, 220, 240)
petSearchBox.TextSize = 13
petSearchBox.Font = Enum.Font.Gotham
petSearchBox.ClearTextOnFocus = false
petSearchBox.Parent = petDropContent

local petSearchCorner = Instance.new("UICorner")
petSearchCorner.CornerRadius = UDim.new(0, 5)
petSearchCorner.Parent = petSearchBox

local petSearchPadding = Instance.new("UIPadding")
petSearchPadding.PaddingLeft = UDim.new(0, 10)
petSearchPadding.Parent = petSearchBox

-- Pet Scrolling List
local petScrollFrame = Instance.new("ScrollingFrame")
petScrollFrame.Size = UDim2.new(1, -12, 1, -44)
petScrollFrame.Position = UDim2.new(0, 6, 0, 40)
petScrollFrame.BackgroundTransparency = 1
petScrollFrame.BorderSizePixel = 0
petScrollFrame.ScrollBarThickness = 4
petScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 160)
petScrollFrame.Parent = petDropContent

local petListLayout2 = Instance.new("UIListLayout")
petListLayout2.FillDirection = Enum.FillDirection.Vertical
petListLayout2.Padding = UDim.new(0, 4)
petListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
petListLayout2.Parent = petScrollFrame

local petCheckboxes = {}

for i, petName in ipairs(PET_LIST) do
    local petBtn = Instance.new("TextButton")
    petBtn.Size = UDim2.new(1, -8, 0, 34)
    petBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    petBtn.BorderSizePixel = 0
    petBtn.LayoutOrder = i
    petBtn.Parent = petScrollFrame

    local petBtnCorner = Instance.new("UICorner")
    petBtnCorner.CornerRadius = UDim.new(0, 6)
    petBtnCorner.Parent = petBtn

    local checkIcon = Instance.new("TextLabel")
    checkIcon.Size = UDim2.new(0, 20, 0, 20)
    checkIcon.Position = UDim2.new(0, 8, 0.5, -10)
    checkIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    checkIcon.BorderSizePixel = 0
    checkIcon.Text = ""
    checkIcon.TextColor3 = Color3.fromRGB(100, 200, 100)
    checkIcon.TextSize = 13
    checkIcon.Font = Enum.Font.GothamBold
    checkIcon.Parent = petBtn

    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 4)
    checkCorner.Parent = checkIcon

    local petLabel = Instance.new("TextLabel")
    petLabel.Size = UDim2.new(1, -40, 1, 0)
    petLabel.Position = UDim2.new(0, 36, 0, 0)
    petLabel.BackgroundTransparency = 1
    petLabel.Text = petName
    petLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
    petLabel.TextSize = 12
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

-- Update scroll height dynamically
petListLayout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    petScrollFrame.CanvasSize = UDim2.new(0, 0, 0, petListLayout2.AbsoluteContentSize.Y + 10)
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
        petMainContainer.Size = UDim2.new(1, 0, 0, 290)
        petDropdownBtn.Text = "▲  Close Pet Selection"
        petDropdownBtn.TextColor3 = Color3.fromRGB(100, 220, 140)
    else
        petDropContent.Visible = false
        petMainContainer.Size = UDim2.new(1, 0, 0, 44)
        petDropdownBtn.Text = "▼  Select Pets"
        petDropdownBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
    end
end)

-- ========== SECTION: SELECT PLAYER ==========
sectionLabel("SELECT PLAYER", 3)

local playerContainer = createContainer(4, 44)

local playerDropdownBtn = Instance.new("TextButton")
playerDropdownBtn.Size = UDim2.new(1, -20, 0, 34)
playerDropdownBtn.Position = UDim2.new(0, 10, 0, 5)
playerDropdownBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
playerDropdownBtn.BorderSizePixel = 0
playerDropdownBtn.Text = "▼  Select Options"
playerDropdownBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
playerDropdownBtn.TextSize = 13
playerDropdownBtn.Font = Enum.Font.Gotham
playerDropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
playerDropdownBtn.Parent = playerContainer

local dpCorner = Instance.new("UICorner")
dpCorner.CornerRadius = UDim.new(0, 6)
dpCorner.Parent = playerDropdownBtn

local dpPadding = Instance.new("UIPadding")
dpPadding.PaddingLeft = UDim.new(0, 10)
dpPadding.Parent = playerDropdownBtn

local playerDropList = Instance.new("Frame")
playerDropList.Name = "PlayerDropList"
playerDropList.Size = UDim2.new(1, -20, 0, 0)
playerDropList.Position = UDim2.new(0, 10, 0, 44)
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
dpListPadding.PaddingLeft = UDim.new(0, 6)
dpListPadding.PaddingRight = UDim.new(0, 6)
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
        noPlayers.Size = UDim2.new(1, 0, 0, 30)
        noPlayers.BackgroundTransparency = 1
        noPlayers.Text = "No other players found"
        noPlayers.TextColor3 = Color3.fromRGB(120, 120, 140)
        noPlayers.TextSize = 12
        noPlayers.Font = Enum.Font.Gotham
        noPlayers.Parent = playerDropList
        playerDropList.Size = UDim2.new(1, -20, 0, 38)
        return
    end

    local totalH = 8 + (#otherPlayers * 34) + (#otherPlayers - 1) * 2
    playerDropList.Size = UDim2.new(1, -20, 0, totalH)

    for i, pName in ipairs(otherPlayers) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(1, 0, 0, 30)
        pBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
        pBtn.BorderSizePixel = 0
        pBtn.Text = "  👤 " .. pName
        pBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
        pBtn.TextSize = 13
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
            playerContainer.Size = UDim2.new(1, 0, 0, 44)
        end)
    end
end

playerDropdownBtn.MouseButton1Click:Connect(function()
    if playerDropOpen then
        playerDropList.Visible = false
        playerDropOpen = false
        playerContainer.Size = UDim2.new(1, 0, 0, 44)
    else
        buildPlayerDropdown()
        playerDropList.Visible = true
        playerDropOpen = true
        local listH = playerDropList.Size.Y.Offset
        playerContainer.Size = UDim2.new(1, 0, 0, 44 + listH + 8)
    end
end)

-- Refresh Player Button
sectionLabel("", 5)

local refreshContainer = createContainer(6, 44)

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, 0, 1, 0)
refreshBtn.BackgroundTransparency = 1
refreshBtn.Text = ""
refreshBtn.Parent = refreshContainer

local refreshLabel = Instance.new("TextLabel")
refreshLabel.Size = UDim2.new(1, -54, 1, 0)
refreshLabel.Position = UDim2.new(0, 14, 0, 0)
refreshLabel.BackgroundTransparency = 1
refreshLabel.Text = "Refresh Select Players"
refreshLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
refreshLabel.TextSize = 14
refreshLabel.Font = Enum.Font.GothamBold
refreshLabel.TextXAlignment = Enum.TextXAlignment.Left
refreshLabel.Parent = refreshContainer

local refreshIcon = Instance.new("TextLabel")
refreshIcon.Size = UDim2.new(0, 32, 0, 32)
refreshIcon.Position = UDim2.new(1, -42, 0.5, -16)
refreshIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
refreshIcon.BorderSizePixel = 0
refreshIcon.Text = "↻"
refreshIcon.TextColor3 = Color3.fromRGB(160, 160, 220)
refreshIcon.TextSize = 18
refreshIcon.Font = Enum.Font.GothamBold
refreshIcon.Parent = refreshContainer

local refreshIconCorner = Instance.new("UICorner")
refreshIconCorner.CornerRadius = UDim.new(0, 6)
refreshIconCorner.Parent = refreshIcon

refreshBtn.MouseButton1Click:Connect(function()
    if playerDropOpen then
        playerDropList.Visible = false
        playerDropOpen = false
        playerContainer.Size = UDim2.new(1, 0, 0, 44)
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

local thresholdModeContainer = createContainer(8, 44)

local thresholdModeLabel = Instance.new("TextLabel")
thresholdModeLabel.Size = UDim2.new(0.5, -8, 1, 0)
thresholdModeLabel.Position = UDim2.new(0, 12, 0, 0)
thresholdModeLabel.BackgroundTransparency = 1
thresholdModeLabel.Text = "Threshold Mode"
thresholdModeLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
thresholdModeLabel.TextSize = 13
thresholdModeLabel.Font = Enum.Font.Gotham
thresholdModeLabel.TextXAlignment = Enum.TextXAlignment.Left
thresholdModeLabel.Parent = thresholdModeContainer

local modeToggleFrame = Instance.new("Frame")
modeToggleFrame.Size = UDim2.new(0, 150, 0, 30)
modeToggleFrame.Position = UDim2.new(1, -162, 0.5, -15)
modeToggleFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
modeToggleFrame.BorderSizePixel = 0
modeToggleFrame.Parent = thresholdModeContainer

local modeToggleCorner = Instance.new("UICorner")
modeToggleCorner.CornerRadius = UDim.new(0, 6)
modeToggleCorner.Parent = modeToggleFrame

local aboveBtn = Instance.new("TextButton")
aboveBtn.Size = UDim2.new(0.5, -2, 1, -4)
aboveBtn.Position = UDim2.new(0, 2, 0, 2)
aboveBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
aboveBtn.BorderSizePixel = 0
aboveBtn.Text = "Above"
aboveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aboveBtn.TextSize = 12
aboveBtn.Font = Enum.Font.GothamBold
aboveBtn.Parent = modeToggleFrame

local aboveBtnCorner = Instance.new("UICorner")
aboveBtnCorner.CornerRadius = UDim.new(0, 5)
aboveBtnCorner.Parent = aboveBtn

local belowBtn = Instance.new("TextButton")
belowBtn.Size = UDim2.new(0.5, -2, 1, -4)
belowBtn.Position = UDim2.new(0.5, 0, 0, 2)
belowBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
belowBtn.BorderSizePixel = 0
belowBtn.Text = "Below"
belowBtn.TextColor3 = Color3.fromRGB(160, 160, 200)
belowBtn.TextSize = 12
belowBtn.Font = Enum.Font.Gotham
belowBtn.Parent = modeToggleFrame

local belowBtnCorner = Instance.new("UICorner")
belowBtnCorner.CornerRadius = UDim.new(0, 5)
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
local weightContainer = createContainer(9, 44)

local weightLabel = Instance.new("TextLabel")
weightLabel.Size = UDim2.new(0.55, 0, 1, 0)
weightLabel.Position = UDim2.new(0, 12, 0, 0)
weightLabel.BackgroundTransparency = 1
weightLabel.Text = "⚖ Weight Threshold (KG)"
weightLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
weightLabel.TextSize = 12
weightLabel.Font = Enum.Font.Gotham
weightLabel.TextXAlignment = Enum.TextXAlignment.Left
weightLabel.Parent = weightContainer

local weightInput = Instance.new("TextBox")
weightInput.Size = UDim2.new(0, 70, 0, 28)
weightInput.Position = UDim2.new(1, -82, 0.5, -14)
weightInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
weightInput.BorderSizePixel = 0
weightInput.Text = "0"
weightInput.TextColor3 = Color3.fromRGB(220, 220, 240)
weightInput.TextSize = 13
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
    if val then
        weightThreshold = val
    end
end)

-- Age Threshold Input
local ageContainer = createContainer(10, 44)

local ageLabel = Instance.new("TextLabel")
ageLabel.Size = UDim2.new(0.55, 0, 1, 0)
ageLabel.Position = UDim2.new(0, 12, 0, 0)
ageLabel.BackgroundTransparency = 1
ageLabel.Text = "🎂 Age Threshold"
ageLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
ageLabel.TextSize = 12
ageLabel.Font = Enum.Font.Gotham
ageLabel.TextXAlignment = Enum.TextXAlignment.Left
ageLabel.Parent = ageContainer

local ageInput = Instance.new("TextBox")
ageInput.Size = UDim2.new(0, 70, 0, 28)
ageInput.Position = UDim2.new(1, -82, 0.5, -14)
ageInput.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
ageInput.BorderSizePixel = 0
ageInput.Text = "0"
ageInput.TextColor3 = Color3.fromRGB(220, 220, 240)
ageInput.TextSize = 13
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
    if val then
        ageThreshold = val
    end
end)

-- ========== STATUS LABEL (AUTO GIVE) ==========
local statusContainer = createContainer(11, 36)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 1, 0)
statusLabel.Position = UDim2.new(0, 10, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Give Status: Idle"
statusLabel.TextColor3 = Color3.fromRGB(160, 160, 200)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = statusContainer

-- ========== START/STOP BUTTON (AUTO GIVE) ==========
local startStopContainer = createContainer(12, 44)

local startStopBtn = Instance.new("TextButton")
startStopBtn.Size = UDim2.new(1, -20, 0, 34)
startStopBtn.Position = UDim2.new(0, 10, 0, 5)
startStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
startStopBtn.BorderSizePixel = 0
startStopBtn.Text = "▶  Start Auto Give"
startStopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startStopBtn.TextSize = 14
startStopBtn.Font = Enum.Font.GothamBold
startStopBtn.Parent = startStopContainer

local startStopCorner = Instance.new("UICorner")
startStopCorner.CornerRadius = UDim.new(0, 6)
startStopCorner.Parent = startStopBtn

-- ========== SECTION: AUTO ACCEPT GIVE ==========
sectionLabel("AUTO ACCEPT GIVE", 13)

local acceptStatusContainer = createContainer(14, 36)

local acceptStatusLabel = Instance.new("TextLabel")
acceptStatusLabel.Size = UDim2.new(1, -20, 1, 0)
acceptStatusLabel.Position = UDim2.new(0, 10, 0, 0)
acceptStatusLabel.BackgroundTransparency = 1
acceptStatusLabel.Text = "Accept Status: Idle"
acceptStatusLabel.TextColor3 = Color3.fromRGB(160, 160, 200)
acceptStatusLabel.TextSize = 12
acceptStatusLabel.Font = Enum.Font.Gotham
acceptStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
acceptStatusLabel.Parent = acceptStatusContainer

local acceptStartStopContainer = createContainer(15, 44)

local acceptStartStopBtn = Instance.new("TextButton")
acceptStartStopBtn.Size = UDim2.new(1, -20, 0, 34)
acceptStartStopBtn.Position = UDim2.new(0, 10, 0, 5)
acceptStartStopBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
acceptStartStopBtn.BorderSizePixel = 0
acceptStartStopBtn.Text = "▶  Start Auto Accept"
acceptStartStopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
acceptStartStopBtn.TextSize = 14
acceptStartStopBtn.Font = Enum.Font.GothamBold
acceptStartStopBtn.Parent = acceptStartStopContainer

local acceptStartStopCorner = Instance.new("UICorner")
acceptStartStopCorner.CornerRadius = UDim.new(0, 6)
acceptStartStopCorner.Parent = acceptStartStopBtn

-- ========== SECTION: DESTROY GUI / CLOSE ALL ==========
sectionLabel("DANGER ZONE", 16)

local destroyContainer = createContainer(17, 44)

local destroyBtn = Instance.new("TextButton")
destroyBtn.Size = UDim2.new(1, -20, 0, 34)
destroyBtn.Position = UDim2.new(0, 10, 0, 5)
destroyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
destroyBtn.BorderSizePixel = 0
destroyBtn.Text = "✖  Close Menu & Stop All"
destroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
destroyBtn.TextSize = 14
destroyBtn.Font = Enum.Font.GothamBold
destroyBtn.Parent = destroyContainer

local destroyCorner = Instance.new("UICorner")
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = destroyBtn


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

                local args = {
                    [1] = "GivePet",
                    [2] = targetPlayer
                }
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

-- Helper safe-click kompatibel untuk script executor
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

    -- Deteksi UI Gift
    local giftNotif = pGui:FindFirstChild("Gift_Notification")
    if giftNotif and giftNotif:FindFirstChild("Frame") and giftNotif.Frame:FindFirstChild("Gift_Notification") then
        local mainGiftFrame = giftNotif.Frame.Gift_Notification
        
        if mainGiftFrame.Visible then
            local holder = mainGiftFrame:FindFirstChild("Holder")
            if holder and holder:FindFirstChild("Frame") then
                local acceptBtn = holder.Frame:FindFirstChild("Accept")
                
                if acceptBtn and acceptBtn:IsA("GuiButton") then
                    setAcceptStatus("Accepting gift...", Color3.fromRGB(100, 220, 140))
                    
                    -- Click accept
                    clickGUIButton(acceptBtn)
                    
                    -- Tunggu konfirmasi trade completed
                    setAcceptStatus("Waiting for completion...", Color3.fromRGB(200, 160, 60))
                    local timeout = tick() + 3 -- maksimal tunggu 3 detik sebelum reset loop
                    local success = false
                    
                    while autoAcceptEnabled and tick() < timeout do
                        local topNotif = pGui:FindFirstChild("Top_Notification")
                        if topNotif and topNotif:FindFirstChild("Frame") then
                            
                            -- Melakukan loop untuk mengecek SEMUA children Notification_UI yang ada
                            for _, child in ipairs(topNotif.Frame:GetChildren()) do
                                if child.Name == "Notification_UI" and child:GetAttribute("OG") == "Trade completed!" then
                                    success = true
                                    break
                                end
                            end
                            
                        end
                        if success then break end
                        task.wait(0.1)
                    end
                    
                    if success then
                        setAcceptStatus("Trade Completed!", Color3.fromRGB(100, 220, 140))
                        task.wait(0.1) -- Beri waktu sebentar sebelum menerima gift yang selanjutnya
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

-- LOGIC UNTUK TOMBOL CLOSE SCRIPT 
destroyBtn.MouseButton1Click:Connect(function()
    -- Mematikan Auto Give
    autoGiveEnabled = false
    if autoGiveThread then
        task.cancel(autoGiveThread)
        autoGiveThread = nil
    end

    -- Mematikan Auto Accept
    autoAcceptEnabled = false
    if autoAcceptThread then
        task.cancel(autoAcceptThread)
        autoAcceptThread = nil
    end

    -- Menghancurkan UI dari layar
    if screenGui then
        screenGui:Destroy()
    end
    print("[AutoGivePet] Script completely closed & features stopped.")
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

-- ========== DRAG ==========
local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    if input.UserInputType == Enum.UserInputType.MouseMovement then
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

print("[AutoGivePet] Script loaded! Click '🐾 AutoGive' to open.")
