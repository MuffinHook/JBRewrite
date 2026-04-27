local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local BigButton = Roact.PureComponent:extend("BigButton")
BigButton.defaultProps = {
	color = Color3.new(255/255, 0/255, 0/255),
	size = UDim2.new(1, 0, 1, 0),
	imageScale = 1
}
function BigButton.render(self)
	local children = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		})
	}
	if self.props.imageId then
		children.Icon = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1 * self.props.imageScale, 0, 1 * self.props.imageScale, 0),
			Image = ("rbxassetid://%d"):format(self.props.imageId),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		})
	end
	if self.props.count then
		children.ContainerCount = createElement("ImageLabel", {
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
				Text = self.props.count,
				Size = UDim2.new(1, 0, 1, 0),
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
	end
	return createElement("ImageButton", {
		Size = self.props.size,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		BackgroundTransparency = 1,
		Image = "rbxassetid://4876179727",
		ImageColor3 = self.props.color,
		Visible = self.props.enabled,
		LayoutOrder = self.props.displayOrder,
		[Roact.Ref] = self.props.ref,
		[Roact.Event.MouseButton1Down] = self.props.onClick
	}, children)
end
return BigButton
