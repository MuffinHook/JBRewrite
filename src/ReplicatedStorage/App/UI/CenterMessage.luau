local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local CenterMessageComponent = Roact.PureComponent:extend("CenterMessage")
function CenterMessageComponent.init(self)end
function CenterMessageComponent.render(self)
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.2, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.4, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Visible = self.props.text:map(function(text)
			return #text > 0
		end)
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 2
		}),
		Time = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, -0.1, 0),
			Font = Enum.Font.LuckiestGuy,
			TextScaled = true,
			TextColor3 = Color3.fromRGB(252, 40, 47),
			TextStrokeColor3 = Color3.fromRGB(202, 0, 0),
			TextStrokeTransparency = 0.5,
			Text = self.props.text
		})
	})
end
function CenterMessageComponent.willUnmount(self)end
return CenterMessageComponent
