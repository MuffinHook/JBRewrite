-- Reviewed by Claude
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
	getFor = function(p1)
		local instance = p1:FindFirstChild(InventoryConsts.CURRENT_INVENTORY_VALUE_NAME)
		if instance and instance.Value then
			return InventoryBinder:Get(instance.Value)
		end
	end,
	promiseFor = function(p1)
		return waitForChild(p1, InventoryConsts.CURRENT_INVENTORY_VALUE_NAME):andThen(function(p1)
			local instance = Maid.new()
			local instance2 = Promise.new(function(p12, p2)
				instance:GiveTask(RxInstanceUtils.observeProperty(p1, "Value", function(p1)
					if p1 then
						p12(BinderUtils.promiseBoundClass(InventoryBinder, p1))
					else
						p2()
					end
				end))
			end)
			instance2:finally(function()
				instance:Destroy()
			end)
			return instance2
		end)
	end
}
