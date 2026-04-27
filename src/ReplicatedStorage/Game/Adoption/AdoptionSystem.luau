local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local adoptionBinder = nil
local AdoptionStandConsts = require(script.Parent.AdoptionStandConsts)
local t = {}
function t.init()
	adoptionBinder = require(script.Parent.AdoptionStandBinder)
	adoptionBinder:Start()
	waitForChild(LocalPlayer.PlayerGui, AdoptionStandConsts.DOGS_OWNED_VALUE_NAME):andThen(function(dogsOwnedValue)
		t._dogsOwnedValue = dogsOwnedValue
	end):catch(warn)
end
function t.getDogName(dogName)
	if t._dogsOwnedValue then
		local dogInstance = t._dogsOwnedValue:FindFirstChild(dogName)
		if dogInstance then
			return dogInstance:FindFirstChild(AdoptionStandConsts.DOG_NAME_VALUE_NAME).Value
		end
	end
end
function t.doesOwn(dogName)
	if t._dogsOwnedValue then
		return t._dogsOwnedValue:FindFirstChild(dogName) ~= nil
	end
end
return t
