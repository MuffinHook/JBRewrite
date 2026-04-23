local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DonutExchangerConsts = require(script.Parent.DonutExchangerConsts)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1) --[[ Line: 12 | Upvalues: BaseObject (copy), t (copy), DonutExchangerConsts (copy), CircleAction (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.maid:GiveTask(CircleAction.Add({
		Name = "Talk",
		Timed = false,
		Dist = 10,
		Callback = function(p1, p2) --[[ Name: action | Line: 16 | Upvalues: v1 (copy), DonutExchangerConsts (ref) ]]
			if p2 then
				v1.obj:FindFirstChild(DonutExchangerConsts.EXCHANGE_DONUT_REMOTE_NAME):FireServer()
			end
			return true
		end,
		Part = v1.obj.PrimaryPart,
		ValidRoot = v1.obj
	}, v1.obj))
	return v1
end
return Binder.new(DonutExchangerConsts.TAG_NAME, t)