local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local v1 = nil
local AdoptionStandConsts = require(script.Parent.AdoptionStandConsts)
local t = {}
function t.init() --[[ Line: 10 | Upvalues: v1 (ref), waitForChild (copy), LocalPlayer (copy), AdoptionStandConsts (copy), t (copy) ]]
	v1 = require(script.Parent.AdoptionStandBinder)
	v1:Start()
	waitForChild(LocalPlayer.PlayerGui, AdoptionStandConsts.DOGS_OWNED_VALUE_NAME):andThen(function(p1) --[[ Line: 15 | Upvalues: t (ref) ]]
		t._dogsOwnedValue = p1
	end):catch(warn)
end
function t.getDogName(p1) --[[ Line: 25 | Upvalues: t (copy), AdoptionStandConsts (copy) ]]
	if t._dogsOwnedValue then
		local v1 = t._dogsOwnedValue:FindFirstChild(p1)
		if v1 then
			return v1:FindFirstChild(AdoptionStandConsts.DOG_NAME_VALUE_NAME).Value
		end
	end
end
function t.doesOwn(p1) --[[ Line: 36 | Upvalues: t (copy) ]]
	if t._dogsOwnedValue then
		return t._dogsOwnedValue:FindFirstChild(p1) ~= nil
	end
end
return t