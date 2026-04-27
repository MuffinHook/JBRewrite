local rootModule = script:FindFirstAncestor("EzUi")
local Dictionary = require(rootModule.Dictionary)
local Roact = require(rootModule.Parent.Roact)
local createElement = Roact.createElement
return function(props)
	local elements = {}
	local numItems = props.numItems or #props.items
	local aspectRatio = props.aspectRatio
	local verticalSpacingRatio = 1 / props.verticalPaddingRatio / aspectRatio
	for i = 1, numItems do
		local centeredIndex = i - 1 - numItems / 2
		local item = props.items[i] or {}
		elements[item.id or item.name or #elements + 1] = createElement(props.component, Dictionary.merge(props.items[i], {
			size = UDim2.fromScale(1 / aspectRatio, 1),
			position = UDim2.fromScale(0.5 + centeredIndex / aspectRatio + centeredIndex * verticalSpacingRatio, 0)
		}))
	end
	return Roact.createFragment(elements)
end
