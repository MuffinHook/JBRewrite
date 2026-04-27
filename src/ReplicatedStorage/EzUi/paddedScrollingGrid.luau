local Dictionary = require(script.Parent.Dictionary)
local ScrollingGrid = require(script.Parent.ScrollingGrid)
local createElement = require(script:FindFirstAncestor("EzUi").Parent.Roact).createElement
return function(props)
	return createElement(ScrollingGrid, Dictionary.merge(props, {
		injectPaddedContainerProps = true
	}))
end
