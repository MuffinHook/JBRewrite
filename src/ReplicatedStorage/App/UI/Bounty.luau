local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Format = require(ReplicatedStorage.Module.Format)
local Bounty = Roact.PureComponent:extend("Bounty")
Bounty.defaultProps = {
	size = UDim2.new(1, 0, 1, 0)
}
function Bounty.render(props)
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = props.props.size,
		LayoutOrder = props.props.displayOrder,
		Visible = props.props.enabled
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 8
		}),
		Label = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Font = Enum.Font.LuckiestGuy,
			Text = ("Bounty: %s"):format(Format.Currency(props.props.amount)),
			TextColor3 = Color3.new(204/255, 0/255, 0/255),
			TextStrokeColor3 = Color3.new(0.3, 0, 0),
			TextStrokeTransparency = 0.5,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0.15, 0),
			TextScaled = true
		})
	})
end
return Bounty
