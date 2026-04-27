local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local createElement = Roact.createElement
local LikePrompt = Roact.PureComponent:extend("LikePrompt")
LikePrompt.defaultProps = {
	size = UDim2.fromScale(0.75, 0.05),
	anchorPoint = Vector2.new(0.5, 0),
	position = UDim2.fromScale(0.5, 0)
}
function LikePrompt.init(self)
	self.maid = Maid.new()
	self:setState({
		remaining = 0
	})
end
function LikePrompt.render(self)
	if self.props.visible then
		local accentColor = Color3.fromRGB(1, 255, 171)
		local rootFrameProps = {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			BackgroundTransparency = 0,
			Size = self.props.size,
			AnchorPoint = self.props.anchorPoint,
			Position = self.props.position
		}
		local innerContainerChildren = {
			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 18
			})
		}
		local contentChildren = {
			TitleContainer = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				size = UDim2.fromScale(0.7944444444444444, 1),
				paddingTop = 0,
				paddingBottom = 0,
				paddingLeft = 1,
				paddingRight = 0.5
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 0.9),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Font = Enum.Font.FredokaOne,
					Text = "Enjoying Jailbreak? Please thumbs up our game!",
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					TextScaled = true
				})
			}),
			ButtonContainer = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				size = UDim2.fromScale(0.15, 1),
				position = UDim2.fromScale(0.7944444444444444, 0),
				paddingTop = 0,
				paddingBottom = 0,
				paddingLeft = 0.5,
				paddingRight = 0
			}, {
				Button = createElement("TextButton", {
					BackgroundTransparency = 0,
					Size = UDim2.fromScale(1, 1),
					Text = "",
					BackgroundColor3 = accentColor,
					Selectable = true,
					[Roact.Event.Activated] = self.props.onClickDone
				}, {
					Corner = createElement("UICorner", {
						CornerRadius = UDim.new(1, 0)
					}),
					TitleContainer = createElement("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1)
					}, {
						Text = createElement("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 1),
							Position = UDim2.fromScale(0.5, 0.5),
							AnchorPoint = Vector2.new(0.5, 0.5),
							Font = Enum.Font.FredokaOne,
							Text = "OK!",
							TextColor3 = Color3.new(0/255, 0/255, 0/255),
							TextScaled = true
						})
					})
				})
			})
		}
		local countdownFrameProps = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.05555555555555555, 1),
			Position = UDim2.fromScale(0.9444444444444444, 0)
		}
		local countdownTextChildren = {}
		local countdownTextProps = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0.8),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Font = Enum.Font.FredokaOne
		}
		countdownTextProps.Text = tostring((math.max(0, (math.floor(self.state.remaining)))))
		countdownTextProps.TextColor3 = Color3.new(0.3, 0.3, 0.3)
		countdownTextProps.TextScaled = true
		countdownTextChildren.Text = createElement("TextLabel", countdownTextProps)
		contentChildren.CountdownContainer = createElement("Frame", countdownFrameProps, countdownTextChildren)
		innerContainerChildren.Inner = createElement(PaddedContainer, {
			aspectRatio = 18,
			verticalPaddingRatio = 7.111111111111111,
			backgroundTransparency = 1
		}, contentChildren)
		innerContainerChildren.Stroke = createElement("UIStroke", {
			Thickness = 1,
			Color = Color3.new(0.7, 0.7, 0.7)
		})
		return createElement("Frame", rootFrameProps, innerContainerChildren)
	end
end
function LikePrompt._update(self)
	if self.props.visible then
		local secondsRemaining = self.props.countdownTil - workspace:GetServerTimeNow()
		self:setState({
			remaining = secondsRemaining
		})
		if self.state.remaining > 0 and (secondsRemaining <= 0 and self.props.onExpired) then
			self.props.onExpired()
		end
	end
end
function LikePrompt.didMount(self)
	self:_update()
	self.maid:GiveTask(Interval.every(1):Connect(function()
		self:_update()
	end))
end
function LikePrompt.willUnmount(self)
	self.maid:DoCleaning()
end
return LikePrompt
