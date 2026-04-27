local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer
require(ReplicatedStorage.App.RunUtils)
local dogBinder = nil
local DogSystem = {}
function DogSystem.init()
	local DogConsts = require(script.Parent.DogConsts)
	local PlaceId = game.PlaceId
	local animationInstances = {}
	for k, v in pairs(DogConsts.ANIM_ID) do
		animationInstances[k] = {}
		for k2, v2 in pairs(v) do
			local Animation = Instance.new("Animation")
			Animation.AnimationId = ("rbxassetid://%d"):format(v2)
			animationInstances[k][k2] = Animation
		end
	end
	DogSystem._mapAnimInst = animationInstances
	dogBinder = require(script.Parent.DogBinder)
	dogBinder:Start()
	local function setupCharacter(character)
		DogSystem._petTrack = character:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage.Resource.Dog.Anim.Pet)
	end
	LocalPlayer.CharacterAdded:Connect(setupCharacter)
	if LocalPlayer.Character then
		DogSystem._petTrack = LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage.Resource.Dog.Anim.Pet)
	end
end
function DogSystem.getAnimInsts(animationName)
	return DogSystem._mapAnimInst[animationName]
end
function DogSystem.getAll()
	return dogBinder:GetAll()
end
function DogSystem.getPetTrack()
	return DogSystem._petTrack
end
return DogSystem
