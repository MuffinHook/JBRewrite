local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local ScrollingGrid = require(ReplicatedStorage.EzUi.ScrollingGrid)
local createElement = require(ReplicatedStorage.Roact).createElement
return function(p1) --[[ Line: 7 | Upvalues: createElement (copy), ScrollingGrid (copy), Dictionary (copy) ]]
	local verticalPaddingRatio = p1.verticalPaddingRatio
	p1.verticalPaddingRatio = nil
	return createElement(ScrollingGrid, Dictionary.merge(p1, {
		paddingRatio = verticalPaddingRatio * p1.aspectRatio
	}))
end