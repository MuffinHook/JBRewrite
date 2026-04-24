-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("Tooltip")
v1.defaultProps = {
	size = UDim2.fromScale(0.75, 0.05),
	anchorPoint = Vector2.new(0.5, 0),
	position = UDim2.fromScale(0.5, 0)
}
function v1.init(p1)
	p1.maid = Maid.new()
end
function v1.render(p1)
	if p1.props.visible then
		return createElement("Frame", {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			BackgroundTransparency = 1,
			Size = p1.props.size,
			AnchorPoint = p1.props.anchorPoint,
			Position = p1.props.position
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Font = Enum.Font.FredokaOne,
				Text = p1.props.text,
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
function v1.willUnmount(p1)
	p1.maid:DoCleaning()
end
return v1
