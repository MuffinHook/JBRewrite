-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CircleActionUtils = require(script.Parent.CircleActionUtils)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local UI = require(ReplicatedStorage.Module.UI)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local OnPressedRemote = p1:WaitForChild("OnPressedRemote")
	local function preUpdateFun(p12)
		p12.Enabled = not (p1:GetAttribute("CircleActionDisabled") == true)
		p12.Duration = p1:GetAttribute("CircleActionDuration") or 0
		p12.Timed = p12.Duration > 0.001
		local v3 = CircleActionUtils.getTagPart(p1)
		if p1:IsA("Model") then
			p12.ValidRoot = p1
		end
		p12.Part = v3
		p12.Name = p1:GetAttribute("CircleActionText") or p1.Name
		p12.Dist = p1:GetAttribute("CircleActionDist") or 10
	end
	v1.maid:GiveTask(UI.CircleAction.Add({
		Name = "[### MISSING ###]",
		Timed = false,
		Dist = 0,
		Callback = function(p1, p2)
			OnPressedRemote:FireServer(p2)
			return true
		end,
		Enabled = true,
		PreUpdateFun = preUpdateFun,
		PreUpdatePeriod = 0.2
	}, p1))
	return v1
end
return Binder.new("CircleAction", t)