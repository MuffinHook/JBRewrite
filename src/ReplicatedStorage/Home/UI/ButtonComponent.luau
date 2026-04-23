local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
return function(p1) --[[ Name: buttonComponent | Line: 6 | Upvalues: createElement (copy), Roact (copy), ColorUtils (copy) ]]
	local cornerRadius = p1.cornerRadius
	local t2 = {}
	t2.Corner = cornerRadius and createElement("UICorner", {
		CornerRadius = cornerRadius
	})
	t2.Title = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = p1.title,
		Font = Enum.Font.Bangers,
		LineHeight = 1,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextColor3 = ColorUtils.saturateBy(p1.backgroundColor, -0.7)
	}, {
		Stroke = createElement("UIStroke", {
			Color = Color3.new(0/255, 0/255, 0/255),
			Thickness = 1
		})
	})
	return createElement("TextButton", {
		BackgroundColor3 = p1.backgroundColor,
		Size = p1.size,
		Position = p1.position,
		AnchorPoint = p1.anchorPoint,
		Text = "",
		Selectable = true,
		[Roact.Event.Activated] = p1.onClick
	}, t2)
end