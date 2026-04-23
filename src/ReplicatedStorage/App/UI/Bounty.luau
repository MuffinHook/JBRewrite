-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Format = require(ReplicatedStorage.Module.Format)
local v1 = Roact.PureComponent:extend("Bounty")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0)
}
function v1.render(p1)
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = p1.props.size,
		LayoutOrder = p1.props.displayOrder,
		Visible = p1.props.enabled
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 8
		}),
		Label = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Font = Enum.Font.LuckiestGuy,
			Text = ("Bounty: %s"):format(Format.Currency(p1.props.amount)),
			TextColor3 = Color3.new(204/255, 0/255, 0/255),
			TextStrokeColor3 = Color3.new(0.3, 0, 0),
			TextStrokeTransparency = 0.5,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0.15, 0),
			TextScaled = true
		})
	})
end
return v1