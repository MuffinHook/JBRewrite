-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local MovementRollService = require(ReplicatedStorage.MovementRoll.MovementRollService)
local Audio = require(ReplicatedStorage.Std.Audio)
local t = {}
local t2 = {}
t2.animationId = if RunUtils.getEnv() == RunConsts.QA_NAME then "rbxassetid://13556910021" else "rbxassetid://12753913583"
t2.looped = false
t.Roll = t2
local t3 = {}
for v2, v3 in t do
	t3[v2] = Instance.new("Animation")
	t3[v2].AnimationId = v3.animationId
end
local t4 = {}
local function characterAdded(p1)
	local Animator = p1:WaitForChild("Humanoid"):WaitForChild("Animator")
	for v1, v2 in t3 do
		local v4 = Animator:LoadAnimation(v2)
		v4.Priority = Enum.AnimationPriority.Action
		v4.Looped = t[v1].looped
		t4[v1] = v4
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
	t4.Roll:Play()
	t4.Roll:AdjustSpeed(0.54 * t4.Roll.Length / p2)
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
local t5 = {
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
ActionButtonService.add(t5)
local function updateVisibility()
	local v1 = VehicleUtils.GetLocalVehiclePacket()
	ActionButtonService.setButtonEnabled(t5, not v1 and ReplicatedStorage:GetAttribute("RollingEnabled") == true)
end
VehicleUtils.OnVehicleEntered:Connect(updateVisibility)
VehicleUtils.OnVehicleExited:Connect(updateVisibility)
ReplicatedStorage:GetAttributeChangedSignal("RollingEnabled"):Connect(updateVisibility)
local v4 = VehicleUtils.GetLocalVehiclePacket()
ActionButtonService.setButtonEnabled(t5, not v4 and ReplicatedStorage:GetAttribute("RollingEnabled") == true)
