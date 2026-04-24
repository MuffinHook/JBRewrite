-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local DamageIndicatorService = require(ReplicatedStorage.DamageIndicator.DamageIndicatorService)
local DamageIndicators = Roact.PureComponent:extend("DamageIndicator")
DamageIndicators.defaultProps = {
	innerRadius = 0.5,
	size = UDim2.new(0.2, 0, 0.2, 0),
	anchorPoint = Vector2.new(0.5, 0.5),
	position = UDim2.new(0.5, 0, 0.5, 0)
}
function DamageIndicators.init(self)
	self.maid = Maid.new()
end
function DamageIndicators.render(self)
	local indicatorElements = {}
	for i = 1, #DamageIndicatorService.list do
		local indicator = DamageIndicatorService.list[i]
		indicatorElements[i] = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://9482691774",
			Size = UDim2.new(0.7, 0, 0.2936241610738255, 0),
			ImageColor3 = indicator.color,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = indicator.angle:map(function(angle)
				local radiusX = self.props.innerRadius * math.cos(angle)
				return UDim2.new(0.5 + radiusX, 0, 0.5 + self.props.innerRadius * math.sin(angle), 0)
			end),
			Rotation = indicator.angle:map(function(angle)
				return 180 * angle / math.pi + 90
			end),
			ImageTransparency = indicator.transparency,
			ZIndex = i
		})
	end
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = self.props.size,
		AnchorPoint = self.props.anchorPoint,
		Position = self.props.position
	}, Dictionary.merge({
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		})
	}, indicatorElements))
end
function DamageIndicators.didMount(self)
	self.maid:GiveTask(DamageIndicatorService.onForceUpdate:Connect(function()
		self:setState({
			_c = math.random()
		})
	end))
end
return DamageIndicators
