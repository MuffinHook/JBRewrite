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
	timeFormatFunc = function(p1) --[[ Name: timeFormatFunc | Line: 19 ]]
		return p1
	end,
	fontFace = Font.fromEnum(Enum.Font.GothamBold),
	prefix = "",
	suffix = "",
	zIndex = nil,
	strokeThickness = 0,
	strokeColor = Color3.new(0/255, 0/255, 0/255)
}
function v1.init(p1) --[[ Line: 30 | Upvalues: Maid (copy) ]]
	p1.maid = Maid.new()
end
function v1.didMount(p1) --[[ Line: 33 | Upvalues: Interval (copy) ]]
	p1.maid:GiveTask(Interval.every(0.1):Connect(function() --[[ Line: 34 | Upvalues: p1 (copy) ]]
		p1:setState({
			_c = math.random()
		})
	end))
end
function v1.render(p1) --[[ Line: 40 | Upvalues: createElement (copy), PaddedContainer (copy) ]]
	local v1 = p1.props.endTime - workspace:GetServerTimeNow()
	if v1 < 0 then
		v1 = 0
	end
	local v3 = p1.props.timeFormatFunc((math.round(v1)))
	local t2 = {}
	local t3 = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1.5),
		Text = p1.props.prefix .. tostring(v3) .. p1.props.suffix,
		TextColor3 = p1.props.textColor,
		TextScaled = true,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.45),
		FontFace = p1.props.fontFace,
		TextXAlignment = p1.props.textXAlignment,
		TextYAlignment = p1.props.textYAlignment
	}
	local t4 = {}
	t4.Stroke = if p1.props.strokeThickness > 0 then createElement("UIStroke", {
	Thickness = p1.props.strokeThickness,
	Color = p1.props.strokeColor
}) else false
	t2.Title = createElement("TextLabel", t3, t4)
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
	}, t2)
end
function v1.willUnmount(p1) --[[ Line: 81 ]]
	p1.maid:Destroy()
end
return v1