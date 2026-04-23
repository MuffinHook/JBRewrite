local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("ProgressBar")
v1.defaultProps = {
	aspectRatio = 19,
	verticalPaddingRatio = 4.266666666666667,
	text = "",
	size = UDim2.fromScale(1, 0.3),
	position = UDim2.fromScale(0, 0),
	textStrokeThickness = 1,
	barStrokeThickness = 3,
	barStrokeColor = Color3.new(0/255, 0/255, 0/255),
	progress = 0.4,
	unfilledColor = Color3.new(0/255, 0/255, 0/255),
	filledColor = Color3.new(0.47451, 0.760784, 0.309804)
}
function v1.render(p1) --[[ Line: 22 | Upvalues: createElement (copy), PaddedContainer (copy), Roact (copy) ]]
	local progress = p1.props.progress
	if progress > 1 then
		warn("Passed larger progress than max:", progress)
		progress = 1
	elseif progress < 0 then
		warn("Passed negative progress:", progress)
		progress = 0
	end
	return createElement("Frame", {
		Size = p1.props.size,
		Position = p1.props.position,
		BackgroundTransparency = 1
	}, {
		TotalCurrency = createElement(PaddedContainer, {
			backgroundTransparency = 0,
			backgroundColor = p1.props.unfilledColor,
			aspectRatio = p1.props.aspectRatio,
			verticalPaddingRatio = p1.props.verticalPaddingRatio,
			size = UDim2.fromScale(1, 1),
			position = UDim2.fromScale(0, 0),
			anchorPoint = p1.props.anchorPoint,
			paddingNone = true
		}, {
			Stroke = createElement("UIStroke", {
				Thickness = p1.props.barStrokeThickness,
				Color = p1.props.barStrokeColor
			}),
			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			CurrCurrency = createElement(PaddedContainer, {
				size = UDim2.fromScale(progress, 1),
				position = UDim2.fromScale(0, 0),
				paddingNone = true,
				backgroundColor = p1.props.filledColor,
				[Roact.Ref] = p1.props.currCurrencyRef
			}, {
				Corner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				})
			}),
			ReasonText = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Font = Enum.Font.GothamBlack,
				TextXAlignment = Enum.TextXAlignment.Center,
				Text = p1.props.text,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				ZIndex = 3
			}, {
				Stroke = createElement("UIStroke", {
					Thickness = p1.props.textStrokeThickness,
					Color = Color3.new(0/255, 0/255, 0/255)
				})
			})
		})
	})
end
return v1