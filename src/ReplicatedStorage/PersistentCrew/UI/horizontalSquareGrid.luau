-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local function horizontalSquareGridItem(self)
	local constant = 1 / (1 / self.aspectRatio + 1 / self.verticalPaddingRatio / self.aspectRatio)
	return createElement(PaddedContainer, {
		component = self.component,
		props = self.props,
		aspectRatio = constant,
		verticalPaddingRatio = self.verticalPaddingRatio,
		size = UDim2.fromScale(1 / constant, 1),
		position = UDim2.fromScale(0.5 + (self.index - 1 - self.numItems / 2) / constant, 0),
		paddingTop = 0,
		paddingBottom = 0,
		paddingRight = 0.5,
		paddingLeft = 0.5
	})
end
return function(self)
	local t = {}
	local constant = self.numItems or #self.items
	for i = 1, constant do
		t[i] = createElement(horizontalSquareGridItem, {
			exposePaddedContainerProps = true,
			index = i,
			numItems = constant,
			component = self.component,
			props = Dictionary.merge(self.items[i], self.itemMetadata)
		})
	end
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		backgroundColor = Color3.new(0/255, 0/255, 0/255),
		aspectRatio = self.aspectRatio,
		verticalPaddingRatio = self.verticalPaddingRatio,
		size = UDim2.fromScale(1, 1),
		paddingLeft = 0,
		paddingRight = 0
	}, t)
end
