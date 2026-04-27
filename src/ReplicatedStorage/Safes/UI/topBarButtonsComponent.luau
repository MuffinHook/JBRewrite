local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local String = require(ReplicatedStorage.Std.String)
local createElement = Roact.createElement
return function(props)
	local uiElements = {}
	uiElements.PolicyCashAvailableBar = if props.policyCashAvailable then createElement("Frame", {
	Size = UDim2.new(0.2, 0, 1, 0),
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(0.7 - 2 / props.verticalPaddingRatio / props.aspectRatio, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(134, 195, 81)
}, {
	UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, 4)
	}),
	Text = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.9, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Text = ("$%s"):format(String.comma(props.policyCashAvailable)),
		TextXAlignment = Enum.TextXAlignment.Center,
		Font = Enum.Font.Bangers,
		LineHeight = 1,
		TextScaled = true,
		TextColor3 = Color3.new(0/255, 0/255, 0/255)
	})
}) else nil
	uiElements.ToggleButton = createElement("TextButton", {
	Size = UDim2.new(0.2, 0, 1, 0),
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(0.9 - 1 / props.verticalPaddingRatio / props.aspectRatio, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	Text = "",
	[Roact.Event.Activated] = props.onSelectToggle
}, {
	UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, 4)
	}),
	Text = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.9, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Text = props.nextPageTitle,
		TextXAlignment = Enum.TextXAlignment.Center,
		Font = Enum.Font.Bangers,
		LineHeight = 1,
		TextScaled = true,
		TextColor3 = Color3.new(0/255, 0/255, 0/255)
	})
})
	uiElements.ExitButton = createElement("TextButton", {
	Size = UDim2.new(0.1, 0, 1, 0),
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(255, 38, 0),
	Text = "",
	[Roact.Event.Activated] = props.onSelectExit
}, {
	UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, 4)
	}),
	Text = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.9, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Text = "EXIT",
		TextXAlignment = Enum.TextXAlignment.Center,
		Font = Enum.Font.Bangers,
		LineHeight = 1,
		TextScaled = true,
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	})
})
	return Roact.createFragment(uiElements)
end
