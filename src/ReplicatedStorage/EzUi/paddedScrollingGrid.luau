local Dictionary = require(script.Parent.Dictionary)
local ScrollingGrid = require(script.Parent.ScrollingGrid)
local createElement = require(script:FindFirstAncestor("EzUi").Parent.Roact).createElement
return function(p1) --[[ Line: 8 | Upvalues: createElement (copy), ScrollingGrid (copy), Dictionary (copy) ]]
	return createElement(ScrollingGrid, Dictionary.merge(p1, {
		injectPaddedContainerProps = true
	}))
end