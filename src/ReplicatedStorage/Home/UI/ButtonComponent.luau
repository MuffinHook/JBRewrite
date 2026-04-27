local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
return function(props)
	local cornerRadius = props.cornerRadius
	local childElements = {}
	childElements.Corner = cornerRadius and createElement("UICorner", {
		CornerRadius = cornerRadius
	})
	childElements.Title = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = props.title,
		Font = Enum.Font.Bangers,
		LineHeight = 1,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextColor3 = ColorUtils.saturateBy(props.backgroundColor, -0.7)
	}, {
		Stroke = createElement("UIStroke", {
			Color = Color3.new(0/255, 0/255, 0/255),
			Thickness = 1
		})
	})
	return createElement("TextButton", {
		BackgroundColor3 = props.backgroundColor,
		Size = props.size,
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		Text = "",
		Selectable = true,
		[Roact.Event.Activated] = props.onClick
	}, childElements)
end
