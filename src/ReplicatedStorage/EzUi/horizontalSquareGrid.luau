-- Reviewed by Claude
-- variables reassigned
local rootModule = script:FindFirstAncestor("EzUi")
local Dictionary = require(rootModule.Dictionary)
local Roact = require(rootModule.Parent.Roact)
local createElement = Roact.createElement
return function(p1)
	local elements = {}
	local numItems = p1.numItems or #p1.items
	local aspectRatio = p1.aspectRatio
	local verticalSpacingRatio = 1 / p1.verticalPaddingRatio / aspectRatio
	for i = 1, numItems do
		local centeredIndex = i - 1 - numItems / 2
		local item = p1.items[i] or {}
		elements[item.id or item.name or #elements + 1] = createElement(p1.component, Dictionary.merge(p1.items[i], {
			size = UDim2.fromScale(1 / aspectRatio, 1),
			position = UDim2.fromScale(0.5 + centeredIndex / aspectRatio + centeredIndex * verticalSpacingRatio, 0)
		}))
	end
	return Roact.createFragment(elements)
end
