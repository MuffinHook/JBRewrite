local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local TextBoxComponent = Roact.Component:extend("TextBox")
TextBoxComponent.defaultProps = {
	backgroundColor = Color3.new(255/255, 255/255, 255/255),
	textColor = Color3.new(0/255, 0/255, 0/255),
	borderSize = 0,
	borderColor = Color3.new(0/255, 0/255, 0/255),
	backgroundTransparency = 0
}
function TextBoxComponent.render(self)
	return createElement("TextBox", {
		BorderSizePixel = self.props.borderSize,
		BorderColor3 = self.props.borderColor,
		BackgroundTransparency = self.props.backgroundTransparency,
		BackgroundColor3 = self.props.backgroundColor,
		Text = self.props.text,
		TextColor3 = self.props.textColor,
		Size = self.props.size,
		Position = self.props.position,
		LayoutOrder = self.props.layoutOrder,
		[Roact.Event.FocusLost] = self.props.onFocusLost
	})
end
return TextBoxComponent
