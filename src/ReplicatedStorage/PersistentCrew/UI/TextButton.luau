local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local TextButtonComponent = Roact.PureComponent:extend("TextButton")
TextButtonComponent.defaultProps = {
	font = Enum.Font.FredokaOne,
	backgroundColor = Color3.new(255/255, 255/255, 255/255),
	borderSize = 0,
	borderColor = Color3.new(0/255, 0/255, 0/255),
	disabled = false,
	text = "",
	cornerRadius = 4
}
function TextButtonComponent.render(self)
	local childElements = self.props[Roact.Children] or {}
	if self.props.aspectRatio then
		childElements.AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = self.props.aspectRatio
		})
	end
	local buttonBackgroundColor = if self.props.disabled then ColorUtils.brightenBy(self.props.backgroundColor, -0.5) else self.props.backgroundColor
	local textColor = ColorUtils.brightenBy(buttonBackgroundColor, -0.65)
	if self.props.text then
		childElements.Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = self.props.text,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = self.props.textColor or textColor,
			Font = self.props.font
		})
	end
	if self.props.cornerRadius then
		childElements.CornerRadius = createElement("UICorner", {
			CornerRadius = UDim.new(0, self.props.cornerRadius)
		})
	end
	local buttonProps = {
		AnchorPoint = self.props.anchorPoint,
		BorderSizePixel = self.props.borderSize,
		BorderColor3 = self.props.borderColor,
		BackgroundColor3 = buttonBackgroundColor,
		Text = "",
		Size = self.props.size,
		TextScaled = true,
		Position = self.props.position,
		LayoutOrder = self.props.layoutOrder,
		Visible = self.props.visible,
		AutoButtonColor = not self.props.disabled
	}
	buttonProps[Roact.Event.Activated] = if self.props.disabled then nil else self.props.onClick
	return createElement("TextButton", buttonProps, childElements)
end
return TextButtonComponent
