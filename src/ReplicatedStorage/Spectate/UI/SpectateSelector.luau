-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("SpectateSelector")
v1.defaultProps = {
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	title = "N/A"
}
function v1.render(p1)
	return createElement("Frame", {
		BackgroundTransparency = 0.8,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		Size = p1.props.size,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = p1.props.position
	}, {
		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 8
		}),
		PaddedContainer = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			aspectRatio = 8,
			verticalPaddingRatio = 16,
			paddingNone = true
		}, {
			Left = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				size = UDim2.fromScale(0.125, 1),
				position = UDim2.fromScale(0, 0),
				paddingRight = 0.5
			}, {
				Button = createElement("TextButton", {
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(192, 122, 255),
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.FredokaOne,
					TextScaled = true,
					Text = "<",
					Selectable = true,
					[Roact.Event.Activated] = p1.props.onClickPrev
				}, {
					Corner = createElement("UICorner", {
						CornerRadius = UDim.new(0, 4)
					})
				})
			}),
			Name = createElement(PaddedContainer, {
				backgroundTransparency = 0,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				size = UDim2.fromScale(0.75, 1),
				position = UDim2.fromScale(0.125, 0),
				paddingLeft = 0.5,
				paddingRight = 0.5
			}, {
				Corner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Title = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1.25, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = p1.props.title,
					Font = Enum.Font.FredokaOne,
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					TextScaled = true
				})
			}),
			Right = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				size = UDim2.fromScale(0.125, 1),
				position = UDim2.fromScale(0.875, 0),
				paddingLeft = 0.5
			}, {
				Button = createElement("TextButton", {
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(192, 122, 255),
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.FredokaOne,
					TextScaled = true,
					Text = ">",
					Selectable = true,
					[Roact.Event.Activated] = p1.props.onClickNext
				}, {
					Corner = createElement("UICorner", {
						CornerRadius = UDim.new(0, 4)
					})
				})
			})
		})
	})
end
return v1
