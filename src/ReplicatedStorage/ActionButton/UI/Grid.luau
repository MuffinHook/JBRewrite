-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local makeButton = require(script.Parent.makeButton)
local GridComponent = Roact.PureComponent:extend("Grid")
GridComponent.defaultProps = {
	color = Color3.new(255/255, 0/255, 0/255)
}
function GridComponent._makeButton(self, buttonGroup, buttonIndex, layoutOrder)
	local buttonSize = UDim2.new(0.9, 0, 0.9, 0)
	local buttonPosition = UDim2.new(0.5, 0, 0.5, 0)
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 1, 1),
		LayoutOrder = layoutOrder
	}, {
		Button = makeButton(self.props, buttonGroup, buttonIndex, 1, buttonSize, buttonPosition)
	})
end
function GridComponent.render(self)
	local buttons = {}
	for i = 1, self.props.countInner do
		buttons[("%s_%d"):format("inner", i)] = self:_makeButton("inner", i, i)
	end
	for j = 1, self.props.countOuter do
		buttons[("%s_%d"):format("outer", j)] = self:_makeButton("outer", j, j + self.props.countInner)
	end
	return createElement("Frame", {
		Visible = self.props.enabled,
		BackgroundTransparency = 1,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint
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
	}, buttons))
end
return GridComponent