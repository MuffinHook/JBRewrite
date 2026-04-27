local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local createElement = Roact.createElement
local Countdown = Roact.PureComponent:extend("Countdown")
Countdown.defaultProps = {
	aspectRatio = 1,
	verticalPaddingRatio = 64,
	backgroundTransparency = 1,
	backgroundColor = Color3.new(0.1, 0.1, 0.1),
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5),
	textColor = Color3.new(255/255, 255/255, 255/255),
	timeFormatFunc = function(timeValue)
		return timeValue
	end,
	fontFace = Font.fromEnum(Enum.Font.GothamBold),
	prefix = "",
	suffix = "",
	zIndex = nil,
	strokeThickness = 0,
	strokeColor = Color3.new(0/255, 0/255, 0/255)
}
function Countdown.init(self)
	self.maid = Maid.new()
end
function Countdown.didMount(self)
	self.maid:GiveTask(Interval.every(0.1):Connect(function()
		self:setState({
			_c = math.random()
		})
	end))
end
function Countdown.render(self)
	local elapsedTime = self.props.endTime - workspace:GetServerTimeNow()
	if elapsedTime < 0 then
		elapsedTime = 0
	end
	local formattedTime = self.props.timeFormatFunc((math.round(elapsedTime)))
	local textLabelChildren = {}
	local textLabelProps = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1.5),
		Text = self.props.prefix .. tostring(formattedTime) .. self.props.suffix,
		TextColor3 = self.props.textColor,
		TextScaled = true,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.45),
		FontFace = self.props.fontFace,
		TextXAlignment = self.props.textXAlignment,
		TextYAlignment = self.props.textYAlignment
	}
	local strokeProps = {}
	strokeProps.Stroke = if self.props.strokeThickness > 0 then createElement("UIStroke", {
	Thickness = self.props.strokeThickness,
	Color = self.props.strokeColor
}) else false
	textLabelChildren.Title = createElement("TextLabel", textLabelProps, strokeProps)
	return createElement(PaddedContainer, {
		backgroundTransparency = self.props.backgroundTransparency,
		size = self.props.size,
		position = self.props.position,
		anchorPoint = self.props.anchorPoint,
		verticalPaddingRatio = self.props.verticalPaddingRatio,
		aspectRatio = self.props.aspectRatio,
		paddingRight = self.props.paddingRight,
		paddingLeft = self.props.paddingLeft,
		paddingTop = self.props.paddingTop,
		paddingBottom = self.props.paddingBottom,
		paddingNone = self.props.paddingNone,
		zIndex = self.props.zIndex
	}, textLabelChildren)
end
function Countdown.willUnmount(self)
	self.maid:Destroy()
end
return Countdown
