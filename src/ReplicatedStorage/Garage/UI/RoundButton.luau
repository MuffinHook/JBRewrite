local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local RoundButton = Roact.PureComponent:extend("RoundButton")
RoundButton.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	disabled = false
}
function RoundButton.render(component)
	local aspectRatio = component.props.aspectRatio
	local buttonProps = {
		AutoButtonColor = not component.props.disabled,
		Text = "",
		BackgroundTransparency = 0,
		BorderSizePixel = 0
	}
	buttonProps.BackgroundColor3 = component.props.disabled and ColorUtils.brightenTo(component.props.color, 0.1) or component.props.color
	buttonProps.Position = component.props.position
	buttonProps.AnchorPoint = component.props.anchorPoint
	buttonProps.Size = component.props.size
	buttonProps.LayoutOrder = component.props.layoutOrder
	buttonProps[Roact.Event.Activated] = component.props.onClick
	local children = {}
	children.AspectRatio = if component.props.aspectRatio == nil then false else createElement("UIAspectRatioConstraint", {
	AspectRatio = component.props.aspectRatio
})
	children.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(1, 0)
	})
	children.Title = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.7, 0, 0.7, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Text = component.props.title,
		Font = Enum.Font.Bangers,
		LineHeight = 0.9,
		TextScaled = true,
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	}, {
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(0/255, 0/255, 0/255),
			Thickness = 1
		})
	})
	local lockElement
	if component.props.locked == nil then
		lockElement = false
	else
		local lockIconProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.6 / aspectRatio, 0, 0.6, 0),
			Position = UDim2.new(0.2 / aspectRatio, 0, 0.2, 0)
		}
		lockIconProps.Image = if component.props.locked then "rbxassetid://8715708455" else "rbxassetid://8715708824"
		lockElement = createElement("ImageLabel", lockIconProps)
	end
	children.Lock = lockElement
	return createElement("TextButton", buttonProps, children)
end
return RoundButton
