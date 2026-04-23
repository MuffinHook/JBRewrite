local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local v2 = Roact.Component:extend("TextButton")
v2.defaultProps = {
	backgroundColor = Color3.new(255/255, 255/255, 255/255),
	textColor = Color3.new(0/255, 0/255, 0/255),
	borderSize = 0,
	borderColor = Color3.new(0/255, 0/255, 0/255)
}
function v2.render(p1) --[[ Line: 15 | Upvalues: createElement (copy), Roact (copy) ]]
	return createElement("TextButton", {
		AnchorPoint = p1.props.anchorPoint,
		BorderSizePixel = p1.props.borderSize,
		BorderColor3 = p1.props.borderColor,
		BackgroundColor3 = p1.props.backgroundColor,
		Text = p1.props.text,
		TextColor3 = p1.props.textColor,
		Size = p1.props.size,
		Font = Enum.Font.SourceSansBold,
		TextScaled = true,
		Position = p1.props.position,
		LayoutOrder = p1.props.layoutOrder,
		Visible = p1.props.visible,
		[Roact.Event.Activated] = p1.props.onClick
	}, p1.props[Roact.Children])
end
return v2