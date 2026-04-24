-- Reviewed by Claude
local v1 = script:FindFirstAncestor("EzUi")
local Dictionary = require(v1.Dictionary)
local Roact = require(v1.Parent.Roact)
local createElement = Roact.createElement
return function(p1)
	local t = {}
	local v1 = p1.numItems or #p1.items
	local aspectRatio = p1.aspectRatio
	local v2 = 1 / p1.verticalPaddingRatio / aspectRatio
	for i = 1, v1 do
		local v3 = i - 1 - v1 / 2
		local v4 = p1.items[i] or {}
		t[v4.id or v4.name or #t + 1] = createElement(p1.component, Dictionary.merge(p1.items[i], {
			size = UDim2.fromScale(1 / aspectRatio, 1),
			position = UDim2.fromScale(0.5 + v3 / aspectRatio + v3 * v2, 0)
		}))
	end
	return Roact.createFragment(t)
end
