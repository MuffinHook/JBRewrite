-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local createElement = Roact.createElement
local color = Roact.PureComponent:extend("LikePrompt")
color.defaultProps = {
	size = UDim2.fromScale(0.75, 0.05),
	anchorPoint = Vector2.new(0.5, 0),
	position = UDim2.fromScale(0.5, 0)
}
function color.init(p1)
	p1.maid = Maid.new()
	p1:setState({
		remaining = 0
	})
end
function color.render(p1)
	if p1.props.visible then
		local color = Color3.fromRGB(1, 255, 171)
		local t = {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			BackgroundTransparency = 0,
			Size = p1.props.size,
			AnchorPoint = p1.props.anchorPoint,
			Position = p1.props.position
		}
		local t2 = {
			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 18
			})
		}
		local t3 = {
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
					BackgroundColor3 = color,
					Selectable = true,
					[Roact.Event.Activated] = p1.props.onClickDone
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
		local t4 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.05555555555555555, 1),
			Position = UDim2.fromScale(0.9444444444444444, 0)
		}
		local t5 = {}
		local t6 = {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0.8),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Font = Enum.Font.FredokaOne
		}
		t6.Text = tostring((math.max(0, (math.floor(p1.state.remaining)))))
		t6.TextColor3 = Color3.new(0.3, 0.3, 0.3)
		t6.TextScaled = true
		t5.Text = createElement("TextLabel", t6)
		t3.CountdownContainer = createElement("Frame", t4, t5)
		t2.Inner = createElement(PaddedContainer, {
			aspectRatio = 18,
			verticalPaddingRatio = 7.111111111111111,
			backgroundTransparency = 1
		}, t3)
		t2.Stroke = createElement("UIStroke", {
			Thickness = 1,
			Color = Color3.new(0.7, 0.7, 0.7)
		})
		return createElement("Frame", t, t2)
	end
end
function color._update(p1)
	if p1.props.visible then
		local color = p1.props.countdownTil - workspace:GetServerTimeNow()
		p1:setState({
			remaining = color
		})
		if p1.state.remaining > 0 and (color <= 0 and p1.props.onExpired) then
			p1.props.onExpired()
		end
	end
end
function color.didMount(p1)
	p1:_update()
	p1.maid:GiveTask(Interval.every(1):Connect(function()
		p1:_update()
	end))
end
function color.willUnmount(p1)
	p1.maid:DoCleaning()
end
return color
