local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local ButtonComponent = require(script.Parent.ButtonComponent)
return function(props)
	local delta = if props.selected then props.backgroundColor else ColorUtils.brightenBy(props.backgroundColor, -0.3)
	return ButtonComponent(Dictionary.merge(props, {
		cornerRadius = UDim.new(1, 0),
		backgroundColor = delta
	}))
end
