-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local local1 = Roact.PureComponent:extend("Elapsed")
local1.defaultProps = {
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5),
	createdAt = nil,
	createdAtBinding = nil,
	textXAlignment = Enum.TextXAlignment.Center,
	prefix = "",
	suffix = "",
	disabled = false,
	font = Enum.Font.FredokaOne,
	textColor = Color3.new(0/255, 0/255, 0/255),
	countDown = false,
	alwaysShowHours = false,
	alwaysShowMinutes = true,
	alwaysShowSeconds = true
}
function local1.init(self)
	self:setState({
		elapsed = 0
	})
	self.maid = Maid.new()
end
function local1.render(self)
	local local1 = self.props.elapsed or self.state.elapsed
	local constant = math.floor(local1 % 86400 / 3600)
	local local3 = math.floor(local1 % 3600 / 60)
	local local4 = math.floor(local1 % 60)
	local alwaysShowHours = self.props.alwaysShowHours
	if not alwaysShowHours then
		alwaysShowHours = constant > 0
	end
	local alwaysShowMinutes = self.props.alwaysShowMinutes
	if not alwaysShowMinutes then
		alwaysShowMinutes = alwaysShowHours or local3 > 0
	end
	local alwaysShowSeconds = self.props.alwaysShowSeconds
	if not alwaysShowSeconds then
		alwaysShowSeconds = alwaysShowMinutes or local4 >= 0
	end
	local local8 = ("%s%s%s%s%s"):format(self.props.prefix, if alwaysShowHours then ("%02d:"):format(constant) else "", if alwaysShowMinutes then ("%02d:"):format(local3) else "", if alwaysShowSeconds then ("%02d"):format(local4) else "", self.props.suffix)
	local local9 = ("%s--%s"):format(self.props.prefix, self.props.suffix)
	local t = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint
	}
	local table2 = {}
	local table3 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.9, 0, 0.8, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	table3.Text = if self.props.disabled then local9 else local8
	table3.TextXAlignment = self.props.textXAlignment
	table3.Font = self.props.font
	table3.LineHeight = 1
	table3.TextScaled = true
	table3.TextColor3 = self.props.textColor
	table3[Roact.Children] = self.props[Roact.Children]
	table2.Text = createElement("TextLabel", table3)
	return createElement("Frame", t, table2)
end
function local1._startCounting(self)
	local function update()
		local local1 = workspace:GetServerTimeNow()
		local constant
		if self.props.createdAtBinding then
			constant = self.props.createdAtBinding:getValue()
		elseif self.props.createdAt then
			constant = self.props.createdAt
		else
			warn("No createdAt exists")
			constant = 0
		end
		local local4 = if self.props.countDown then constant - local1 else local1 - constant
		local t = {}
		t.elapsed = math.max(0, (math.floor(local4)))
		self:setState(t)
		if self.props.onElapsed then
			self.props.onElapsed(local4)
		end
	end
	update()
	self.maid.counting = Interval.every(0.5):Connect(update)
end
function local1.didMount(self)
	if not (self.props.elapsed or self.props.disabled) then
		self:_startCounting()
	end
end
function local1.didUpdate(self, param2, param3)
	if self.props.elapsed or self.props.disabled then
		self.maid.counting = nil
	elseif self.maid.counting == nil then
		self:_startCounting()
	end
end
function local1.willUnmount(self)
	self.maid:DoCleaning()
end
return local1
