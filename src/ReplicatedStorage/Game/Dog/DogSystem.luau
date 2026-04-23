local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer
require(ReplicatedStorage.App.RunUtils)
local v1 = nil
local t = {}
function t.init() --[[ Line: 9 | Upvalues: t (copy), v1 (ref), ReplicatedStorage (copy), LocalPlayer (copy) ]]
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
	local function setupCharacter(p1) --[[ Line: 28 | Upvalues: t (ref), ReplicatedStorage (ref) ]]
		t._petTrack = p1:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage.Resource.Dog.Anim.Pet)
	end
	LocalPlayer.CharacterAdded:Connect(setupCharacter)
	if LocalPlayer.Character then
		t._petTrack = LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage.Resource.Dog.Anim.Pet)
	end
end
function t.getAnimInsts(p1) --[[ Line: 37 | Upvalues: t (copy) ]]
	return t._mapAnimInst[p1]
end
function t.getAll() --[[ Line: 40 | Upvalues: v1 (ref) ]]
	return v1:GetAll()
end
function t.getPetTrack() --[[ Line: 43 | Upvalues: t (copy) ]]
	return t._petTrack
end
return t