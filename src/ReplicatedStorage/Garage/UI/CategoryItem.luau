-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("CategoryItem")
function v1.init(p1)
	p1:setState({
		hover = false
	})
end
function v1.render(p1)
	local mainRatio = p1.props.mainRatio
	local paddingRatio = p1.props.paddingRatio
	local t = {}
	t.BackgroundTransparency = if p1.state.hover or p1.props.selected then 0 else 1
	t.AutoButtonColor = false
	t.Text = ""
	t.BackgroundColor3 = if p1.props.selected then Color3.fromRGB(98, 222, 253) else Color3.new(51/255, 51/255, 51/255)
	t.BorderSizePixel = 0
	t.Size = UDim2.new(1, 0, 1, 0)
	t.LayoutOrder = p1.props.layoutOrder
	t.Selectable = true
	t[Roact.Event.MouseEnter] = function()
		p1:setState({
			hover = true
		})
	end
	t[Roact.Event.MouseLeave] = function()
		p1:setState({
			hover = false
		})
	end
	t[Roact.Event.SelectionGained] = function()
		p1:setState({
			hover = true
		})
	end
	t[Roact.Event.SelectionLost] = function()
		p1:setState({
			hover = false
		})
	end
	t[Roact.Event.Activated] = p1.props.onSelect
	local t2 = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = mainRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, p1.props.cornerPixel)
		})
	}
	local t3 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1 - 0.6 / mainRatio, 0, 0.4, 0),
		Position = UDim2.new(1 - 0.3 / mainRatio, 0, 0.3, 0),
		AnchorPoint = Vector2.new(1, 0),
		Text = p1.props.title,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true
	}
	t3.TextColor3 = p1.props.selected and Color3.new(0/255, 0/255, 0/255) or Color3.new(255/255, 255/255, 255/255)
	t3.TextXAlignment = Enum.TextXAlignment.Right
	t3.TextYAlignment = Enum.TextYAlignment.Center
	t2.Title = createElement("TextLabel", t3)
	return createElement("TextButton", t, t2)
end
return v1
