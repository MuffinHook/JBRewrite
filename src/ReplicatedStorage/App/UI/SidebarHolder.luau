local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local BigButton = require(script.Parent.BigButton)
local BigButtonService = require(ReplicatedStorage.App.BigButtonService)
local SidebarHolder = Roact.PureComponent:extend("SidebarHolder")
function SidebarHolder.init(self)
	self:setState({
		counter = 0
	})
	self._maid = Maid.new()
end
function SidebarHolder.didMount(self)
	self._maid:GiveTask(BigButtonService.triggerUpdate:Connect(function()
		self:_fetchState()
	end))
end
function SidebarHolder._fetchState(self)
	self:setState({
		counter = self.state.counter + 1
	})
end
function SidebarHolder.render(self)
	local elements = {}
	for i, button in ipairs(self.props.buttons) do
		local buttonElement = createElement(BigButton, {
			imageId = button.imageId,
			imageScale = button.imageScale,
			count = button.count,
			onClick = button.onClick,
			enabled = button.enabled,
			ref = button.ref,
			displayOrder = button.displayOrder or i,
			color = self.props.color,
			size = UDim2.new(0.9, 0, 0.9, 0)
		})
		elements[button.name] = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Visible = button.enabled,
			LayoutOrder = button.displayOrder or i
		}, {
			[button.name] = buttonElement
		})
	end
	return createElement("Frame", {
		Visible = self.props.enabled,
		BackgroundTransparency = 1,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint,
		LayoutOrder = self.props.displayOrder
	}, Dictionary.merge({
		GridLayout = createElement("UIGridLayout", {
			CellSize = UDim2.new(0.5, 0, 1, 0),
			CellPadding = UDim2.new(0, 0, 0, 0),
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			VerticalAlignment = Enum.VerticalAlignment.Bottom,
			StartCorner = Enum.StartCorner.BottomRight,
			SortOrder = Enum.SortOrder.LayoutOrder
		}),
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 2
		})
	}, elements))
end
function SidebarHolder.willUnmount(self)
	self._maid:DoCleaning()
end
return SidebarHolder
