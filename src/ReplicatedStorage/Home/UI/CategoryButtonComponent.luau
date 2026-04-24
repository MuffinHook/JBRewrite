-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
return function(p1)
	local color = if p1.selected then p1.selectedBgColor else Color3.new(0/255, 0/255, 0/255)
	local color2 = if p1.selected then ColorUtils.brightenBy(color, -0.8) else Color3.new(255/255, 255/255, 255/255)
	return createElement("TextButton", {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = color,
		Size = p1.size,
		Position = p1.position,
		Text = "",
		Selectable = true,
		[Roact.Event.Activated] = function()
			if p1.onClick then
				p1.onClick(p1.index)
			end
		end
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Inner = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			aspectRatio = p1.aspectRatio,
			verticalPaddingRatio = 1 / p1.paddingRatio,
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
					Text = p1.title,
					Font = Enum.Font.FredokaOne,
					LineHeight = 1,
					TextScaled = true,
					TextXAlignment = Enum.TextXAlignment.Right,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextColor3 = color2
				})
			})
		})
	})
end
