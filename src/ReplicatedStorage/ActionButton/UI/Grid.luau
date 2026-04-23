-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local makeButton = require(script.Parent.makeButton)
local v1 = Roact.PureComponent:extend("Grid")
v1.defaultProps = {
	color = Color3.new(255/255, 0/255, 0/255)
}
function v1._makeButton(p1, p2, p3, p4)
	local v1 = UDim2.new(0.9, 0, 0.9, 0)
	local v2 = UDim2.new(0.5, 0, 0.5, 0)
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 1, 1),
		LayoutOrder = p4
	}, {
		Button = makeButton(p1.props, p2, p3, 1, v1, v2)
	})
end
function v1.render(p1)
	local t = {}
	for i = 1, p1.props.countInner do
		t[("%s_%d"):format("inner", i)] = p1:_makeButton("inner", i, i)
	end
	for j = 1, p1.props.countOuter do
		t[("%s_%d"):format("outer", j)] = p1:_makeButton("outer", j, j + p1.props.countInner)
	end
	return createElement("Frame", {
		Visible = p1.props.enabled,
		BackgroundTransparency = 1,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
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
return v1