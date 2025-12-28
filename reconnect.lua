local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlaceId = game.PlaceId

game:GetService("GuiService").ErrorMessageChanged:Connect(function()
    TeleportService:Teleport(PlaceId, Player)
end)

Player.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Failed or State == Enum.TeleportState.InProgress then
        TeleportService:Teleport(PlaceId, Player)
    end
end)
