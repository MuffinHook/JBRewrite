local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local TradeButton = require(script.Parent.TradeButton)
local v1 = Roact.PureComponent:extend("TradeInitiation")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 6,
	displayName = "TWENTYMOREMINUTES"
}
function v1.init(p1) --[[ Line: 17 | Upvalues: Maid (copy) ]]
	p1:setState({
		remaining = 0,
		createdAt = workspace:GetServerTimeNow()
	})
	function p1.onAccept() --[[ Line: 22 | Upvalues: p1 (copy) ]]
		p1.props.onAccept(p1.props.index)
	end
	function p1.onDecline() --[[ Line: 25 | Upvalues: p1 (copy) ]]
		p1.props.onDecline(p1.props.index)
	end
	p1.maid = Maid.new()
end
function v1.render(p1) --[[ Line: 30 | Upvalues: TradeConsts (copy), createElement (copy), TradeButton (copy), Roact (copy) ]]
	local aspectRatio = p1.props.aspectRatio
	local isTradingVIP = p1.props.isTradingVIP
	local v1 = isTradingVIP and TradeConsts.VIP_INITIATION_COLOR or Color3.new(255/255, 255/255, 255/255)
	local t = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = p1.props.aspectRatio
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
				TextColor3 = v1,
				Text = p1.props.displayName .. " wants to trade!",
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.FredokaOne,
				LineHeight = 1,
				TextScaled = true
			})
		})
	}
	local t2 = {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(0.3177083333333333, 0, 0.5 - 0.03125 * aspectRatio, 0),
		Position = UDim2.new(0.015625, 0, 0.5 + 0.015625 * aspectRatio, 0)
	}
	local t3 = {}
	local t4 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		TextColor3 = Color3.new(255/255, 0/255, 0/255)
	}
	t4.Text = tostring(p1.state.remaining) .. "s"
	t4.TextXAlignment = Enum.TextXAlignment.Left
	t4.TextYAlignment = Enum.TextYAlignment.Bottom
	t4.Font = Enum.Font.FredokaOne
	t4.LineHeight = 1
	t4.TextScaled = true
	t3.Text = createElement("TextLabel", t4)
	t.Time = createElement("Frame", t2, t3)
	t.Accept = createElement(TradeButton, {
		backgroundColor = Color3.fromRGB(42, 170, 255),
		size = UDim2.new(0.25, 0, 0.5 - 0.015625 * aspectRatio, 0),
		position = UDim2.new(0.734375, 0, 0.5, 0),
		aspectRatio = Roact.None,
		text = "Trade",
		onClick = p1.onAccept,
		cornerPixel = 0,
		cornerScale = 1
	})
	t.Decline = createElement(TradeButton, {
		backgroundColor = Color3.fromRGB(255, 58, 43),
		size = UDim2.new(0.25, 0, 0.5 - 0.015625 * aspectRatio, 0),
		position = UDim2.new(0.46875, 0, 0.5, 0),
		aspectRatio = Roact.None,
		text = "Decline",
		onClick = p1.onDecline,
		cornerPixel = 0,
		cornerScale = 1
	})
	if isTradingVIP then
		t.UIStroke = createElement("UIStroke", {
			Transparency = 0.5,
			Thickness = 3,
			Color = TradeConsts.VIP_INITIATION_COLOR
		})
	end
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BackgroundTransparency = 0.5,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
	}, t)
end
function v1._hookObj(p1) --[[ Line: 123 | Upvalues: TradeConsts (copy) ]]
	p1:setState({
		createdAt = p1.props.obj:GetAttribute(TradeConsts.INITIATION_CREATED_AT_ATTR_NAME)
	})
	p1.maid:GiveTask(p1.props.obj:GetAttributeChangedSignal(TradeConsts.INITIATION_CREATED_AT_ATTR_NAME):Connect(function() --[[ Line: 128 | Upvalues: p1 (copy), TradeConsts (ref) ]]
		p1:setState({
			createdAt = p1.props.obj:GetAttribute(TradeConsts.INITIATION_CREATED_AT_ATTR_NAME)
		})
	end))
end
function v1.didMount(p1) --[[ Line: 135 | Upvalues: TradeConsts (copy), Interval (copy) ]]
	if p1.props.obj then
		p1:_hookObj()
	end
	local function update() --[[ Line: 139 | Upvalues: p1 (copy), TradeConsts (ref) ]]
		local t = {}
		t.remaining = math.floor((math.max(0, (p1.props.isTradingVIP and TradeConsts.VIP_INITIATION_TIMEOUT or TradeConsts.INITIATION_TIMEOUT) - (workspace:GetServerTimeNow() - p1.state.createdAt))))
		p1:setState(t)
	end
	update()
	p1.maid:GiveTask(Interval.every(1):Connect(update))
end
function v1.didUpdate(p1, p2, p3) --[[ Line: 151 ]]
	if p1.props.obj ~= p2.obj and p1.props.obj then
		p1:_hookObj()
	end
end
function v1.willUnmount(p1) --[[ Line: 158 ]]
	p1.maid:DoCleaning()
end
return v1