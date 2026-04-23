local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local BigButton = require(script.Parent.BigButton)
local BigButtonService = require(ReplicatedStorage.App.BigButtonService)
local v1 = Roact.PureComponent:extend("TopbarHolder")
function v1.init(p1) --[[ Line: 12 | Upvalues: Maid (copy) ]]
	p1:setState({
		counter = 0
	})
	p1._maid = Maid.new()
end
function v1.didMount(p1) --[[ Line: 18 | Upvalues: BigButtonService (copy) ]]
	p1._maid:GiveTask(BigButtonService.triggerUpdate:Connect(function() --[[ Line: 19 | Upvalues: p1 (copy) ]]
		p1:_fetchState()
	end))
end
function v1._fetchState(p1) --[[ Line: 23 ]]
	p1:setState({
		counter = p1.state.counter + 1
	})
end
function v1.render(p1) --[[ Line: 28 | Upvalues: createElement (copy), BigButton (copy), Dictionary (copy) ]]
	local t = {}
	for i, v in ipairs(p1.props.buttons) do
		t[v.name] = createElement(BigButton, {
			imageId = v.imageId,
			imageScale = v.imageScale,
			count = v.count,
			onClick = v.onClick,
			enabled = v.enabled,
			ref = v.ref,
			displayOrder = v.displayOrder or i,
			color = p1.props.color
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
		}, t))
	})
end
function v1.willUnmount(p1) --[[ Line: 94 ]]
	p1._maid:DoCleaning()
end
return v1