local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local TextButtonComponent = Roact.Component:extend("TextButton")
TextButtonComponent.defaultProps = {
	backgroundColor = Color3.new(255/255, 255/255, 255/255),
	textColor = Color3.new(0/255, 0/255, 0/255),
	borderSize = 0,
	borderColor = Color3.new(0/255, 0/255, 0/255)
}
function TextButtonComponent.render(self)
	return createElement("TextButton", {
		AnchorPoint = self.props.anchorPoint,
		BorderSizePixel = self.props.borderSize,
		BorderColor3 = self.props.borderColor,
		BackgroundColor3 = self.props.backgroundColor,
		Text = self.props.text,
		TextColor3 = self.props.textColor,
		Size = self.props.size,
		Font = Enum.Font.SourceSansBold,
		TextScaled = true,
		Position = self.props.position,
		LayoutOrder = self.props.layoutOrder,
		Visible = self.props.visible,
		[Roact.Event.Activated] = self.props.onClick
	}, self.props[Roact.Children])
end
return TextButtonComponent
