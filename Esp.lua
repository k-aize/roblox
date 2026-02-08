-- SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- SETTINGS
local ESPEnabled = true
local TeamCheck = true

-- TEAM COLORS (AUTO)
local function GetTeamColor(player)
	if player.Team and player.Team.TeamColor then
		return player.Team.TeamColor.Color
	end
	return Color3.fromRGB(255,255,255)
end

-- TABLE
local ESPObjects = {}

--------------------------------------------------
-- UI MENU
--------------------------------------------------
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ESP_UI"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 260, 0, 160)
Main.Position = UDim2.new(0, 40, 0, 200)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- TOP BAR
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,30)
Top.BackgroundColor3 = Color3.fromRGB(35,35,35)
Top.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,-90,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.Text = "ESP MENU"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Left

-- BUTTONS
local MinBtn = Instance.new("TextButton", Top)
MinBtn.Size = UDim2.new(0,30,1,0)
MinBtn.Position = UDim2.new(1,-60,0,0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinBtn.TextColor3 = Color3.new(1,1,1)

local CloseBtn = Instance.new("TextButton", Top)
CloseBtn.Size = UDim2.new(0,30,1,0)
CloseBtn.Position = UDim2.new(1,-30,0,0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
CloseBtn.TextColor3 = Color3.new(1,1,1)

-- CONTENT
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1,0,1,-30)
Content.Position = UDim2.new(0,0,0,30)
Content.BackgroundTransparency = 1

local function CreateToggle(text, posY, callback)
	local btn = Instance.new("TextButton", Content)
	btn.Size = UDim2.new(1,-20,0,35)
	btn.Position = UDim2.new(0,10,0,posY)
	btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BorderSizePixel = 0
	btn.Text = text

	btn.MouseButton1Click:Connect(callback)
	return btn
end

local ESPBtn = CreateToggle("ESP : ON", 10, function()
	ESPEnabled = not ESPEnabled
	ESPBtn.Text = "ESP : " .. (ESPEnabled and "ON" or "OFF")

	for _, objs in pairs(ESPObjects) do
		for _, o in pairs(objs) do
			o.Enabled = ESPEnabled
		end
	end
end)

local TeamBtn = CreateToggle("TEAM CHECK : ON", 55, function()
	TeamCheck = not TeamCheck
	TeamBtn.Text = "TEAM CHECK : " .. (TeamCheck and "ON" or "OFF")
end)

-- MINIMIZE
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	Content.Visible = not minimized
	Main.Size = minimized and UDim2.new(0,260,0,30) or UDim2.new(0,260,0,160)
end)

-- CLOSE
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

--------------------------------------------------
-- ESP FUNCTIONS
--------------------------------------------------
local function CreateESP(player)
	if player == LocalPlayer then return end

	local function Setup(char)
		if ESPObjects[player] then return end

		-- TEAM CHECK
		if TeamCheck and player.Team == LocalPlayer.Team then return end

		-- HIGHLIGHT
		local highlight = Instance.new("Highlight", char)
		highlight.FillTransparency = 1
		highlight.OutlineColor = GetTeamColor(player)

		-- NAME TAG
		local head = char:WaitForChild("Head")
		local gui = Instance.new("BillboardGui", head)
		gui.Size = UDim2.new(0,120,0,30)
		gui.StudsOffset = Vector3.new(0,2,0)
		gui.AlwaysOnTop = true

		local txt = Instance.new("TextLabel", gui)
		txt.Size = UDim2.new(1,0,1,0)
		txt.BackgroundTransparency = 1
		txt.Text = player.Name
		txt.TextScaled = true
		txt.TextStrokeTransparency = 0
		txt.TextColor3 = highlight.OutlineColor

		ESPObjects[player] = {highlight, gui}
	end

	if player.Character then
		Setup(player.Character)
	end

	player.CharacterAdded:Connect(Setup)
end

local function RemoveESP(player)
	if ESPObjects[player] then
		for _, v in pairs(ESPObjects[player]) do
			v:Destroy()
		end
		ESPObjects[player] = nil
	end
end

-- PLAYER HANDLER
for _, p in pairs(Players:GetPlayers()) do
	CreateESP(p)
end

Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)
