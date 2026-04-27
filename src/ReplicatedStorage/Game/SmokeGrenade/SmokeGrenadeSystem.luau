local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local SmokeGrenadeBinder = require(script.Parent.SmokeGrenadeBinder)
return {
	init = function()
		SmokeGrenadeBinder:Start()
		local function hide(grenade)
			grenade._obj.PrimaryPart.Anchored = true
			grenade._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
		end
		SmokeGrenadeBinder:GetClassAddedSignal():Connect(function(grenade)
			RxInstanceUtils.yieldForProperty(grenade.obj, "PrimaryPart")
			if grenade:GetCreator() == LocalPlayer then
				grenade._obj.PrimaryPart.Anchored = true
				grenade._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
			end
			grenade._maid:GiveTask(grenade._creatorIdValue:GetPropertyChangedSignal("Value"):Connect(function()
				if grenade:GetCreator() == LocalPlayer then
					local grenade = grenade
					grenade._obj.PrimaryPart.Anchored = true
					grenade._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
				end
			end))
		end)
	end
}
