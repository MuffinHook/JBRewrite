-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local String = require(ReplicatedStorage.Std.String)
local createElement = Roact.createElement
return function(p1)
	local t = {}
	t.PolicyCashAvailableBar = if p1.policyCashAvailable then createElement("Frame", {
	Size = UDim2.new(0.2, 0, 1, 0),
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(0.7 - 2 / p1.verticalPaddingRatio / p1.aspectRatio, 0, 0, 0),
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
		Text = ("$%s"):format(String.comma(p1.policyCashAvailable)),
		TextXAlignment = Enum.TextXAlignment.Center,
		Font = Enum.Font.Bangers,
		LineHeight = 1,
		TextScaled = true,
		TextColor3 = Color3.new(0/255, 0/255, 0/255)
	})
}) else nil
	t.ToggleButton = createElement("TextButton", {
		Size = UDim2.new(0.2, 0, 1, 0),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(0.9 - 1 / p1.verticalPaddingRatio / p1.aspectRatio, 0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Text = "",
		[Roact.Event.Activated] = p1.onSelectToggle
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = p1.nextPageTitle,
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(0/255, 0/255, 0/255)
		})
	})
	t.ExitButton = createElement("TextButton", {
		Size = UDim2.new(0.1, 0, 1, 0),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 38, 0),
		Text = "",
		[Roact.Event.Activated] = p1.onSelectExit
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
	return Roact.createFragment(t)
end
