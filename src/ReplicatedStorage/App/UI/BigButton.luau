-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("BigButton")
v1.defaultProps = {
	color = Color3.new(255/255, 0/255, 0/255),
	size = UDim2.new(1, 0, 1, 0),
	imageScale = 1
}
function v1.render(p1)
	local t = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		})
	}
	if p1.props.imageId then
		t.Icon = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1 * p1.props.imageScale, 0, 1 * p1.props.imageScale, 0),
			Image = ("rbxassetid://%d"):format(p1.props.imageId),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		})
	end
	if p1.props.count then
		t.ContainerCount = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://4915102010",
			Position = UDim2.new(0.125, 0, 0, 0),
			Size = UDim2.new(0.75, 0, 1, 0)
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 3
			}),
			Label = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSansBold,
				Text = p1.props.count,
				Size = UDim2.new(1, 0, 1, 0),
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
	end
	return createElement("ImageButton", {
		Size = p1.props.size,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		BackgroundTransparency = 1,
		Image = "rbxassetid://4876179727",
		ImageColor3 = p1.props.color,
		Visible = p1.props.enabled,
		LayoutOrder = p1.props.displayOrder,
		[Roact.Ref] = p1.props.ref,
		[Roact.Event.MouseButton1Down] = p1.props.onClick
	}, t)
end
return v1