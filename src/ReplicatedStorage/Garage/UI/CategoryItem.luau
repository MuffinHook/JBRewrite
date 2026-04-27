local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local CategoryItem = Roact.PureComponent:extend("CategoryItem")
function CategoryItem.init(self)
	self:setState({
		hover = false
	})
end
function CategoryItem.render(self)
	local mainRatio = self.props.mainRatio
	local paddingRatio = self.props.paddingRatio
	local buttonProperties = {}
	buttonProperties.BackgroundTransparency = if self.state.hover or self.props.selected then 0 else 1
	buttonProperties.AutoButtonColor = false
	buttonProperties.Text = ""
	buttonProperties.BackgroundColor3 = if self.props.selected then Color3.fromRGB(98, 222, 253) else Color3.new(51/255, 51/255, 51/255)
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
	buttonProperties[Roact.Event.Activated] = self.props.onSelect
	local buttonChildren = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = mainRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, self.props.cornerPixel)
		})
	}
	local titleLabelProperties = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1 - 0.6 / mainRatio, 0, 0.4, 0),
		Position = UDim2.new(1 - 0.3 / mainRatio, 0, 0.3, 0),
		AnchorPoint = Vector2.new(1, 0),
		Text = self.props.title,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true
	}
	titleLabelProperties.TextColor3 = self.props.selected and Color3.new(0/255, 0/255, 0/255) or Color3.new(255/255, 255/255, 255/255)
	titleLabelProperties.TextXAlignment = Enum.TextXAlignment.Right
	titleLabelProperties.TextYAlignment = Enum.TextYAlignment.Center
	buttonChildren.Title = createElement("TextLabel", titleLabelProperties)
	return createElement("TextButton", buttonProperties, buttonChildren)
end
return CategoryItem
