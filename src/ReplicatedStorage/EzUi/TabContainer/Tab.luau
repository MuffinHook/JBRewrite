local ezUiAncestor = script:FindFirstAncestor("EzUi")
local ColorUtils = require(ezUiAncestor.Parent.Std.ColorUtils)
local Roact = require(ezUiAncestor.Parent.Roact)
local createElement = Roact.createElement
local TabComponent = Roact.PureComponent:extend("Tab")
function TabComponent.init(component)
	component:setState({
		hover = false
	})
end
function TabComponent.render(component)
	local buttonColor = component.props.active and component.props.backgroundColor or (component.state.hover and ColorUtils.brightenTo(component.props.backgroundColor, 0.4) or ColorUtils.brightenTo(component.props.backgroundColor, 0.2))
	local buttonProps = {
		Size = component.props.scaleXBinding:map(function(scaleX)
			return UDim2.new(scaleX, -component.props.paddingX, 1, 0)
		end),
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		BackgroundColor3 = buttonColor,
		LayoutOrder = component.props.layoutOrder,
		Text = "",
		AutoButtonColor = false,
		[Roact.Event.MouseButton1Down] = component.props.onClick,
		[Roact.Event.MouseEnter] = function()
			component:setState({
				hover = true
			})
		end,
		[Roact.Event.MouseLeave] = function()
			component:setState({
				hover = false
			})
		end
	}
	local buttonChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 6)
		})
	}
	local titleProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.6, 0, 0.6, 0),
		Position = UDim2.new(0.2, 0, 0.2, 0),
		Text = component.props.title,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true
	}
	titleProps.TextColor3 = component.props.active and Color3.new(255/255, 255/255, 255/255) or ColorUtils.saturateTo(ColorUtils.brightenBy(buttonColor, 2), 0)
	buttonChildren.Title = createElement("TextLabel", titleProps)
	return createElement("TextButton", buttonProps, buttonChildren)
end
return TabComponent
