local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CircleActionUtils = require(script.Parent.CircleActionUtils)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local UI = require(ReplicatedStorage.Module.UI)
local localTable = {}
localTable.__index = localTable
setmetatable(localTable, BaseObject)
function localTable.new(model)
	local instance = BaseObject.new(model)
	setmetatable(instance, localTable)
	local OnPressedRemote = model:WaitForChild("OnPressedRemote")
	local function preUpdateFun(uiElement)
		uiElement.Enabled = not (model:GetAttribute("CircleActionDisabled") == true)
		uiElement.Duration = model:GetAttribute("CircleActionDuration") or 0
		uiElement.Timed = uiElement.Duration > 0.001
		local part = CircleActionUtils.getTagPart(model)
		if model:IsA("Model") then
			uiElement.ValidRoot = model
		end
		uiElement.Part = part
		uiElement.Name = model:GetAttribute("CircleActionText") or model.Name
		uiElement.Dist = model:GetAttribute("CircleActionDist") or 10
	end
	instance.maid:GiveTask(UI.CircleAction.Add({
		Name = "[### MISSING ###]",
		Timed = false,
		Dist = 0,
		Callback = function(model, buttonData)
			OnPressedRemote:FireServer(buttonData)
			return true
		end,
		Enabled = true,
		PreUpdateFun = preUpdateFun,
		PreUpdatePeriod = 0.2
	}, model))
	return instance
end
return Binder.new("CircleAction", localTable)
