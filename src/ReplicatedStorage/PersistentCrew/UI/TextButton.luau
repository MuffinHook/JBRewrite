-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local local1 = Roact.PureComponent:extend("TextButton")
local1.defaultProps = {
	font = Enum.Font.FredokaOne,
	backgroundColor = Color3.new(255/255, 255/255, 255/255),
	borderSize = 0,
	borderColor = Color3.new(0/255, 0/255, 0/255),
	disabled = false,
	text = "",
	cornerRadius = 4
}
function local1.render(self)
	local local1 = self.props[Roact.Children] or {}
	if self.props.aspectRatio then
		local1.AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = self.props.aspectRatio
		})
	end
	local local2 = if self.props.disabled then ColorUtils.brightenBy(self.props.backgroundColor, -0.5) else self.props.backgroundColor
	local local3 = ColorUtils.brightenBy(local2, -0.65)
	if self.props.text then
		local1.Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = self.props.text,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = self.props.textColor or local3,
			Font = self.props.font
		})
	end
	if self.props.cornerRadius then
		local1.CornerRadius = createElement("UICorner", {
			CornerRadius = UDim.new(0, self.props.cornerRadius)
		})
	end
	local t = {
		AnchorPoint = self.props.anchorPoint,
		BorderSizePixel = self.props.borderSize,
		BorderColor3 = self.props.borderColor,
		BackgroundColor3 = local2,
		Text = "",
		Size = self.props.size,
		TextScaled = true,
		Position = self.props.position,
		LayoutOrder = self.props.layoutOrder,
		Visible = self.props.visible,
		AutoButtonColor = not self.props.disabled
	}
	t[Roact.Event.Activated] = if self.props.disabled then nil else self.props.onClick
	return createElement("TextButton", t, local1)
end
return local1
