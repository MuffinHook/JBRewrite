local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local DamageIndicatorService = require(ReplicatedStorage.DamageIndicator.DamageIndicatorService)
local v1 = Roact.PureComponent:extend("DamageIndicator")
v1.defaultProps = {
	innerRadius = 0.5,
	size = UDim2.new(0.2, 0, 0.2, 0),
	anchorPoint = Vector2.new(0.5, 0.5),
	position = UDim2.new(0.5, 0, 0.5, 0)
}
function v1.init(p1) --[[ Line: 16 | Upvalues: Maid (copy) ]]
	p1.maid = Maid.new()
end
function v1.render(p1) --[[ Line: 19 | Upvalues: DamageIndicatorService (copy), createElement (copy), Dictionary (copy) ]]
	local t = {}
	for i = 1, #DamageIndicatorService.list do
		local v1 = DamageIndicatorService.list[i]
		t[i] = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://9482691774",
			Size = UDim2.new(0.7, 0, 0.2936241610738255, 0),
			ImageColor3 = v1.color,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = v1.angle:map(function(p12) --[[ Line: 32 | Upvalues: p1 (copy) ]]
				local v1 = p1.props.innerRadius * math.cos(p12)
				return UDim2.new(0.5 + v1, 0, 0.5 + p1.props.innerRadius * math.sin(p12), 0)
			end),
			Rotation = v1.angle:map(function(p1) --[[ Line: 36 ]]
				return 180 * p1 / math.pi + 90
			end),
			ImageTransparency = v1.transparency,
			ZIndex = i
		})
	end
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = p1.props.size,
		AnchorPoint = p1.props.anchorPoint,
		Position = p1.props.position
	}, Dictionary.merge({
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		})
	}, t))
end
function v1.didMount(p1) --[[ Line: 58 | Upvalues: DamageIndicatorService (copy) ]]
	p1.maid:GiveTask(DamageIndicatorService.onForceUpdate:Connect(function() --[[ Line: 59 | Upvalues: p1 (copy) ]]
		p1:setState({
			_c = math.random()
		})
	end))
end
return v1