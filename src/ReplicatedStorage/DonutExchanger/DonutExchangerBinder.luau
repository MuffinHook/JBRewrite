local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DonutExchangerConsts = require(script.Parent.DonutExchangerConsts)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local DonutExchangerBinder = {}
DonutExchangerBinder.__index = DonutExchangerBinder
setmetatable(DonutExchangerBinder, BaseObject)
function DonutExchangerBinder.new(donutExchangerInstance)
	local self = BaseObject.new(donutExchangerInstance)
	setmetatable(self, DonutExchangerBinder)
	self.maid:GiveTask(CircleAction.Add({
		Name = "Talk",
		Timed = false,
		Dist = 10,
		Callback = function(player, isPressed)
			if isPressed then
				self.obj:FindFirstChild(DonutExchangerConsts.EXCHANGE_DONUT_REMOTE_NAME):FireServer()
			end
			return true
		end,
		Part = self.obj.PrimaryPart,
		ValidRoot = self.obj
	}, self.obj))
	return self
end
return Binder.new(DonutExchangerConsts.TAG_NAME, DonutExchangerBinder)
