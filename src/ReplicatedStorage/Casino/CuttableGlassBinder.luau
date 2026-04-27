local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(glassObj, manifest)
	local instance = BaseObject.new(glassObj)
	setmetatable(instance, t)
	local function action(_, isActive)
		if isActive then
			glassObj:FindFirstChild("CutRemote"):FireServer()
			return true
		end
	end
	local function preUpdateFun(actionConfig)
		actionConfig.Enabled = glassObj:GetAttribute("IsCut") == false
	end
	CircleAction.Add({
		Attachment = manifest.promptAttachment,
		ValidRoot = glassObj,
		Name = "Break",
		NoRay = true,
		Timed = true,
		Duration = 0.5,
		Dist = 8,
		Callback = action,
		PreUpdateFun = preUpdateFun,
		PreUpdatePeriod = 0.5
	}, glassObj)
	instance.maid:GiveTask(function()
		CircleAction.Remove(glassObj)
	end)
	return instance
end
return ManifestBinder.new("CuttableGlass", {
	holeAttachment = "Hole",
	promptAttachment = "Prompt"
}, t)