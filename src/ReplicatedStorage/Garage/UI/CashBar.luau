-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("CashBar")
v1.defaultProps = {
	cash = 0
}
function v1.render(p1)
	local v1 = p1.props.mainRatio or p1.props.aspectRatio
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0)
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = v1 * 5 / 9
		}),
		Left = createElement("Frame", {
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(134, 195, 81),
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0.75, 0, 1, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.2, 0)
			})
		}),
		Right = createElement("Frame", {
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(134, 195, 81),
			Position = UDim2.new(0.25, 0, 0, 0),
			Size = UDim2.new(0.75, 0, 1, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			})
		}),
		Title = createElement("TextLabel", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.7, 0, 0.5, 0),
			Position = UDim2.new(0.25 / (v1 * 5 / 7), 0, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Text = ("YOUR CASH: $%s"):format(String.comma(p1.props.cash)),
			Font = Enum.Font.LuckiestGuy,
			LineHeight = 0.7,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Color3.new(0/255, 0/255, 0/255),
			ZIndex = 4
		}),
		BuyCash = createElement("TextButton", {
			Text = "",
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.new(1, 0, 0.8, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1 - 0.12499999999999997 / (v1 * 5 / 7), 0, 0.5, 0),
			ZIndex = 5,
			[Roact.Event.Activated] = p1.props.promptCashPurchase
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 5.5
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.8, 0, 0.8, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "BUY CASH?",
				Font = Enum.Font.LuckiestGuy,
				LineHeight = 0.7,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				ZIndex = 4
			})
		})
	})
end
return v1
