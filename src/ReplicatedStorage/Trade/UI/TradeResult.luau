local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local TradeResult = Roact.PureComponent:extend("TradeResult")
TradeResult.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	anchorPoint = Vector2.new()
}
function TradeResult.init(self)  end
function TradeResult.render(self)
	local tradeResult = self.props.tradeResult
	if tradeResult then
		local frameProps = {
			Size = self.props.size,
			Position = self.props.position,
			AnchorPoint = self.props.anchorPoint,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BackgroundTransparency = 0
		}
		local frameChildren = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 8)
			}),
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 3
			})
		}
		local titleFrameProps = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 0.5, 0),
			Position = UDim2.new(0, 0, 0, 0)
		}
		local titleChildren = {}
		local titleTextProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		titleTextProps.TextColor3 = tradeResult.success and Color3.fromRGB(53, 171, 84) or Color3.fromRGB(237, 66, 69)
		titleTextProps.Text = tradeResult.title
		titleTextProps.TextXAlignment = Enum.TextXAlignment.Center
		titleTextProps.Font = Enum.Font.Bangers
		titleTextProps.LineHeight = 1
		titleTextProps.TextScaled = true
		titleChildren.Text = createElement("TextLabel", titleTextProps)
		frameChildren.Title = createElement("Frame", titleFrameProps, titleChildren)
		frameChildren.Desc = createElement("Frame", {
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
		return createElement("Frame", frameProps, frameChildren)
	end
end
function TradeResult.willUnmount(self)  end
return RoactRodux.connect(function(state, action)
	return {
		tradeResult = state.tradeResult
	}
end)(TradeResult)
