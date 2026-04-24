-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local MovementRollService = require(ReplicatedStorage.MovementRoll.MovementRollService)
local Audio = require(ReplicatedStorage.Std.Audio)
local configTable = {}
local configTable = {}
configTable.animationId = if RunUtils.getEnv() == RunConsts.QA_NAME then "rbxassetid://13556910021" else "rbxassetid://12753913583"
configTable.looped = false
configTable.Roll = configTable
local configTable = {}
for v2, v3 in configTable do
	configTable[v2] = Instance.new("Animation")
	configTable[v2].AnimationId = v3.animationId
end
local configTable = {}
local function characterAdded(p1)
	local Animator = p1:WaitForChild("Humanoid"):WaitForChild("Animator")
	for v1, v2 in configTable do
		local var4 = Animator:LoadAnimation(v2)
		var4.Priority = Enum.AnimationPriority.Action
		var4.Looped = configTable[v1].looped
		configTable[v1] = var4
	end
end
local function playerAdded(p1)
	if p1.Character then
		characterAdded(p1.Character)
	end
	p1.CharacterAdded:Connect(characterAdded)
end
local LocalPlayer = Players.LocalPlayer
if LocalPlayer.Character then
	characterAdded(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(characterAdded)
local function playRollSound(p1)
	local PrimaryPart = p1.PrimaryPart
	if PrimaryPart then
		Audio.ObjectLocal(PrimaryPart, 13621046723, {
			Volume = 0.5
		})
	end
end
local ReplicateMovementRollRemote = ReplicatedStorage:WaitForChild("ReplicateMovementRollRemote")
MovementRollService.onRollBegan:Connect(function(p1, p2)
	configTable.Roll:Play()
	configTable.Roll:AdjustSpeed(0.54 * configTable.Roll.Length / p2)
	ReplicateMovementRollRemote:FireServer()
	local PrimaryPart = p1.Character.PrimaryPart
	if PrimaryPart then
		Audio.ObjectLocal(PrimaryPart, 13621046723, {
			Volume = 0.5
		})
	end
end)
ReplicateMovementRollRemote.OnClientEvent:Connect(function(p1)
	if p1 ~= Players.LocalPlayer then
		local Character = p1.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				Audio.ObjectLocal(PrimaryPart, 13621046723, {
					Volume = 0.5
				})
			end
		end
	end
end)
local configTable = {
	disabled = true,
	primary = false,
	priority = 600,
	useEvery = 5,
	image = "rbxassetid://13613171070",
	keyCodes = { Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl, Enum.KeyCode.ButtonL3 },
	onPressed = function(p1)
		return MovementRollService.attemptRoll() and true or false
	end,
	onReleased = function()  end
}
ActionButtonService.add(configTable)
local function updateVisibility()
	local v1 = VehicleUtils.GetLocalVehiclePacket()
	ActionButtonService.setButtonEnabled(configTable, not v1 and ReplicatedStorage:GetAttribute("RollingEnabled") == true)
end
VehicleUtils.OnVehicleEntered:Connect(updateVisibility)
VehicleUtils.OnVehicleExited:Connect(updateVisibility)
ReplicatedStorage:GetAttributeChangedSignal("RollingEnabled"):Connect(updateVisibility)
local var4 = VehicleUtils.GetLocalVehiclePacket()
ActionButtonService.setButtonEnabled(configTable, not var4 and ReplicatedStorage:GetAttribute("RollingEnabled") == true)
