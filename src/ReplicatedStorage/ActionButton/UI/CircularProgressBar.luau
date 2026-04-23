-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local function makeGradient(p1, p2, p3)
	local t = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0.5, 1)
	}
	t.Position = UDim2.fromScale(if p2 then 0 else 0.5, 0)
	t.ClipsDescendants = true
	local t2 = {}
	local t3 = {
		BackgroundTransparency = 1,
		ImageTransparency = p1.transparency,
		ImageColor3 = p1.color,
		Size = UDim2.fromScale(2, 1),
		Image = "rbxasset://textures/ui/Controls/RadialFill.png"
	}
	t3.Position = UDim2.fromScale(if p2 then 0 else -1, 0)
	t2.Image = createElement("ImageLabel", t3, {
		Gradient = createElement("UIGradient", {
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.4999, 0),
				NumberSequenceKeypoint.new(0.5, 1),
				NumberSequenceKeypoint.new(1, 1)
			}),
			Rotation = p3:map(function(p1)
				return math.clamp(math.clamp(p1 * 360, 0, 360), if p2 then 180 else 0, if p2 then 360 else 180)
			end)
		})
	})
	return createElement("Frame", t, t2)
end
local v1 = Roact.PureComponent:extend("CircularProgressBar")
v1.defaultProps = {
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5),
	transparency = 0,
	color = Color3.new(255/255, 255/255, 255/255),
	zIndex = 1
}
function v1.init(p1) --[[ Line: 46 ]] end
function v1.render(p1)
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint,
		ZIndex = p1.props.zIndex,
		Visible = p1.props.visible
	}, {
		UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		}),
		Gradient1 = makeGradient(p1.props, true, p1.props.progressBinding),
		Gradient2 = makeGradient(p1.props, false, p1.props.progressBinding)
	})
end
return v1