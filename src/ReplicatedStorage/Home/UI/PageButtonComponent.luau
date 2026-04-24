-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local ButtonComponent = require(script.Parent.ButtonComponent)
return function(p1)
	local delta = if p1.selected then p1.backgroundColor else ColorUtils.brightenBy(p1.backgroundColor, -0.3)
	return ButtonComponent(Dictionary.merge(p1, {
		cornerRadius = UDim.new(1, 0),
		backgroundColor = delta
	}))
end
