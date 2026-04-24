-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local v1 = nil
local AdoptionStandConsts = require(script.Parent.AdoptionStandConsts)
local t = {}
function t.init()
	v1 = require(script.Parent.AdoptionStandBinder)
	v1:Start()
	waitForChild(LocalPlayer.PlayerGui, AdoptionStandConsts.DOGS_OWNED_VALUE_NAME):andThen(function(p1)
		t._dogsOwnedValue = p1
	end):catch(warn)
end
function t.getDogName(p1)
	if t._dogsOwnedValue then
		local v1 = t._dogsOwnedValue:FindFirstChild(p1)
		if v1 then
			return v1:FindFirstChild(AdoptionStandConsts.DOG_NAME_VALUE_NAME).Value
		end
	end
end
function t.doesOwn(p1)
	if t._dogsOwnedValue then
		return t._dogsOwnedValue:FindFirstChild(p1) ~= nil
	end
end
return t
