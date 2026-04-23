local v1 = script:FindFirstAncestor("EzUi")
local Dictionary = require(script.Parent.Dictionary)
local Roact = require(v1.Parent.Roact)
local createElement = Roact.createElement
local v2 = Roact.Component:extend("Checkbox")
v2.defaultProps = {
	size = UDim2.new(0.5, 0, 0.5, 0),
	backgroundColor = Color3.new(204/255, 204/255, 204/255),
	checkColor = Color3.new(0/255, 0/255, 0/255),
	disabled = false
}
function v2.render(p1) --[[ Line: 16 | Upvalues: createElement (copy), Roact (copy), Dictionary (copy) ]]
	local t = {
		Size = p1.props.size,
		Position = p1.props.position,
		LayoutOrder = p1.props.layoutOrder
	}
	t.BackgroundColor3 = p1.props.value and Color3.new(0/255, 0/255, 0/255) or Color3.new(0.1, 0.1, 0.1)
	local t2 = {}
	t2.Corner = p1.props.cornerRadius and createElement("UICorner", {
		CornerRadius = p1.props.cornerRadius
	})
	t2.AspectRatio = createElement("UIAspectRatioConstraint", {
		AspectRatio = 1,
		DominantAxis = Enum.DominantAxis.Height
	})
	local t3 = {
		AutoButtonColor = not p1.props.disabled,
		Size = UDim2.fromScale(0.92, 0.92),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		LayoutOrder = p1.props.layoutOrder,
		BackgroundColor3 = p1.props.backgroundColor,
		Selectable = true,
		Text = ""
	}
	t3[Roact.Event.Activated] = if p1.props.disabled then nil else function() --[[ Line: 42 | Upvalues: p1 (copy) ]]
	if p1.props.onChecked then
		p1.props.onChecked(not p1.props.value)
	end
end
	local t4 = {
		Check = createElement("ImageLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Image = "rbxassetid://8724615287",
			ImageColor3 = p1.props.checkColor,
			Visible = p1.props.value
		})
	}
	t4.Corner = p1.props.cornerRadius and createElement("UICorner", {
		CornerRadius = p1.props.cornerRadius
	})
	t2.Checkbox = createElement("TextButton", t3, Dictionary.merge(p1.props[Roact.Children], t4))
	return createElement("Frame", t, t2)
end
return v2