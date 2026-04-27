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
for animationName, animationConfig in configTable do
	configTable[animationName] = Instance.new("Animation")
	configTable[animationName].AnimationId = animationConfig.animationId
end
local configTable = {}
local function characterAdded(character)
	local Animator = character:WaitForChild("Humanoid"):WaitForChild("Animator")
	for animationName, animationInstance in configTable do
		local loadedAnimation = Animator:LoadAnimation(animationInstance)
		loadedAnimation.Priority = Enum.AnimationPriority.Action
		loadedAnimation.Looped = configTable[animationName].looped
		configTable[animationName] = loadedAnimation
	end
end
local function playerAdded(player)
	if player.Character then
		characterAdded(player.Character)
	end
	player.CharacterAdded:Connect(characterAdded)
end
local LocalPlayer = Players.LocalPlayer
if LocalPlayer.Character then
	characterAdded(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(characterAdded)
local function playRollSound(character)
	local PrimaryPart = character.PrimaryPart
	if PrimaryPart then
		Audio.ObjectLocal(PrimaryPart, 13621046723, {
			Volume = 0.5
		})
	end
end
local ReplicateMovementRollRemote = ReplicatedStorage:WaitForChild("ReplicateMovementRollRemote")
MovementRollService.onRollBegan:Connect(function(player, rollDuration)
	configTable.Roll:Play()
	configTable.Roll:AdjustSpeed(0.54 * configTable.Roll.Length / rollDuration)
	ReplicateMovementRollRemote:FireServer()
	local PrimaryPart = player.Character.PrimaryPart
	if PrimaryPart then
		Audio.ObjectLocal(PrimaryPart, 13621046723, {
			Volume = 0.5
		})
	end
end)
ReplicateMovementRollRemote.OnClientEvent:Connect(function(remotePlayer)
	if remotePlayer ~= Players.LocalPlayer then
		local Character = remotePlayer.Character
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
	onPressed = function(buttonConfig)
		return MovementRollService.attemptRoll() and true or false
	end,
	onReleased = function()  end
}
ActionButtonService.add(configTable)
local function updateVisibility()
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
	ActionButtonService.setButtonEnabled(configTable, not vehiclePacket and ReplicatedStorage:GetAttribute("RollingEnabled") == true)
end
VehicleUtils.OnVehicleEntered:Connect(updateVisibility)
VehicleUtils.OnVehicleExited:Connect(updateVisibility)
ReplicatedStorage:GetAttributeChangedSignal("RollingEnabled"):Connect(updateVisibility)
local localVehiclePacket = VehicleUtils.GetLocalVehiclePacket()
ActionButtonService.setButtonEnabled(configTable, not localVehiclePacket and ReplicatedStorage:GetAttribute("RollingEnabled") == true)
