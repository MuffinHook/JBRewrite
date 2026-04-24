-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("TextButton")
v1.defaultProps = {
	font = Enum.Font.FredokaOne,
	backgroundColor = Color3.new(255/255, 255/255, 255/255),
	borderSize = 0,
	borderColor = Color3.new(0/255, 0/255, 0/255),
	disabled = false,
	text = "",
	cornerRadius = 4
}
function v1.render(p1)
	local v1 = p1.props[Roact.Children] or {}
	if p1.props.aspectRatio then
		v1.AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = p1.props.aspectRatio
		})
	end
	local v2 = if p1.props.disabled then ColorUtils.brightenBy(p1.props.backgroundColor, -0.5) else p1.props.backgroundColor
	local v3 = ColorUtils.brightenBy(v2, -0.65)
	if p1.props.text then
		v1.Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = p1.props.text,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = p1.props.textColor or v3,
			Font = p1.props.font
		})
	end
	if p1.props.cornerRadius then
		v1.CornerRadius = createElement("UICorner", {
			CornerRadius = UDim.new(0, p1.props.cornerRadius)
		})
	end
	local t = {
		AnchorPoint = p1.props.anchorPoint,
		BorderSizePixel = p1.props.borderSize,
		BorderColor3 = p1.props.borderColor,
		BackgroundColor3 = v2,
		Text = "",
		Size = p1.props.size,
		TextScaled = true,
		Position = p1.props.position,
		LayoutOrder = p1.props.layoutOrder,
		Visible = p1.props.visible,
		AutoButtonColor = not p1.props.disabled
	}
	t[Roact.Event.Activated] = if p1.props.disabled then nil else p1.props.onClick
	return createElement("TextButton", t, v1)
end
return v1
