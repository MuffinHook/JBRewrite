local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local TabPage = Roact.PureComponent:extend("TabPage")
function TabPage.init(self)  end
function TabPage.render(self)
	return createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BorderSizePixel = 0,
		BackgroundTransparency = self.props.backgroundTransparency,
		BackgroundColor3 = self.props.backgroundColor,
		LayoutOrder = self.props.layoutOrder,
		[Roact.Ref] = self.props[Roact.Ref]
	}, self.props[Roact.Children])
end
return TabPage
