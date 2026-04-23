local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local SmokeGrenadeBinder = require(script.Parent.SmokeGrenadeBinder)
return {
	init = function() --[[ Name: init | Line: 8 | Upvalues: SmokeGrenadeBinder (copy), RxInstanceUtils (copy), LocalPlayer (copy) ]]
		SmokeGrenadeBinder:Start()
		local function hide(p1) --[[ Line: 11 ]]
			p1._obj.PrimaryPart.Anchored = true
			p1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
		end
		SmokeGrenadeBinder:GetClassAddedSignal():Connect(function(p1) --[[ Line: 15 | Upvalues: RxInstanceUtils (ref), LocalPlayer (ref) ]]
			RxInstanceUtils.yieldForProperty(p1.obj, "PrimaryPart")
			if p1:GetCreator() == LocalPlayer then
				p1._obj.PrimaryPart.Anchored = true
				p1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
			end
			p1._maid:GiveTask(p1._creatorIdValue:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 20 | Upvalues: p1 (copy), LocalPlayer (ref) ]]
				if p1:GetCreator() == LocalPlayer then
					local v1 = p1
					v1._obj.PrimaryPart.Anchored = true
					v1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
				end
			end))
		end)
	end
}