local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local TradeButton = Roact.PureComponent:extend("TradeButton")
TradeButton.defaultProps = {
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
function TradeButton.init(self)
	function self.onActivated()
		if not self.props.disabled and self.props.onClick then
			self.props.onClick()
		end
	end
	function self.onMouseEnter()
		self:setState({
			hover = true
		})
	end
	function self.onMouseLeave()
		self:setState({
			hover = false
		})
	end
	function self.onMouseDown()
		self:setState({
			pressed = true
		})
	end
	function self.onMouseUp()
		self:setState({
			pressed = false
		})
	end
end
function TradeButton.render(self)
	local backgroundColor = self.props.backgroundColor
	if self.props.disabled then
		backgroundColor = ColorUtils.brightenBy(self.props.backgroundColor, -0.5)
	elseif self.state.pressed then
		backgroundColor = ColorUtils.brightenBy(self.props.backgroundColor, -0.2)
	elseif self.state.hover then
		backgroundColor = ColorUtils.brightenBy(self.props.backgroundColor, -0.15)
	end
	local children = {}
	children.AspectRatio = self.props.aspectRatio and createElement("UIAspectRatioConstraint", {
		AspectRatio = self.props.aspectRatio
	}) or nil
	children.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(self.props.cornerScale, self.props.cornerPixel)
	})
	children.Title = createElement("Frame", {
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
			Text = self.props.text,
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true
		})
	})
	return createElement("TextButton", {
		AutoButtonColor = false,
		LayoutOrder = self.props.layoutOrder,
		BackgroundColor3 = backgroundColor,
		Size = self.props.size,
		Position = self.props.position,
		Text = "",
		BorderSizePixel = 0,
		[Roact.Event.Activated] = self.onActivated,
		[Roact.Event.MouseEnter] = self.onMouseEnter,
		[Roact.Event.MouseLeave] = self.onMouseLeave,
		[Roact.Event.SelectionGained] = self.onMouseEnter,
		[Roact.Event.SelectionLost] = self.onMouseLeave,
		[Roact.Event.MouseButton1Down] = self.onMouseDown,
		[Roact.Event.MouseButton1Up] = self.onMouseUp
	}, children)
end
return TradeButton
