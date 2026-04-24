-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local function horizontalSquareGridItem(p1)
	local v1 = 1 / (1 / p1.aspectRatio + 1 / p1.verticalPaddingRatio / p1.aspectRatio)
	return createElement(PaddedContainer, {
		component = p1.component,
		props = p1.props,
		aspectRatio = v1,
		verticalPaddingRatio = p1.verticalPaddingRatio,
		size = UDim2.fromScale(1 / v1, 1),
		position = UDim2.fromScale(0.5 + (p1.index - 1 - p1.numItems / 2) / v1, 0),
		paddingTop = 0,
		paddingBottom = 0,
		paddingRight = 0.5,
		paddingLeft = 0.5
	})
end
return function(p1)
	local t = {}
	local v1 = p1.numItems or #p1.items
	for i = 1, v1 do
		t[i] = createElement(horizontalSquareGridItem, {
			exposePaddedContainerProps = true,
			index = i,
			numItems = v1,
			component = p1.component,
			props = Dictionary.merge(p1.items[i], p1.itemMetadata)
		})
	end
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		backgroundColor = Color3.new(0/255, 0/255, 0/255),
		aspectRatio = p1.aspectRatio,
		verticalPaddingRatio = p1.verticalPaddingRatio,
		size = UDim2.fromScale(1, 1),
		paddingLeft = 0,
		paddingRight = 0
	}, t)
end
