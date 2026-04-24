-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("ReceiptItem")
function v1.init(p1)
	p1:setState({
		hover = false
	})
end
function v1.render(p1)
	local mainRatio = p1.props.mainRatio
	local cornerPixel = p1.props.cornerPixel
	local paddingRatio = p1.props.paddingRatio
	local v1 = if p1.state.hover then 0.3 else 0.25
	local t = {}
	t.BackgroundTransparency = if p1.state.hover then 0 else 1
	t.AutoButtonColor = false
	t.Text = ""
	t.BackgroundColor3 = Color3.new(51/255, 51/255, 51/255)
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
	t[Roact.Event.Activated] = p1.props.onRequestRemove
	local t2 = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = mainRatio
		})
	}
	local t3 = {
		Size = UDim2.new(v1 / mainRatio, 0, v1, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1 - 1 / paddingRatio, 0, 0.5, 0)
	}
	t3.BackgroundColor3 = if p1.state.hover then Color3.new(1, 0.3, 0.3) else Color3.new(255/255, 0/255, 0/255)
	t2.Delete = createElement("Frame", t3, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	})
	local t4 = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1 - v1 / mainRatio - 4 / paddingRatio - 0.05, 0, 0.5 - mainRatio / paddingRatio, 0),
		Position = UDim2.new(2 / paddingRatio, 0, mainRatio / paddingRatio, 0)
	}
	local t5 = {}
	local t6 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(1, 0, 1, 0),
		AnchorPoint = Vector2.new(1, 1),
		Text = p1.props.title,
		Font = Enum.Font.Bangers,
		LineHeight = 0.95,
		TextScaled = true
	}
	t6.TextColor3 = p1.state.hover and Color3.new(255/255, 0/255, 0/255) or Color3.new(255/255, 255/255, 255/255)
	t6.TextXAlignment = Enum.TextXAlignment.Right
	t6.TextYAlignment = Enum.TextYAlignment.Top
	t5.Title = createElement("TextLabel", t6)
	t2.Title = createElement("Frame", t4, t5)
	t2.Type = createElement("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5 - 2 / paddingRatio - 0.05, 0, 0.5 - mainRatio / paddingRatio, 0),
		Position = UDim2.new(2 / paddingRatio, 0, 0.5, 0)
	}, {
		Title = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.6, 0),
			Position = UDim2.new(0, 0, 1, 0),
			AnchorPoint = Vector2.new(0, 1),
			Text = p1.props.categoryTitle,
			Font = Enum.Font.Bangers,
			LineHeight = 0.95,
			TextScaled = true,
			TextColor3 = Color3.fromRGB(98, 222, 253),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Bottom
		})
	})
	local t7 = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5 - v1 / mainRatio - 2 / paddingRatio, 0, 0.5 - mainRatio / paddingRatio, 0),
		Position = UDim2.new(0.45, 0, 0.5, 0)
	}
	local t8 = {}
	local t9 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.8, 0),
		Position = UDim2.new(0, 0, 1, 0),
		AnchorPoint = Vector2.new(0, 1)
	}
	t9.Text = if p1.props.owned then "OWNED" else p1.props.price and "-$" .. String.comma(p1.props.price) or "FREE"
	t9.Font = Enum.Font.Bangers
	t9.LineHeight = 0.95
	t9.TextScaled = true
	t9.TextColor3 = p1.props.owned and Color3.fromRGB(134, 195, 81) or Color3.new(255/255, 0/255, 0/255)
	t9.TextXAlignment = Enum.TextXAlignment.Right
	t9.TextYAlignment = Enum.TextYAlignment.Top
	t8.Title = createElement("TextLabel", t9)
	t2.Price = createElement("Frame", t7, t8)
	return createElement("TextButton", t, t2)
end
return v1
