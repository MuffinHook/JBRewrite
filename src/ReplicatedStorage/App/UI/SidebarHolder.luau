-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local BigButton = require(script.Parent.BigButton)
local BigButtonService = require(ReplicatedStorage.App.BigButtonService)
local v1 = Roact.PureComponent:extend("SidebarHolder")
function v1.init(p1)
	p1:setState({
		counter = 0
	})
	p1._maid = Maid.new()
end
function v1.didMount(p1)
	p1._maid:GiveTask(BigButtonService.triggerUpdate:Connect(function()
		p1:_fetchState()
	end))
end
function v1._fetchState(p1)
	p1:setState({
		counter = p1.state.counter + 1
	})
end
function v1.render(p1)
	local t = {}
	for i, v in ipairs(p1.props.buttons) do
		local v1 = createElement(BigButton, {
			imageId = v.imageId,
			imageScale = v.imageScale,
			count = v.count,
			onClick = v.onClick,
			enabled = v.enabled,
			ref = v.ref,
			displayOrder = v.displayOrder or i,
			color = p1.props.color,
			size = UDim2.new(0.9, 0, 0.9, 0)
		})
		t[v.name] = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Visible = v.enabled,
			LayoutOrder = v.displayOrder or i
		}, {
			[v.name] = v1
		})
	end
	return createElement("Frame", {
		Visible = p1.props.enabled,
		BackgroundTransparency = 1,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint,
		LayoutOrder = p1.props.displayOrder
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
	}, t))
end
function v1.willUnmount(p1)
	p1._maid:DoCleaning()
end
return v1