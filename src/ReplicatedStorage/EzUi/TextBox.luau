local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local v2 = Roact.Component:extend("TextBox")
v2.defaultProps = {
	backgroundColor = Color3.new(255/255, 255/255, 255/255),
	textColor = Color3.new(0/255, 0/255, 0/255),
	borderSize = 0,
	borderColor = Color3.new(0/255, 0/255, 0/255),
	backgroundTransparency = 0
}
function v2.render(p1) --[[ Line: 16 | Upvalues: createElement (copy), Roact (copy) ]]
	return createElement("TextBox", {
		BorderSizePixel = p1.props.borderSize,
		BorderColor3 = p1.props.borderColor,
		BackgroundTransparency = p1.props.backgroundTransparency,
		BackgroundColor3 = p1.props.backgroundColor,
		Text = p1.props.text,
		TextColor3 = p1.props.textColor,
		Size = p1.props.size,
		Position = p1.props.position,
		LayoutOrder = p1.props.layoutOrder,
		[Roact.Event.FocusLost] = p1.props.onFocusLost
	})
end
return v2