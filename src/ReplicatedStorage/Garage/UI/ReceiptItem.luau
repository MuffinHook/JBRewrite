local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local ReceiptItem = Roact.PureComponent:extend("ReceiptItem")
function ReceiptItem.init(self)
	self:setState({
		hover = false
	})
end
function ReceiptItem.render(self)
	local mainRatio = self.props.mainRatio
	local cornerPixel = self.props.cornerPixel
	local paddingRatio = self.props.paddingRatio
	local hoverScale = if self.state.hover then 0.3 else 0.25
	local buttonProperties = {}
	buttonProperties.BackgroundTransparency = if self.state.hover then 0 else 1
	buttonProperties.AutoButtonColor = false
	buttonProperties.Text = ""
	buttonProperties.BackgroundColor3 = Color3.new(51/255, 51/255, 51/255)
	buttonProperties.BorderSizePixel = 0
	buttonProperties.Size = UDim2.new(1, 0, 1, 0)
	buttonProperties.LayoutOrder = self.props.layoutOrder
	buttonProperties.Selectable = true
	buttonProperties[Roact.Event.MouseEnter] = function()
		self:setState({
			hover = true
		})
	end
	buttonProperties[Roact.Event.MouseLeave] = function()
		self:setState({
			hover = false
		})
	end
	buttonProperties[Roact.Event.SelectionGained] = function()
		self:setState({
			hover = true
		})
	end
	buttonProperties[Roact.Event.SelectionLost] = function()
		self:setState({
			hover = false
		})
	end
	buttonProperties[Roact.Event.Activated] = self.props.onRequestRemove
	local children = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = mainRatio
		})
	}
	local deleteButtonProperties = {
		Size = UDim2.new(hoverScale / mainRatio, 0, hoverScale, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1 - 1 / paddingRatio, 0, 0.5, 0)
	}
	deleteButtonProperties.BackgroundColor3 = if self.state.hover then Color3.new(1, 0.3, 0.3) else Color3.new(255/255, 0/255, 0/255)
	children.Delete = createElement("Frame", deleteButtonProperties, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	})
	local titleFrameProperties = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1 - hoverScale / mainRatio - 4 / paddingRatio - 0.05, 0, 0.5 - mainRatio / paddingRatio, 0),
		Position = UDim2.new(2 / paddingRatio, 0, mainRatio / paddingRatio, 0)
	}
	local titleFrameChildren = {}
	local titleLabelProperties = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(1, 0, 1, 0),
		AnchorPoint = Vector2.new(1, 1),
		Text = self.props.title,
		Font = Enum.Font.Bangers,
		LineHeight = 0.95,
		TextScaled = true
	}
	titleLabelProperties.TextColor3 = self.state.hover and Color3.new(255/255, 0/255, 0/255) or Color3.new(255/255, 255/255, 255/255)
	titleLabelProperties.TextXAlignment = Enum.TextXAlignment.Right
	titleLabelProperties.TextYAlignment = Enum.TextYAlignment.Top
	titleFrameChildren.Title = createElement("TextLabel", titleLabelProperties)
	children.Title = createElement("Frame", titleFrameProperties, titleFrameChildren)
	children.Type = createElement("Frame", {
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
			Text = self.props.categoryTitle,
			Font = Enum.Font.Bangers,
			LineHeight = 0.95,
			TextScaled = true,
			TextColor3 = Color3.fromRGB(98, 222, 253),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Bottom
		})
	})
	local priceFrameProperties = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5 - hoverScale / mainRatio - 2 / paddingRatio, 0, 0.5 - mainRatio / paddingRatio, 0),
		Position = UDim2.new(0.45, 0, 0.5, 0)
	}
	local priceFrameChildren = {}
	local priceLabelProperties = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.8, 0),
		Position = UDim2.new(0, 0, 1, 0),
		AnchorPoint = Vector2.new(0, 1)
	}
	priceLabelProperties.Text = if self.props.owned then "OWNED" else self.props.price and "-$" .. String.comma(self.props.price) or "FREE"
	priceLabelProperties.Font = Enum.Font.Bangers
	priceLabelProperties.LineHeight = 0.95
	priceLabelProperties.TextScaled = true
	priceLabelProperties.TextColor3 = self.props.owned and Color3.fromRGB(134, 195, 81) or Color3.new(255/255, 0/255, 0/255)
	priceLabelProperties.TextXAlignment = Enum.TextXAlignment.Right
	priceLabelProperties.TextYAlignment = Enum.TextYAlignment.Top
	priceFrameChildren.Title = createElement("TextLabel", priceLabelProperties)
	children.Price = createElement("Frame", priceFrameProperties, priceFrameChildren)
	return createElement("TextButton", buttonProperties, children)
end
return ReceiptItem
