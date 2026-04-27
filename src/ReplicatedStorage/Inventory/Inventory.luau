local InventoryUtils = require(script.Parent.InventoryUtils)
local InventoryClass = {}
InventoryClass.__index = InventoryClass
function InventoryClass.new(objectReference)
	local newInstance = {}
	setmetatable(newInstance, InventoryClass)
	newInstance.obj = objectReference
	return newInstance
end
function InventoryClass.HasItem(self, itemValue)
	return InventoryUtils.doesInventoryValueHave(self.obj, itemValue)
end
function InventoryClass.Destroy(self) end
return InventoryClass
