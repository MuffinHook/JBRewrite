local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DrownUtils = require(ReplicatedStorage.Drown.DrownUtils)
local ProgressBar = require(ReplicatedStorage.Drown.UI.ProgressBar)
local Roact = require(ReplicatedStorage.Roact)
require(ReplicatedStorage.Std.CharacterUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local PlayerUtils = require(ReplicatedStorage.Std.PlayerUtils)
local createElement = Roact.createElement
local function getComponent()
	local drownPercent = DrownUtils.getDrownPercent(Players.LocalPlayer) or 0
	local Character = Players.LocalPlayer.Character
	if Character then
		local Head = Character:WaitForChild("Head")
		local progressBarElement = if drownPercent > 0 then createElement(ProgressBar, {
	aspectRatio = 0.5,
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0, 0),
	progress = 1 - drownPercent,
	text = "",
	filledColor = Color3.fromHex("5fcbfa"),
	unfilledColor = Color3.new(0/255, 0/255, 0/255),
	barStrokeThickness = 2
}) else nil
		return createElement("BillboardGui", {
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			Adornee = Head,
			Active = true,
			ResetOnSpawn = true,
			Size = UDim2.fromScale(5.25, 0.4),
			ExtentsOffset = Vector3.new(0, 3, 0),
			AlwaysOnTop = true
		}, {
			ProgressBar = progressBarElement
		})
	else
		return createElement("Frame", {
			Active = false,
			Visible = false
		})
	end
end
local guiInstance = Roact.mount(getComponent(), Players.LocalPlayer.PlayerGui, "DrownGui")
local function updateUI()
	Roact.update(guiInstance, getComponent())
end
DrownUtils.getDrownPercentChangedSignal(Players.LocalPlayer):Connect(updateUI)
Players.LocalPlayer.CharacterAdded:Connect(updateUI)
Roact.update(guiInstance, getComponent())
local function playerAdded(player)
	local playerMaid = PlayerUtils.getPlayerMaid(player)
	local function cleanUp()
		playerMaid.drowningParticlesMaid = nil
	end
	local function updateBubbles()
		if DrownUtils.getIsPlayerDrowning(player) then
			local Character = player.Character
			if Character then
				local Head = Character:FindFirstChild("Head")
				if Head then
					if not playerMaid.drowningParticlesMaid then
						playerMaid.drowningParticlesMaid = Maid.new()
						local airBubbles = ReplicatedStorage.Drown.Res.AirBubbles:Clone()
						airBubbles.Rate = 100
						playerMaid.drowningParticlesMaid:GiveTask(airBubbles)
						airBubbles.Parent = Head
					end
				else
					playerMaid.drowningParticlesMaid = nil
				end
			else
				playerMaid.drowningParticlesMaid = nil
			end
		else
			playerMaid.drowningParticlesMaid = nil
		end
	end
	playerMaid:GiveTask(DrownUtils.getDrownPercentChangedSignal(player):Connect(updateBubbles))
	playerMaid:GiveTask(Interval.every(1):Connect(updateBubbles))
end
for _, player in Players:GetPlayers() do
	playerAdded(player)
end
Players.PlayerAdded:Connect(playerAdded)
