-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Basic = require(script.Parent.Basic)
local Handcuffs = require(ReplicatedStorage.Game.ItemConfig.Handcuffs)
local HandcuffsItem = {
	__ClassName = "Handcuffs"
}
HandcuffsItem.__index = HandcuffsItem
setmetatable(HandcuffsItem, Basic)
function HandcuffsItem.new(self, itemInstance, motionConfig)
	local newInstance = Basic.new(self, itemInstance, Handcuffs, motionConfig)
	setmetatable(newInstance, HandcuffsItem)
	newInstance.SpringItemOffset:SetTarget(Vector3.new(0, 0.3, -1))
	return newInstance
end
function HandcuffsItem.InputBegan(self, ...)
	Basic.InputBegan(self, ...)
end
function HandcuffsItem.InputEnded(self) end
return HandcuffsItem
