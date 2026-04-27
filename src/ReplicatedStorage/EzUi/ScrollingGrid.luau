local ezUiModule = script:FindFirstAncestor("EzUi")
local Roact = require(ezUiModule.Parent.Roact)
local Dictionary = require(ezUiModule.Dictionary)
local Grid = require(ezUiModule.Grid)
local createElement = Roact.createElement
local ScrollingGridComponent = Roact.PureComponent:extend("ScrollingGrid")
ScrollingGridComponent.defaultProps = {
	rowsPerPage = 3,
	colsPerRow = 9
}
function ScrollingGridComponent.init(self)  end
function ScrollingGridComponent.render(self)
	local aspectRatio = self.props.aspectRatio
	if self.props.paddingRatio then
		assert(aspectRatio, "aspectRatio is required when using paddingRatio.")
		assert(self.props.verticalPaddingRatio == nil, "cannot use paddingRatio & verticalPaddingRatio simultaneously.")
		self.props.verticalPaddingRatio = self.props.paddingRatio / aspectRatio
		self.props.paddingRatio = nil
	end
	local colsPerRow = self.props.colsPerRow
	local rowsPerPage = self.props.rowsPerPage
	if self.props.itemAspectRatio then
		self.props.rowsPerPage = colsPerRow / aspectRatio * self.props.itemAspectRatio
	end
	local totalPages = (math.floor((#self.props.items - 1) / self.props.colsPerRow) + 1) / self.props.rowsPerPage
	local canvasHeight = math.max(1, totalPages - aspectRatio / (self.props.verticalPaddingRatio * aspectRatio) * (totalPages - 1))
	return createElement("ScrollingFrame", {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Color3.new(255/255, 255/255, 255/255),
		CanvasSize = UDim2.new(0, 0, canvasHeight - 0.0001, 0),
		Size = UDim2.new(1, 0, 1, 0),
		ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Selectable = false
	}, createElement(Grid, Dictionary.merge({
		canvasHeight = canvasHeight
	}, self.props)))
end
return ScrollingGridComponent
