local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("RoundButton")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	disabled = false
}
function v1.render(p1) --[[ Line: 12 | Upvalues: createElement (copy), ColorUtils (copy), Roact (copy) ]]
	local aspectRatio = p1.props.aspectRatio
	local t = {
		AutoButtonColor = not p1.props.disabled,
		Text = "",
		BackgroundTransparency = 0,
		BorderSizePixel = 0
	}
	t.BackgroundColor3 = p1.props.disabled and ColorUtils.brightenTo(p1.props.color, 0.1) or p1.props.color
	t.Position = p1.props.position
	t.AnchorPoint = p1.props.anchorPoint
	t.Size = p1.props.size
	t.LayoutOrder = p1.props.layoutOrder
	t[Roact.Event.Activated] = p1.props.onClick
	local t2 = {}
	t2.AspectRatio = if p1.props.aspectRatio == nil then false else createElement("UIAspectRatioConstraint", {
	AspectRatio = p1.props.aspectRatio
})
	t2.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(1, 0)
	})
	t2.Title = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.7, 0, 0.7, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Text = p1.props.title,
		Font = Enum.Font.Bangers,
		LineHeight = 0.9,
		TextScaled = true,
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	}, {
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(0/255, 0/255, 0/255),
			Thickness = 1
		})
	})
	local v5
	if p1.props.locked == nil then
		v5 = false
	else
		local t3 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.6 / aspectRatio, 0, 0.6, 0),
			Position = UDim2.new(0.2 / aspectRatio, 0, 0.2, 0)
		}
		t3.Image = if p1.props.locked then "rbxassetid://8715708455" else "rbxassetid://8715708824"
		v5 = createElement("ImageLabel", t3)
	end
	t2.Lock = v5
	return createElement("TextButton", t, t2)
end
return v1