-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local function action(p12, p2)
		if p2 then
			p1:FindFirstChild("CutRemote"):FireServer()
			return true
		end
	end
	local function preUpdateFun(p12)
		p12.Enabled = p1:GetAttribute("IsCut") == false
	end
	CircleAction.Add({
		Attachment = p2.promptAttachment,
		ValidRoot = p1,
		Name = "Break",
		NoRay = true,
		Timed = true,
		Duration = 0.5,
		Dist = 8,
		Callback = action,
		PreUpdateFun = preUpdateFun,
		PreUpdatePeriod = 0.5
	}, p1)
	v1.maid:GiveTask(function()
		CircleAction.Remove(p1)
	end)
	return v1
end
return ManifestBinder.new("CuttableGlass", {
	holeAttachment = "Hole",
	promptAttachment = "Prompt"
}, t)