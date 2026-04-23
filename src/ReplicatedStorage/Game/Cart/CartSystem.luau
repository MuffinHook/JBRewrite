local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UI = require(ReplicatedStorage.Module.UI)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction = UI.CircleAction
local CartBinder = require(script.Parent.CartBinder)
local CartConsts = require(script.Parent.CartConsts)
return {
	init = function() --[[ Name: init | Line: 11 | Upvalues: CartBinder (copy), RxInstanceUtils (copy), CartConsts (copy), CircleAction (copy) ]]
		CartBinder:GetClassAddedSignal():Connect(function(p1) --[[ Line: 12 | Upvalues: RxInstanceUtils (ref), CartConsts (ref), CircleAction (ref) ]]
			local _obj = p1._obj
			RxInstanceUtils.yieldForProperty(_obj, "PrimaryPart")
			local function action(p1, p2) --[[ Line: 16 | Upvalues: _obj (copy), CartConsts (ref) ]]
				if p2 then
					_obj:FindFirstChild(CartConsts.ATTEMPT_SIT_REMOTE_NAME):FireServer()
					return true
				end
			end
			local function preUpdateFun(p12) --[[ Line: 23 | Upvalues: p1 (copy) ]]
				p12.Enabled = p1:GetOccupant() == nil
			end
			local PrimaryPart = _obj.PrimaryPart
			CircleAction.Add({
				Part = PrimaryPart,
				ValidRoot = _obj,
				Name = "Sit",
				Timed = false,
				Dist = 16,
				PreUpdateFun = preUpdateFun,
				PreUpdatePeriod = 0.5,
				Callback = action
			}, PrimaryPart)
			p1._maid:GiveTask(function() --[[ Line: 38 | Upvalues: CircleAction (ref), PrimaryPart (copy) ]]
				CircleAction.Remove(PrimaryPart)
			end)
		end)
		CartBinder:Start()
	end,
	getCartForCharacter = function(p1) --[[ Name: getCartForCharacter | Line: 44 | Upvalues: CartBinder (copy) ]]
		assert(p1:IsDescendantOf(workspace))
		for i, v in ipairs(CartBinder:GetAll()) do
			if v:GetOccupant() == p1 then
				return v
			end
		end
	end
}