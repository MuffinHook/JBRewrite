local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local MovementRollService = require(ReplicatedStorage.MovementRoll.MovementRollService)
local Audio = require(ReplicatedStorage.Std.Audio)

local LocalPlayer = Players.LocalPlayer
local ReplicateMovementRollRemote = ReplicatedStorage:WaitForChild("ReplicateMovementRollRemote")

local RollSoundId = 13621046723

local AnimationConfigs = {
	Roll = {
		animationId = if RunUtils.getEnv() == RunConsts.QA_NAME then "rbxassetid://13556910021" else "rbxassetid://12753913583",
		looped = false,
	}
}

local Animations = {}
local LoadedAnimations = {}

for animationName, animationConfig in AnimationConfigs do
	Animations[animationName] = Instance.new("Animation")
	Animations[animationName].AnimationId = animationConfig.animationId
end

local function playRollSound(character)
	local PrimaryPart = character and character.PrimaryPart
	if not PrimaryPart then
		return
	end

	Audio.ObjectLocal(PrimaryPart, RollSoundId, {
		Volume = 0.5,
	})
end

local function characterAdded(character)
	local Humanoid = character:WaitForChild("Humanoid")
	local Animator = Humanoid:WaitForChild("Animator")

	for animationName, animationInstance in Animations do
		local LoadedAnimation = Animator:LoadAnimation(animationInstance)
		LoadedAnimation.Priority = Enum.AnimationPriority.Action
		LoadedAnimation.Looped = AnimationConfigs[animationName].looped

		LoadedAnimations[animationName] = LoadedAnimation
	end
end

if LocalPlayer.Character then
	characterAdded(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(characterAdded)

MovementRollService.onRollBegan:Connect(function(player, rollDuration)
	local RollAnimation = LoadedAnimations.Roll
	if RollAnimation then
		RollAnimation:Play()
		RollAnimation:AdjustSpeed(0.54 * RollAnimation.Length / rollDuration)
	end

	ReplicateMovementRollRemote:FireServer()

	if player.Character then
		playRollSound(player.Character)
	end
end)

ReplicateMovementRollRemote.OnClientEvent:Connect(function(remotePlayer)
	if remotePlayer == LocalPlayer then
		return
	end

	if remotePlayer.Character then
		playRollSound(remotePlayer.Character)
	end
end)

local RollButtonConfig = {
	disabled = true,
	primary = false,
	priority = 600,
	useEvery = 5,
	image = "rbxassetid://13613171070",
	keyCodes = {
		Enum.KeyCode.LeftControl,
		Enum.KeyCode.RightControl,
		Enum.KeyCode.ButtonL3,
	},

	onPressed = function()
		return MovementRollService.attemptRoll() and true or false
	end,

	onReleased = function() end,
}

ActionButtonService.add(RollButtonConfig)

local function updateVisibility()
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
	local rollingEnabled = ReplicatedStorage:GetAttribute("RollingEnabled") == true

	ActionButtonService.setButtonEnabled(RollButtonConfig, not vehiclePacket and rollingEnabled)
end

VehicleUtils.OnVehicleEntered:Connect(updateVisibility)
VehicleUtils.OnVehicleExited:Connect(updateVisibility)
ReplicatedStorage:GetAttributeChangedSignal("RollingEnabled"):Connect(updateVisibility)

updateVisibility()