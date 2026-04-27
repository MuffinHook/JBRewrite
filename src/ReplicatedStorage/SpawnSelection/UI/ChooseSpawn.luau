local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local ChooseSpawnComponent = Roact.PureComponent:extend("ChooseSpawn")
ChooseSpawnComponent.defaultProps = {
	visible = false,
	mapScale = 1,
	bornAt = workspace:GetServerTimeNow(),
	duration = 5,
	position = UDim2.new(0.5, 0, 0.5, 0),
	size = UDim2.new(0.25, 0, 0.25, 0)
}
function ChooseSpawnComponent.init(self)
	self.maid = Maid.new()
	self:setState({
		remaining = self.props.duration
	})
	function self.onSelect()
		self.props.onSelect()
		self.props.hide()
	end
end
function ChooseSpawnComponent.render(self)
	if self.props.visible then
		local frameProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = self.props.size,
			Position = self.props.position,
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		local childrenProps = {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 6
			})
		}
		local leftFrameProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1/6, 0, 1, 0)
		}
		local leftChildrenProps = {}
		local timerInnerProps = {
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		}
		local timerInnerChildrenProps = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			UIStroke = createElement("UIStroke", {
				Color = Color3.new(51/255, 51/255, 51/255),
				Thickness = 1,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			})
		}
		local timerTextProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		timerTextProps.Text = tostring(self.state.remaining)
		timerTextProps.Font = Enum.Font.Bangers
		timerTextProps.LineHeight = 1
		timerTextProps.TextScaled = true
		timerTextProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		timerInnerChildrenProps.Text = createElement("TextLabel", timerTextProps)
		leftChildrenProps.Inner = createElement("Frame", timerInnerProps, timerInnerChildrenProps)
		childrenProps.Left = createElement("Frame", leftFrameProps, leftChildrenProps)
		childrenProps.Right = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(1/6, 0, 0, 0),
			Size = UDim2.new(5/6, 0, 1, 0)
		}, {
			Inner = createElement("TextButton", {
				Text = "",
				Size = UDim2.new(0.98, 0, 0.9, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
				Selectable = true,
				[Roact.Event.Activated] = self.onSelect
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0.25, 0)
				}),
				UIStroke = createElement("UIStroke", {
					Color = Color3.new(255/255, 255/255, 255/255),
					Thickness = 1,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				}),
				Title = createElement("Frame", {
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 0, 0, 0)
				}, {
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(0.9, 0, 0.9, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Text = "Choose Spawn",
						Font = Enum.Font.Bangers,
						LineHeight = 1,
						TextScaled = true,
						TextColor3 = Color3.new(255/255, 255/255, 255/255)
					})
				})
			})
		})
		return createElement("Frame", frameProps, childrenProps)
	end
end
function ChooseSpawnComponent.didUpdate(self, prevProps, prevState)
	if prevProps.duration ~= self.props.duration or prevProps.bornAt ~= self.props.bornAt then
		self:_startTimer()
	end
end
function ChooseSpawnComponent._startTimer(self)
	local function update()
		local elapsedTime = workspace:GetServerTimeNow() - self.props.bornAt
		local shouldHide
		if self.props.duration <= elapsedTime then
			self.maid.countdown = nil
			shouldHide = true
		else
			shouldHide = false
		end
		local stateUpdate = {}
		stateUpdate.remaining = math.max(0, (math.ceil(self.props.duration - elapsedTime)))
		self:setState(stateUpdate)
		if shouldHide then
			self.props.hide()
		end
	end
	update()
	self.maid.countdown = Interval.every(1):Connect(update)
end
function ChooseSpawnComponent.didMount(self)
	if self.props.visible then
		self:_startTimer()
	end
end
function ChooseSpawnComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(state, dispatch)
	return {
		bornAt = state.lastDiedAt,
		visible = state.spawnSelectionOfferVisible
	}
end, function(dispatch)
	return {
		hide = function()
			dispatch({
				type = "setSpawnSelectionOfferVisible",
				visible = false
			})
		end
	}
end)(ChooseSpawnComponent)
