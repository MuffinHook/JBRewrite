-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CharacterAnimModule = {}
function CharacterAnimModule.init()
	CharacterAnimModule._handlePlayer(Players.LocalPlayer)
end
function CharacterAnimModule._handlePlayer(character)
	if character.Character then
		CharacterAnimModule._handleCharacter(character.Character)
	end
	character.CharacterAdded:Connect(CharacterAnimModule._handleCharacter)
end
function CharacterAnimModule._handleCharacter(character)
	local Animator = character:WaitForChild("Humanoid"):WaitForChild("Animator")
	local idleTrack = Animator:LoadAnimation(character:WaitForChild("Animate"):WaitForChild("idle"):WaitForChild("Animation1"))
	idleTrack.Priority = Enum.AnimationPriority.Action
	idleTrack:AdjustSpeed(0)
	CharacterAnimModule._idleTrack = idleTrack
	CharacterAnimModule._skydiveTrack = Animator:LoadAnimation(ReplicatedStorage.Resource.Skydive)
	local ropeGrabTrack = Animator:LoadAnimation(ReplicatedStorage.Resource.RopeGrabAnimation)
	ropeGrabTrack.Priority = Enum.AnimationPriority.Action
	ropeGrabTrack:AdjustSpeed(0)
	CharacterAnimModule._ropeGrabTrack = ropeGrabTrack
	local carSitTrack = Animator:LoadAnimation(ReplicatedStorage.Resource.CarSitAnimation)
	carSitTrack:AdjustSpeed(0)
	CharacterAnimModule._carSitTrack = carSitTrack
end
function CharacterAnimModule.getIdleTrack()
	return CharacterAnimModule._idleTrack
end
function CharacterAnimModule.getSkydiveTrack()
	return CharacterAnimModule._skydiveTrack
end
function CharacterAnimModule.getRopeGrabTrack()
	return CharacterAnimModule._ropeGrabTrack
end
function CharacterAnimModule.getCarSitTrack()
	return CharacterAnimModule._carSitTrack
end
return CharacterAnimModule
