-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local SmokeGrenadeBinder = require(script.Parent.SmokeGrenadeBinder)
return {
	init = function()
		SmokeGrenadeBinder:Start()
		local function hide(p1)
			p1._obj.PrimaryPart.Anchored = true
			p1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
		end
		SmokeGrenadeBinder:GetClassAddedSignal():Connect(function(p1)
			RxInstanceUtils.yieldForProperty(p1.obj, "PrimaryPart")
			if p1:GetCreator() == LocalPlayer then
				p1._obj.PrimaryPart.Anchored = true
				p1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
			end
			p1._maid:GiveTask(p1._creatorIdValue:GetPropertyChangedSignal("Value"):Connect(function()
				if p1:GetCreator() == LocalPlayer then
					local v1 = p1
					v1._obj.PrimaryPart.Anchored = true
					v1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
				end
			end))
		end)
	end
}
