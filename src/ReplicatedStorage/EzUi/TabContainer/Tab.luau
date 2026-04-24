-- Reviewed by Claude
local v1 = script:FindFirstAncestor("EzUi")
local ColorUtils = require(v1.Parent.Std.ColorUtils)
local Roact = require(v1.Parent.Roact)
local createElement = Roact.createElement
local v2 = Roact.PureComponent:extend("Tab")
function v2.init(p1)
	p1:setState({
		hover = false
	})
end
function v2.render(p1)
	local v1 = p1.props.active and p1.props.backgroundColor or (p1.state.hover and ColorUtils.brightenTo(p1.props.backgroundColor, 0.4) or ColorUtils.brightenTo(p1.props.backgroundColor, 0.2))
	local t = {
		Size = p1.props.scaleXBinding:map(function(p12)
			return UDim2.new(p12, -p1.props.paddingX, 1, 0)
		end),
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		BackgroundColor3 = v1,
		LayoutOrder = p1.props.layoutOrder,
		Text = "",
		AutoButtonColor = false,
		[Roact.Event.MouseButton1Down] = p1.props.onClick,
		[Roact.Event.MouseEnter] = function()
			p1:setState({
				hover = true
			})
		end,
		[Roact.Event.MouseLeave] = function()
			p1:setState({
				hover = false
			})
		end
	}
	local t2 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 6)
		})
	}
	local t3 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.6, 0, 0.6, 0),
		Position = UDim2.new(0.2, 0, 0.2, 0),
		Text = p1.props.title,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true
	}
	t3.TextColor3 = p1.props.active and Color3.new(255/255, 255/255, 255/255) or ColorUtils.saturateTo(ColorUtils.brightenBy(v1, 2), 0)
	t2.Title = createElement("TextLabel", t3)
	return createElement("TextButton", t, t2)
end
return v2
