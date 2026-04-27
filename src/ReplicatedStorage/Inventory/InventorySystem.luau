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
	init = function()
		InventoryBinder:Start()
		InventoryItemSystem.init()
	end,
	getFor = function(parent)
		local instance = parent:FindFirstChild(InventoryConsts.CURRENT_INVENTORY_VALUE_NAME)
		if instance and instance.Value then
			return InventoryBinder:Get(instance.Value)
		end
	end,
	promiseFor = function(parent)
		return waitForChild(parent, InventoryConsts.CURRENT_INVENTORY_VALUE_NAME):andThen(function(inventoryValueInstance)
			local maid = Maid.new()
			local inventoryPromise = Promise.new(function(resolvePromise, rejectPromise)
				maid:GiveTask(RxInstanceUtils.observeProperty(inventoryValueInstance, "Value", function(currentValue)
					if currentValue then
						resolvePromise(BinderUtils.promiseBoundClass(InventoryBinder, currentValue))
					else
						rejectPromise()
					end
				end))
			end)
			inventoryPromise:finally(function()
				maid:Destroy()
			end)
			return inventoryPromise
		end)
	end
}
