-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("TradeButton")
v1.defaultProps = {
	layoutOrder = 1,
	backgroundColor = Color3.new(0.1, 0.1, 0.1),
	text = "Button",
	disabled = false,
	aspectRatio = 4,
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	cornerPixel = 4,
	cornerScale = 0
}
function v1.init(p1)
	function p1.onActivated()
		if not p1.props.disabled and p1.props.onClick then
			p1.props.onClick()
		end
	end
	function p1.onMouseEnter()
		p1:setState({
			hover = true
		})
	end
	function p1.onMouseLeave()
		p1:setState({
			hover = false
		})
	end
	function p1.onMouseDown()
		p1:setState({
			pressed = true
		})
	end
	function p1.onMouseUp()
		p1:setState({
			pressed = false
		})
	end
end
function v1.render(p1)
	local backgroundColor = p1.props.backgroundColor
	if p1.props.disabled then
		backgroundColor = ColorUtils.brightenBy(p1.props.backgroundColor, -0.5)
	elseif p1.state.pressed then
		backgroundColor = ColorUtils.brightenBy(p1.props.backgroundColor, -0.2)
	elseif p1.state.hover then
		backgroundColor = ColorUtils.brightenBy(p1.props.backgroundColor, -0.15)
	end
	local t2 = {}
	t2.AspectRatio = p1.props.aspectRatio and createElement("UIAspectRatioConstraint", {
		AspectRatio = p1.props.aspectRatio
	}) or nil
	t2.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(p1.props.cornerScale, p1.props.cornerPixel)
	})
	t2.Title = createElement("Frame", {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0)
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			Text = p1.props.text,
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true
		})
	})
	return createElement("TextButton", {
		AutoButtonColor = false,
		LayoutOrder = p1.props.layoutOrder,
		BackgroundColor3 = backgroundColor,
		Size = p1.props.size,
		Position = p1.props.position,
		Text = "",
		BorderSizePixel = 0,
		[Roact.Event.Activated] = p1.onActivated,
		[Roact.Event.MouseEnter] = p1.onMouseEnter,
		[Roact.Event.MouseLeave] = p1.onMouseLeave,
		[Roact.Event.SelectionGained] = p1.onMouseEnter,
		[Roact.Event.SelectionLost] = p1.onMouseLeave,
		[Roact.Event.MouseButton1Down] = p1.onMouseDown,
		[Roact.Event.MouseButton1Up] = p1.onMouseUp
	}, t2)
end
return v1
