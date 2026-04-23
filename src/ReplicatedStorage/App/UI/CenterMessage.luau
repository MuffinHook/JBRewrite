local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("CenterMessage")
function v1.init(p1) --[[ Line: 6 ]] end
function v1.render(p1) --[[ Line: 7 | Upvalues: createElement (copy) ]]
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.2, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.4, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Visible = p1.props.text:map(function(p1) --[[ Line: 13 ]]
			return #p1 > 0
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
			Text = p1.props.text
		})
	})
end
function v1.willUnmount(p1) --[[ Line: 33 ]] end
return v1