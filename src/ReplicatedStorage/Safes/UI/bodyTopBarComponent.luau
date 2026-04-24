-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local createElement = require(ReplicatedStorage.Roact).createElement
return function(p1)
	return createElement("Frame", {
		Size = UDim2.new(1, 0, 0.1, 0),
		BackgroundTransparency = 1,
		ZIndex = 3
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Title = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1 - 2 / p1.verticalPaddingRatio / p1.aspectRatio, 0, 0.8 - 2 / p1.verticalPaddingRatio / 0.1, 0),
			Position = UDim2.new(1 / p1.verticalPaddingRatio / p1.aspectRatio, 0, 0.1 + 1 / p1.verticalPaddingRatio / 0.1, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1.25, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "Win one of these items:",
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.Bangers,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		}),
		Line = createElement("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 1, -1),
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			BorderSizePixel = 0
		})
	})
end
