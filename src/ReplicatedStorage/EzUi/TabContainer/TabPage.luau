-- Reviewed by Claude
local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local v2 = Roact.PureComponent:extend("TabPage")
function v2.init(p1)  end
function v2.render(p1)
	return createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BorderSizePixel = 0,
		BackgroundTransparency = p1.props.backgroundTransparency,
		BackgroundColor3 = p1.props.backgroundColor,
		LayoutOrder = p1.props.layoutOrder,
		[Roact.Ref] = p1.props[Roact.Ref]
	}, p1.props[Roact.Children])
end
return v2
