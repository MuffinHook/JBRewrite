-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("Countdown")
v1.defaultProps = {
	aspectRatio = 1,
	verticalPaddingRatio = 64,
	backgroundTransparency = 1,
	backgroundColor = Color3.new(0.1, 0.1, 0.1),
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5),
	textColor = Color3.new(255/255, 255/255, 255/255),
	timeFormatFunc = function(p1)
		return p1
	end,
	fontFace = Font.fromEnum(Enum.Font.GothamBold),
	prefix = "",
	suffix = "",
	zIndex = nil,
	strokeThickness = 0,
	strokeColor = Color3.new(0/255, 0/255, 0/255)
}
function v1.init(p1)
	p1.maid = Maid.new()
end
function v1.didMount(p1)
	p1.maid:GiveTask(Interval.every(0.1):Connect(function()
		p1:setState({
			_c = math.random()
		})
	end))
end
function v1.render(p1)
	local elapsedTime = p1.props.endTime - workspace:GetServerTimeNow()
	if elapsedTime < 0 then
		elapsedTime = 0
	end
	local formattedTime = p1.props.timeFormatFunc((math.round(elapsedTime)))
	local textLabelChildren = {}
	local textLabelProps = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1.5),
		Text = p1.props.prefix .. tostring(formattedTime) .. p1.props.suffix,
		TextColor3 = p1.props.textColor,
		TextScaled = true,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.45),
		FontFace = p1.props.fontFace,
		TextXAlignment = p1.props.textXAlignment,
		TextYAlignment = p1.props.textYAlignment
	}
	local strokeProps = {}
	strokeProps.Stroke = if p1.props.strokeThickness > 0 then createElement("UIStroke", {
	Thickness = p1.props.strokeThickness,
	Color = p1.props.strokeColor
}) else false
	textLabelChildren.Title = createElement("TextLabel", textLabelProps, strokeProps)
	return createElement(PaddedContainer, {
		backgroundTransparency = p1.props.backgroundTransparency,
		size = p1.props.size,
		position = p1.props.position,
		anchorPoint = p1.props.anchorPoint,
		verticalPaddingRatio = p1.props.verticalPaddingRatio,
		aspectRatio = p1.props.aspectRatio,
		paddingRight = p1.props.paddingRight,
		paddingLeft = p1.props.paddingLeft,
		paddingTop = p1.props.paddingTop,
		paddingBottom = p1.props.paddingBottom,
		paddingNone = p1.props.paddingNone,
		zIndex = p1.props.zIndex
	}, textLabelChildren)
end
function v1.willUnmount(p1)
	p1.maid:Destroy()
end
return v1
