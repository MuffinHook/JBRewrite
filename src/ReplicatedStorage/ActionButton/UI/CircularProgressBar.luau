local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local function makeGradient(props, isLeftSide, progressBinding)
	local frameProps = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0.5, 1)
	}
	frameProps.Position = UDim2.fromScale(if isLeftSide then 0 else 0.5, 0)
	frameProps.ClipsDescendants = true
	local children = {}
	local imageProps = {
		BackgroundTransparency = 1,
		ImageTransparency = props.transparency,
		ImageColor3 = props.color,
		Size = UDim2.fromScale(2, 1),
		Image = "rbxasset://textures/ui/Controls/RadialFill.png"
	}
	imageProps.Position = UDim2.fromScale(if isLeftSide then 0 else -1, 0)
	children.Image = createElement("ImageLabel", imageProps, {
		Gradient = createElement("UIGradient", {
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.4999, 0),
				NumberSequenceKeypoint.new(0.5, 1),
				NumberSequenceKeypoint.new(1, 1)
			}),
			Rotation = progressBinding:map(function(progress)
				return math.clamp(math.clamp(progress * 360, 0, 360), if isLeftSide then 180 else 0, if isLeftSide then 360 else 180)
			end)
		})
	})
	return createElement("Frame", frameProps, children)
end
local CircularProgressBar = Roact.PureComponent:extend("CircularProgressBar")
CircularProgressBar.defaultProps = {
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5),
	transparency = 0,
	color = Color3.new(255/255, 255/255, 255/255),
	zIndex = 1
}
function CircularProgressBar.init(self)end
function CircularProgressBar.render(self)
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint,
		ZIndex = self.props.zIndex,
		Visible = self.props.visible
	}, {
		UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		}),
		Gradient1 = makeGradient(self.props, true, self.props.progressBinding),
		Gradient2 = makeGradient(self.props, false, self.props.progressBinding)
	})
end
return CircularProgressBar