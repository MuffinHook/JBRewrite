-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local TradeButton = require(ReplicatedStorage.Trade.UI.TradeButton)
local local1 = Roact.PureComponent:extend("BattleInvite")
local1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 6
}
function local1.init(self)
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
function local1.render(self)
	local aspectRatio = self.props.aspectRatio
	local local1 = self.props.ranked and Color3.fromRGB(255, 215, 0) or Color3.new(255/255, 255/255, 255/255)
	local local2 = if self.props.ranked then ("Enter ranked %d player crew battle?"):format(self.props.battleNumPlayersPerTeam) else ("Enter %d player crew battle against %s\'s %s (%s)?"):format(self.props.battleNumPlayersPerTeam, self.props.opposingClanOwnerName, self.props.clanName, self.props.clanDisplayRating or "N/A")
	local t = {
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
				TextColor3 = local1,
				Text = local2,
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.FredokaOne,
				LineHeight = 1,
				TextScaled = true
			})
		})
	}
	local table2 = {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(0.3177083333333333, 0, 0.5 - 0.03125 * aspectRatio, 0),
		Position = UDim2.new(0.015625, 0, 0.5 + 0.015625 * aspectRatio, 0)
	}
	local table3 = {}
	local table4 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		TextColor3 = Color3.new(255/255, 0/255, 0/255)
	}
	table4.Text = tostring(self.state.remaining) .. "s"
	table4.TextXAlignment = Enum.TextXAlignment.Left
	table4.TextYAlignment = Enum.TextYAlignment.Bottom
	table4.Font = Enum.Font.FredokaOne
	table4.LineHeight = 1
	table4.TextScaled = true
	table3.Text = createElement("TextLabel", table4)
	t.Time = createElement("Frame", table2, table3)
	t.Accept = createElement(TradeButton, {
		backgroundColor = Color3.fromRGB(42, 170, 255),
		size = UDim2.new(0.25, 0, 0.5 - 0.015625 * aspectRatio, 0),
		position = UDim2.new(0.734375, 0, 0.5, 0),
		aspectRatio = Roact.None,
		text = "Accept",
		onClick = self.onAccept,
		cornerPixel = 0,
		cornerScale = 1
	})
	t.Decline = createElement(TradeButton, {
		backgroundColor = Color3.fromRGB(255, 58, 43),
		size = UDim2.new(0.25, 0, 0.5 - 0.015625 * aspectRatio, 0),
		position = UDim2.new(0.46875, 0, 0.5, 0),
		aspectRatio = Roact.None,
		text = "Decline",
		onClick = self.onDecline,
		cornerPixel = 0,
		cornerScale = 1
	})
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BackgroundTransparency = 0.5,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint
	}, t)
end
function local1._hookObj(self)
	self:setState({
		createdAt = self.props.obj:GetAttribute(PersistentCrewBattleConsts.INVITE_CREATED_AT_ATTR_NAME)
	})
	self.maid.listenForInviteCreatedAtChanged = self.props.obj:GetAttributeChangedSignal(PersistentCrewBattleConsts.INVITE_CREATED_AT_ATTR_NAME):Connect(function()
		self:setState({
			createdAt = self.props.obj:GetAttribute(PersistentCrewBattleConsts.INVITE_CREATED_AT_ATTR_NAME)
		})
	end)
end
function local1.didMount(self)
	if self.props.obj then
		self:_hookObj()
	end
	local function update()
		local t = {}
		t.remaining = math.floor((math.max(0, PersistentCrewBattleConsts.INVITE_TIMEOUT_DURATION - (workspace:GetServerTimeNow() - self.state.createdAt))))
		self:setState(t)
	end
	update()
	self.maid:GiveTask(Interval.every(1):Connect(update))
end
function local1.didUpdate(self, self, param3)
	if self.props.obj ~= self.obj and self.props.obj then
		self:_hookObj()
	end
end
function local1.willUnmount(self)
	self.maid:DoCleaning()
end
return local1
