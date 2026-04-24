-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer
require(ReplicatedStorage.App.RunUtils)
local v1 = nil
local t = {}
function t.init()
	local DogConsts = require(script.Parent.DogConsts)
	local PlaceId = game.PlaceId
	local t2 = {}
	for k, v in pairs(DogConsts.ANIM_ID) do
		t2[k] = {}
		for k2, v2 in pairs(v) do
			local Animation = Instance.new("Animation")
			Animation.AnimationId = ("rbxassetid://%d"):format(v2)
			t2[k][k2] = Animation
		end
	end
	t._mapAnimInst = t2
	v1 = require(script.Parent.DogBinder)
	v1:Start()
	local function setupCharacter(p1)
		t._petTrack = p1:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage.Resource.Dog.Anim.Pet)
	end
	LocalPlayer.CharacterAdded:Connect(setupCharacter)
	if LocalPlayer.Character then
		t._petTrack = LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage.Resource.Dog.Anim.Pet)
	end
end
function t.getAnimInsts(p1)
	return t._mapAnimInst[p1]
end
function t.getAll()
	return v1:GetAll()
end
function t.getPetTrack()
	return t._petTrack
end
return t
