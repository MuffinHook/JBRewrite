local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local ElapsedComponent = Roact.PureComponent:extend("Elapsed")
ElapsedComponent.defaultProps = {
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
function ElapsedComponent.init(self)
	self:setState({
		elapsed = 0
	})
	self.maid = Maid.new()
end
function ElapsedComponent.render(self)
	local elapsedTime = self.props.elapsed or self.state.elapsed
	local hours = math.floor(elapsedTime % 86400 / 3600)
	local minutes = math.floor(elapsedTime % 3600 / 60)
	local seconds = math.floor(elapsedTime % 60)
	local alwaysShowHours = self.props.alwaysShowHours
	if not alwaysShowHours then
		alwaysShowHours = hours > 0
	end
	local alwaysShowMinutes = self.props.alwaysShowMinutes
	if not alwaysShowMinutes then
		alwaysShowMinutes = alwaysShowHours or minutes > 0
	end
	local alwaysShowSeconds = self.props.alwaysShowSeconds
	if not alwaysShowSeconds then
		alwaysShowSeconds = alwaysShowMinutes or seconds >= 0
	end
	local formattedText = ("%s%s%s%s%s"):format(self.props.prefix, if alwaysShowHours then ("%02d:"):format(hours) else "", if alwaysShowMinutes then ("%02d:"):format(minutes) else "", if alwaysShowSeconds then ("%02d"):format(seconds) else "", self.props.suffix)
	local placeholderText = ("%s--%s"):format(self.props.prefix, self.props.suffix)
	local frameProps = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint
	}
	local textLabelContainer = {}
	local textLabelProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.9, 0, 0.8, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	textLabelProps.Text = if self.props.disabled then placeholderText else formattedText
	textLabelProps.TextXAlignment = self.props.textXAlignment
	textLabelProps.Font = self.props.font
	textLabelProps.LineHeight = 1
	textLabelProps.TextScaled = true
	textLabelProps.TextColor3 = self.props.textColor
	textLabelProps[Roact.Children] = self.props[Roact.Children]
	textLabelContainer.Text = createElement("TextLabel", textLabelProps)
	return createElement("Frame", frameProps, textLabelContainer)
end
function ElapsedComponent._startCounting(self)
	local function update()
		local currentServerTime = workspace:GetServerTimeNow()
		local creationTime
		if self.props.createdAtBinding then
			creationTime = self.props.createdAtBinding:getValue()
		elseif self.props.createdAt then
			creationTime = self.props.createdAt
		else
			warn("No createdAt exists")
			creationTime = 0
		end
		local elapsedDuration = if self.props.countDown then creationTime - currentServerTime else currentServerTime - creationTime
		local stateUpdate = {}
		stateUpdate.elapsed = math.max(0, (math.floor(elapsedDuration)))
		self:setState(stateUpdate)
		if self.props.onElapsed then
			self.props.onElapsed(elapsedDuration)
		end
	end
	update()
	self.maid.counting = Interval.every(0.5):Connect(update)
end
function ElapsedComponent.didMount(self)
	if not (self.props.elapsed or self.props.disabled) then
		self:_startCounting()
	end
end
function ElapsedComponent.didUpdate(self, previousProps, previousState)
	if self.props.elapsed or self.props.disabled then
		self.maid.counting = nil
	elseif self.maid.counting == nil then
		self:_startCounting()
	end
end
function ElapsedComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return ElapsedComponent
