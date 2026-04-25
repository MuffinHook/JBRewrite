-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local itemParent = script.Parent
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Basic = require(itemParent.Basic)
local defaultMotionConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local CustomClass = {
	__ClassName = "Custom"
}
CustomClass.__index = CustomClass
setmetatable(CustomClass, Basic)
function CustomClass.new(player, item, config)
	local defaultMotion = TableUtils.deepCopy(defaultMotionConfig)
	local itemOffsetAttr = InventoryItemUtils.getAttr(item, "ItemOffset")
	if itemOffsetAttr then
		defaultMotion.Motion.Hip.Springs.ItemOffset = itemOffsetAttr
	end
	local instance = Basic.new(player, item, defaultMotion, config)
	instance.__ClassName = InventoryItemUtils.getName(item)
	setmetatable(instance, CustomClass)
	instance:DefaultDisableCamLock()
	return instance
end
function CustomClass.GetLeftArmPosition(player)
	return nil
end
function CustomClass.InputBegan(player, ...)
	Basic.InputBegan(player, ...)
end
function CustomClass.InputEnded(player)  end
return CustomClass
