local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryItemSystem = require(script.Parent.InventoryItemSystem)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local Promise = require(ReplicatedStorage.Std.Promise)
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local InventoryConsts = require(script.Parent.InventoryConsts)
local InventoryBinder = require(script.Parent.InventoryBinder)
return {
	init = function() --[[ Name: init | Line: 13 | Upvalues: InventoryBinder (copy), InventoryItemSystem (copy) ]]
		InventoryBinder:Start()
		InventoryItemSystem.init()
	end,
	getFor = function(p1) --[[ Name: getFor | Line: 17 | Upvalues: InventoryConsts (copy), InventoryBinder (copy) ]]
		local v1 = p1:FindFirstChild(InventoryConsts.CURRENT_INVENTORY_VALUE_NAME)
		if v1 and v1.Value then
			return InventoryBinder:Get(v1.Value)
		end
	end,
	promiseFor = function(p1) --[[ Name: promiseFor | Line: 26 | Upvalues: waitForChild (copy), InventoryConsts (copy), Maid (copy), Promise (copy), RxInstanceUtils (copy), BinderUtils (copy), InventoryBinder (copy) ]]
		return waitForChild(p1, InventoryConsts.CURRENT_INVENTORY_VALUE_NAME):andThen(function(p1) --[[ Line: 27 | Upvalues: Maid (ref), Promise (ref), RxInstanceUtils (ref), BinderUtils (ref), InventoryBinder (ref) ]]
			local v1 = Maid.new()
			local v2 = Promise.new(function(p12, p2) --[[ Line: 29 | Upvalues: v1 (copy), RxInstanceUtils (ref), p1 (copy), BinderUtils (ref), InventoryBinder (ref) ]]
				v1:GiveTask(RxInstanceUtils.observeProperty(p1, "Value", function(p1) --[[ Line: 30 | Upvalues: p12 (copy), BinderUtils (ref), InventoryBinder (ref), p2 (copy) ]]
					if p1 then
						p12(BinderUtils.promiseBoundClass(InventoryBinder, p1))
					else
						p2()
					end
				end))
			end)
			v2:finally(function() --[[ Line: 38 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end)
			return v2
		end)
	end
}