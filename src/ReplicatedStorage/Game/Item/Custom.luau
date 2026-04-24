-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = script.Parent
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Basic = require(v1.Basic)
local t = {
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
local t2 = {
	__ClassName = "Custom"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.new(p1, p2, p3)
	local v1 = TableUtils.deepCopy(t)
	local v2 = InventoryItemUtils.getAttr(p2, "ItemOffset")
	if v2 then
		v1.Motion.Hip.Springs.ItemOffset = v2
	end
	local v3 = Basic.new(p1, p2, v1, p3)
	v3.__ClassName = InventoryItemUtils.getName(p2)
	setmetatable(v3, t2)
	v3:DefaultDisableCamLock()
	return v3
end
function t2.GetLeftArmPosition(p1)
	return nil
end
function t2.InputBegan(p1, ...)
	Basic.InputBegan(p1, ...)
end
function t2.InputEnded(p1)  end
return t2
