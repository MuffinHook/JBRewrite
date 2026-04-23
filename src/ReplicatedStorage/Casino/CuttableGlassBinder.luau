local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2) --[[ Line: 11 | Upvalues: BaseObject (copy), t (copy), CircleAction (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local function action(p12, p2) --[[ Line: 15 | Upvalues: p1 (copy) ]]
		if p2 then
			p1:FindFirstChild("CutRemote"):FireServer()
			return true
		end
	end
	local function preUpdateFun(p12) --[[ Line: 22 | Upvalues: p1 (copy) ]]
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
	v1.maid:GiveTask(function() --[[ Line: 38 | Upvalues: CircleAction (ref), p1 (copy) ]]
		CircleAction.Remove(p1)
	end)
	return v1
end
return ManifestBinder.new("CuttableGlass", {
	holeAttachment = "Hole",
	promptAttachment = "Prompt"
}, t)