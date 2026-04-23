local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local t = {}
function t.init() --[[ Line: 5 | Upvalues: t (copy), Players (copy) ]]
	t._handlePlayer(Players.LocalPlayer)
end
function t._handlePlayer(p1) --[[ Line: 8 | Upvalues: t (copy) ]]
	if p1.Character then
		t._handleCharacter(p1.Character)
	end
	p1.CharacterAdded:Connect(t._handleCharacter)
end
function t._handleCharacter(p1) --[[ Line: 14 | Upvalues: t (copy), ReplicatedStorage (copy) ]]
	local Animator = p1:WaitForChild("Humanoid"):WaitForChild("Animator")
	local v1 = Animator:LoadAnimation(p1:WaitForChild("Animate"):WaitForChild("idle"):WaitForChild("Animation1"))
	v1.Priority = Enum.AnimationPriority.Action
	v1:AdjustSpeed(0)
	t._idleTrack = v1
	t._skydiveTrack = Animator:LoadAnimation(ReplicatedStorage.Resource.Skydive)
	local v2 = Animator:LoadAnimation(ReplicatedStorage.Resource.RopeGrabAnimation)
	v2.Priority = Enum.AnimationPriority.Action
	v2:AdjustSpeed(0)
	t._ropeGrabTrack = v2
	local v3 = Animator:LoadAnimation(ReplicatedStorage.Resource.CarSitAnimation)
	v3:AdjustSpeed(0)
	t._carSitTrack = v3
end
function t.getIdleTrack() --[[ Line: 36 | Upvalues: t (copy) ]]
	return t._idleTrack
end
function t.getSkydiveTrack() --[[ Line: 39 | Upvalues: t (copy) ]]
	return t._skydiveTrack
end
function t.getRopeGrabTrack() --[[ Line: 42 | Upvalues: t (copy) ]]
	return t._ropeGrabTrack
end
function t.getCarSitTrack() --[[ Line: 45 | Upvalues: t (copy) ]]
	return t._carSitTrack
end
return t