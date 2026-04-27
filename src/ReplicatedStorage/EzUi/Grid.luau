local rootModule = script:FindFirstAncestor("EzUi")
local Dictionary = require(rootModule.Dictionary)
local Roact = require(rootModule.Parent.Roact)
local createElement = Roact.createElement
local GridUtils = require(script.Parent.GridUtils)
local GridComponent = Roact.PureComponent:extend("Grid")
GridComponent.defaultProps = {
	rowsPerPage = 3,
	colsPerRow = 9,
	itemAspectRatio = nil,
	canvasHeight = 1,
	infHorizontal = false,
	reverseY = false
}
function GridComponent.init(component)  end
function GridComponent.render(component)
	local aspectRatio = component.props.aspectRatio
	if component.props.paddingRatio then
		assert(aspectRatio, "aspectRatio is required when using paddingRatio.")
		assert(component.props.verticalPaddingRatio == nil, "cannot use paddingRatio & verticalPaddingRatio simultaneously.")
		component.props.verticalPaddingRatio = component.props.paddingRatio / aspectRatio
		component.props.paddingRatio = nil
	end
	local horizontalPaddingRatio = component.props.verticalPaddingRatio * aspectRatio
	local colsPerRow = component.props.colsPerRow
	local rowsPerPage = component.props.rowsPerPage
	if component.props.itemAspectRatio then
		rowsPerPage = colsPerRow / aspectRatio * component.props.itemAspectRatio
		component.props.rowsPerPage = rowsPerPage
	end
	local rowRatio = GridUtils.getRowRatio(component.props)
	local colRatio = GridUtils.getColRatio(component.props, rowRatio)
	local itemDefaults = component.props.itemDefaults or {}
	local canvasHeight = component.props.canvasHeight
	local itemElements = {}
	for i = 1, #component.props.items do
		local rowNum, colNum
		if component.props.infHorizontal then
			rowNum = 1
			colNum = i
		else
			rowNum = math.floor((i - 1) / colsPerRow) + 1
			colNum = (i - 1) % colsPerRow + 1
		end
		if component.props.reverseY then
			rowNum = rowsPerPage - rowNum + 1
		end
		local itemSize = UDim2.new(colRatio / rowRatio, 0, aspectRatio * 1 / rowRatio / canvasHeight, 0)
		local itemPosition = UDim2.new(colRatio / rowRatio * (colNum - 1) + 1 / horizontalPaddingRatio * colNum, 0, aspectRatio / canvasHeight * ((rowNum - 1) * 1 / rowRatio + rowNum * 1 / horizontalPaddingRatio), 0)
		local itemData = Dictionary.merge(component.props.items and component.props.items[i] or {}, component.props.metadata and component.props.metadata[i] or {}, itemDefaults)
		local itemId = itemData.id or itemData.name or #itemElements + 1
		local itemElement = createElement(component.props.component, Dictionary.merge({
			size = itemSize,
			position = itemPosition,
			aspectRatio = colRatio,
			cornerPixel = 4,
			paddingRatio = rowRatio / horizontalPaddingRatio,
			verticalPaddingRatio = horizontalPaddingRatio / rowRatio,
			parentAspectRatio = aspectRatio,
			parentVerticalPaddingRatio = horizontalPaddingRatio / aspectRatio,
			layoutOrder = 2 * colNum,
			index = i,
			rowIndex = rowNum,
			colIndex = colNum
		}, itemData))
		if itemElements[itemId] then
			warn("An item already exists in grid by key: " .. itemId)
		end
		itemElements[itemId] = itemElement
	end
	return Roact.createFragment(itemElements)
end
return GridComponent
