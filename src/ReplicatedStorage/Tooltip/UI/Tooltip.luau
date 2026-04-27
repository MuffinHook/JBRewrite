local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local createElement = Roact.createElement
local TooltipComponent = Roact.PureComponent:extend("Tooltip")
TooltipComponent.defaultProps = {
	size = UDim2.fromScale(0.75, 0.05),
	anchorPoint = Vector2.new(0.5, 0),
	position = UDim2.fromScale(0.5, 0)
}
function TooltipComponent.init(self)
	self.maid = Maid.new()
end
function TooltipComponent.render(self)
	if self.props.visible then
		return createElement("Frame", {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			BackgroundTransparency = 1,
			Size = self.props.size,
			AnchorPoint = self.props.anchorPoint,
			Position = self.props.position
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Font = Enum.Font.FredokaOne,
				Text = self.props.text,
				TextColor3 = Color3.new(0.95, 0.95, 0.95),
				TextScaled = true
			}, {
				Stroke = createElement("UIStroke", {
					Thickness = 1,
					Color = Color3.new(102/255, 102/255, 102/255),
					Transparency = 0.2
				})
			})
		})
	end
end
function TooltipComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return TooltipComponent
