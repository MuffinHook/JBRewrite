-- Reviewed by Claude
local Dictionary = require(script.Parent.Dictionary)
local ScrollingGrid = require(script.Parent.ScrollingGrid)
local createElement = require(script:FindFirstAncestor("EzUi").Parent.Roact).createElement
return function(p1)
	return createElement(ScrollingGrid, Dictionary.merge(p1, {
		injectPaddedContainerProps = true
	}))
end
