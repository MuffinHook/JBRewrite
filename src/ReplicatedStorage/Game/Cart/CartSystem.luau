local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UI = require(ReplicatedStorage.Module.UI)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction = UI.CircleAction
local CartBinder = require(script.Parent.CartBinder)
local CartConsts = require(script.Parent.CartConsts)
return {
	init = function()
		CartBinder:GetClassAddedSignal():Connect(function(cartInstance)
			local cartObject = cartInstance._obj
			RxInstanceUtils.yieldForProperty(cartObject, "PrimaryPart")
			local function action(p1, isPressed)
				if isPressed then
					cartObject:FindFirstChild(CartConsts.ATTEMPT_SIT_REMOTE_NAME):FireServer()
					return true
				end
			end
			local function preUpdateFun(circleActionState)
				circleActionState.Enabled = cartInstance:GetOccupant() == nil
			end
			local PrimaryPart = cartObject.PrimaryPart
			CircleAction.Add({
				Part = PrimaryPart,
				ValidRoot = cartObject,
				Name = "Sit",
				Timed = false,
				Dist = 16,
				PreUpdateFun = preUpdateFun,
				PreUpdatePeriod = 0.5,
				Callback = action
			}, PrimaryPart)
			cartInstance._maid:GiveTask(function()
				CircleAction.Remove(PrimaryPart)
			end)
		end)
		CartBinder:Start()
	end,
	getCartForCharacter = function(character)
		assert(character:IsDescendantOf(workspace))
		for i, cart in ipairs(CartBinder:GetAll()) do
			if cart:GetOccupant() == character then
				return cart
			end
		end
	end
}
