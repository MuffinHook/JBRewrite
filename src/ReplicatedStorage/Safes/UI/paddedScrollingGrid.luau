local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local ScrollingGrid = require(ReplicatedStorage.EzUi.ScrollingGrid)
local createElement = require(ReplicatedStorage.Roact).createElement
return function(props)
	local verticalPaddingRatio = props.verticalPaddingRatio
	props.verticalPaddingRatio = nil
	return createElement(ScrollingGrid, Dictionary.merge(props, {
		paddingRatio = verticalPaddingRatio * props.aspectRatio
	}))
end
