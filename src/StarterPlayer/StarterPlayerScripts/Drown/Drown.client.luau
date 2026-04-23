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
local function getComponent() --[[ Line: 12 | Upvalues: DrownUtils (copy), Players (copy), createElement (copy), ProgressBar (copy) ]]
	local v1 = DrownUtils.getDrownPercent(Players.LocalPlayer) or 0
	local Character = Players.LocalPlayer.Character
	if Character then
		local Head = Character:WaitForChild("Head")
		local v2 = if v1 > 0 then createElement(ProgressBar, {
	aspectRatio = 0.5,
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0, 0),
	progress = 1 - v1,
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
			ProgressBar = v2
		})
	else
		return createElement("Frame", {
			Active = false,
			Visible = false
		})
	end
end
local v1 = Roact.mount(getComponent(), Players.LocalPlayer.PlayerGui, "DrownGui")
local function updateUI() --[[ Line: 47 | Upvalues: Roact (copy), v1 (copy), getComponent (copy) ]]
	Roact.update(v1, getComponent())
end
DrownUtils.getDrownPercentChangedSignal(Players.LocalPlayer):Connect(updateUI)
Players.LocalPlayer.CharacterAdded:Connect(updateUI)
Roact.update(v1, getComponent())
local function playerAdded(p1) --[[ Line: 54 | Upvalues: PlayerUtils (copy), DrownUtils (copy), Maid (copy), ReplicatedStorage (copy), Interval (copy) ]]
	local v1 = PlayerUtils.getPlayerMaid(p1)
	local function cleanUp() --[[ Line: 56 | Upvalues: v1 (copy) ]]
		v1.drowningParticlesMaid = nil
	end
	local function updateBubbles() --[[ Line: 59 | Upvalues: DrownUtils (ref), p1 (copy), v1 (copy), Maid (ref), ReplicatedStorage (ref) ]]
		if DrownUtils.getIsPlayerDrowning(p1) then
			local Character = p1.Character
			if Character then
				local Head = Character:FindFirstChild("Head")
				if Head then
					if not v1.drowningParticlesMaid then
						v1.drowningParticlesMaid = Maid.new()
						local v12 = ReplicatedStorage.Drown.Res.AirBubbles:Clone()
						v12.Rate = 100
						v1.drowningParticlesMaid:GiveTask(v12)
						v12.Parent = Head
					end
				else
					v1.drowningParticlesMaid = nil
				end
			else
				v1.drowningParticlesMaid = nil
			end
		else
			v1.drowningParticlesMaid = nil
		end
	end
	v1:GiveTask(DrownUtils.getDrownPercentChangedSignal(p1):Connect(updateBubbles))
	v1:GiveTask(Interval.every(1):Connect(updateBubbles))
end
for v2, v3 in Players:GetPlayers() do
	playerAdded(v3)
end
Players.PlayerAdded:Connect(playerAdded)