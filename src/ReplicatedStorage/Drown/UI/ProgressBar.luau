local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
local ProgressBarComponent = Roact.PureComponent:extend("ProgressBar")
ProgressBarComponent.defaultProps = {
	aspectRatio = 19,
	verticalPaddingRatio = 64/15,
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
function ProgressBarComponent.render(props)
	local progress = props.props.progress
	if progress > 1 then
		warn("Passed larger progress than max:", progress)
		progress = 1
	elseif progress < 0 then
		warn("Passed negative progress:", progress)
		progress = 0
	end
	return createElement("Frame", {
		Size = props.props.size,
		Position = props.props.position,
		BackgroundTransparency = 1
	}, {
		TotalCurrency = createElement(PaddedContainer, {
			backgroundTransparency = 0,
			backgroundColor = props.props.unfilledColor,
			aspectRatio = props.props.aspectRatio,
			verticalPaddingRatio = props.props.verticalPaddingRatio,
			size = UDim2.fromScale(1, 1),
			position = UDim2.fromScale(0, 0),
			anchorPoint = props.props.anchorPoint,
			paddingNone = true
		}, {
			Stroke = createElement("UIStroke", {
				Thickness = props.props.barStrokeThickness,
				Color = props.props.barStrokeColor
			}),
			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			CurrCurrency = createElement(PaddedContainer, {
				size = UDim2.fromScale(progress, 1),
				position = UDim2.fromScale(0, 0),
				paddingNone = true,
				backgroundColor = props.props.filledColor,
				[Roact.Ref] = props.props.currCurrencyRef
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
				Text = props.props.text,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				ZIndex = 3
			}, {
				Stroke = createElement("UIStroke", {
					Thickness = props.props.textStrokeThickness,
					Color = Color3.new(0/255, 0/255, 0/255)
				})
			})
		})
	})
end
return ProgressBarComponent
