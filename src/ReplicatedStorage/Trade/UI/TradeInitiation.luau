local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local TradeButton = require(script.Parent.TradeButton)
local TradeInitiationComponent = Roact.PureComponent:extend("TradeInitiation")
TradeInitiationComponent.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 6,
	displayName = "TWENTYMOREMINUTES"
}
function TradeInitiationComponent.init(self)
	self:setState({
		remaining = 0,
		createdAt = workspace:GetServerTimeNow()
	})
	function self.onAccept()
		self.props.onAccept(self.props.index)
	end
	function self.onDecline()
		self.props.onDecline(self.props.index)
	end
	self.maid = Maid.new()
end
function TradeInitiationComponent.render(self)
	local aspectRatio = self.props.aspectRatio
	local isTradingVIP = self.props.isTradingVIP
	local titleColor = isTradingVIP and TradeConsts.VIP_INITIATION_COLOR or Color3.new(255/255, 255/255, 255/255)
	local children = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = self.props.aspectRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Title = createElement("Frame", {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(0.96875, 0, 0.5 - 0.03125 * aspectRatio, 0),
			Position = UDim2.new(0.015625, 0, 0.015625 * aspectRatio, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				TextColor3 = titleColor,
				Text = self.props.displayName .. " wants to trade!",
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.FredokaOne,
				LineHeight = 1,
				TextScaled = true
			})
		})
	}
	local timeFrameProps = {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(0.3177083333333333, 0, 0.5 - 0.03125 * aspectRatio, 0),
		Position = UDim2.new(0.015625, 0, 0.5 + 0.015625 * aspectRatio, 0)
	}
	local timeTextContainer = {}
	local timeTextProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		TextColor3 = Color3.new(255/255, 0/255, 0/255)
	}
	timeTextProps.Text = tostring(self.state.remaining) .. "s"
	timeTextProps.TextXAlignment = Enum.TextXAlignment.Left
	timeTextProps.TextYAlignment = Enum.TextYAlignment.Bottom
	timeTextProps.Font = Enum.Font.FredokaOne
	timeTextProps.LineHeight = 1
	timeTextProps.TextScaled = true
	timeTextContainer.Text = createElement("TextLabel", timeTextProps)
	children.Time = createElement("Frame", timeFrameProps, timeTextContainer)
	children.Accept = createElement(TradeButton, {
		backgroundColor = Color3.fromRGB(42, 170, 255),
		size = UDim2.new(0.25, 0, 0.5 - 0.015625 * aspectRatio, 0),
		position = UDim2.new(0.734375, 0, 0.5, 0),
		aspectRatio = Roact.None,
		text = "Trade",
		onClick = self.onAccept,
		cornerPixel = 0,
		cornerScale = 1
	})
	children.Decline = createElement(TradeButton, {
		backgroundColor = Color3.fromRGB(255, 58, 43),
		size = UDim2.new(0.25, 0, 0.5 - 0.015625 * aspectRatio, 0),
		position = UDim2.new(0.46875, 0, 0.5, 0),
		aspectRatio = Roact.None,
		text = "Decline",
		onClick = self.onDecline,
		cornerPixel = 0,
		cornerScale = 1
	})
	if isTradingVIP then
		children.UIStroke = createElement("UIStroke", {
			Transparency = 0.5,
			Thickness = 3,
			Color = TradeConsts.VIP_INITIATION_COLOR
		})
	end
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BackgroundTransparency = 0.5,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint
	}, children)
end
function TradeInitiationComponent._hookObj(self)
	self:setState({
		createdAt = self.props.obj:GetAttribute(TradeConsts.INITIATION_CREATED_AT_ATTR_NAME)
	})
	self.maid:GiveTask(self.props.obj:GetAttributeChangedSignal(TradeConsts.INITIATION_CREATED_AT_ATTR_NAME):Connect(function()
		self:setState({
			createdAt = self.props.obj:GetAttribute(TradeConsts.INITIATION_CREATED_AT_ATTR_NAME)
		})
	end))
end
function TradeInitiationComponent.didMount(self)
	if self.props.obj then
		self:_hookObj()
	end
	local function update()
		local updateState = {}
		updateState.remaining = math.floor((math.max(0, (self.props.isTradingVIP and TradeConsts.VIP_INITIATION_TIMEOUT or TradeConsts.INITIATION_TIMEOUT) - (workspace:GetServerTimeNow() - self.state.createdAt))))
		self:setState(updateState)
	end
	update()
	self.maid:GiveTask(Interval.every(1):Connect(update))
end
function TradeInitiationComponent.didUpdate(self, previousProps, previousState)
	if self.props.obj ~= previousProps.obj and self.props.obj then
		self:_hookObj()
	end
end
function TradeInitiationComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return TradeInitiationComponent
