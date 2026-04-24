-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("TradeResult")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	anchorPoint = Vector2.new()
}
function v1.init(p1)  end
function v1.render(p1)
	local tradeResult = p1.props.tradeResult
	if tradeResult then
		local t = {
			Size = p1.props.size,
			Position = p1.props.position,
			AnchorPoint = p1.props.anchorPoint,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BackgroundTransparency = 0
		}
		local t2 = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 8)
			}),
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 3
			})
		}
		local t3 = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 0.5, 0),
			Position = UDim2.new(0, 0, 0, 0)
		}
		local t4 = {}
		local t5 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		t5.TextColor3 = tradeResult.success and Color3.fromRGB(53, 171, 84) or Color3.fromRGB(237, 66, 69)
		t5.Text = tradeResult.title
		t5.TextXAlignment = Enum.TextXAlignment.Center
		t5.Font = Enum.Font.Bangers
		t5.LineHeight = 1
		t5.TextScaled = true
		t4.Text = createElement("TextLabel", t5)
		t2.Title = createElement("Frame", t3, t4)
		t2.Desc = createElement("Frame", {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 0.5, 0),
			Position = UDim2.new(0, 0, 0.5, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.8, 0, 0.8, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				TextColor3 = Color3.new(0.1, 0.1, 0.1),
				Text = tradeResult.body,
				TextXAlignment = Enum.TextXAlignment.Center,
				Font = Enum.Font.Bangers,
				LineHeight = 1,
				TextScaled = true
			})
		})
		return createElement("Frame", t, t2)
	end
end
function v1.willUnmount(p1)  end
return RoactRodux.connect(function(p1, p2)
	return {
		tradeResult = p1.tradeResult
	}
end)(v1)
