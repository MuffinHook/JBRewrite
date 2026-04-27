local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local BigButton = require(script.Parent.BigButton)
local BigButtonService = require(ReplicatedStorage.App.BigButtonService)
local TopbarHolder = Roact.PureComponent:extend("TopbarHolder")
function TopbarHolder.init(component)
	component:setState({
		counter = 0
	})
	component._maid = Maid.new()
end
function TopbarHolder.didMount(component)
	component._maid:GiveTask(BigButtonService.triggerUpdate:Connect(function()
		component:_fetchState()
	end))
end
function TopbarHolder._fetchState(component)
	component:setState({
		counter = component.state.counter + 1
	})
end
function TopbarHolder.render(component)
	local buttonElements = {}
	for i, button in ipairs(component.props.buttons) do
		buttonElements[button.name] = createElement(BigButton, {
			imageId = button.imageId,
			imageScale = button.imageScale,
			count = button.count,
			onClick = button.onClick,
			enabled = button.enabled,
			ref = button.ref,
			displayOrder = button.displayOrder or i,
			color = component.props.color
		})
	end
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.7, 0),
		Position = UDim2.fromScale(0, 0.5),
		AnchorPoint = Vector2.new(0, 0.5)
	}, {
		Padding = createElement("UIPadding", {
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
			PaddingTop = UDim.new(0, 4)
		}),
		Left = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}, Dictionary.merge({
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 4)
			})
		}, {})),
		Right = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}, Dictionary.merge({
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 8)
			})
		}, buttonElements))
	})
end
function TopbarHolder.willUnmount(component)
	component._maid:DoCleaning()
end
return TopbarHolder
