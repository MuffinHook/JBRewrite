local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
return function(props)
	local backgroundColor = if props.selected then props.selectedBgColor else Color3.new(0/255, 0/255, 0/255)
	local textColor = if props.selected then ColorUtils.brightenBy(backgroundColor, -0.8) else Color3.new(255/255, 255/255, 255/255)
	return createElement("TextButton", {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = backgroundColor,
		Size = props.size,
		Position = props.position,
		Text = "",
		Selectable = true,
		[Roact.Event.Activated] = function()
			if props.onClick then
				props.onClick(props.index)
			end
		end
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Inner = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			aspectRatio = props.aspectRatio,
			verticalPaddingRatio = 1 / props.paddingRatio,
			paddingTop = 0,
			paddingBottom = 0,
			paddingLeft = 0,
			paddingRight = 0
		}, {
			TitleContainer = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				size = UDim2.fromScale(1, 1),
				paddingTop = 1,
				paddingBottom = 1
			}, {
				Title = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromScale(1, 0.5),
					AnchorPoint = Vector2.new(1, 0.5),
					Text = props.title,
					Font = Enum.Font.FredokaOne,
					LineHeight = 1,
					TextScaled = true,
					TextXAlignment = Enum.TextXAlignment.Right,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextColor3 = textColor
				})
			})
		})
	})
end
