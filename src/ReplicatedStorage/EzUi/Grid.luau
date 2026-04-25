-- Reviewed by Claude
-- variables reassigned
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
function GridComponent.init(p1)  end
function GridComponent.render(p1)
	local aspectRatio = p1.props.aspectRatio
	if p1.props.paddingRatio then
		assert(aspectRatio, "aspectRatio is required when using paddingRatio.")
		assert(p1.props.verticalPaddingRatio == nil, "cannot use paddingRatio & verticalPaddingRatio simultaneously.")
		p1.props.verticalPaddingRatio = p1.props.paddingRatio / aspectRatio
		p1.props.paddingRatio = nil
	end
	local horizontalPaddingRatio = p1.props.verticalPaddingRatio * aspectRatio
	local colsPerRow = p1.props.colsPerRow
	local rowsPerPage = p1.props.rowsPerPage
	if p1.props.itemAspectRatio then
		rowsPerPage = colsPerRow / aspectRatio * p1.props.itemAspectRatio
		p1.props.rowsPerPage = rowsPerPage
	end
	local rowRatio = GridUtils.getRowRatio(p1.props)
	local colRatio = GridUtils.getColRatio(p1.props, rowRatio)
	local itemDefaults = p1.props.itemDefaults or {}
	local canvasHeight = p1.props.canvasHeight
	local t = {}
	for i = 1, #p1.props.items do
		local rowNum, colNum
		if p1.props.infHorizontal then
			rowNum = 1
			colNum = i
		else
			rowNum = math.floor((i - 1) / colsPerRow) + 1
			colNum = (i - 1) % colsPerRow + 1
		end
		if p1.props.reverseY then
			rowNum = rowsPerPage - rowNum + 1
		end
		local itemSize = UDim2.new(colRatio / rowRatio, 0, aspectRatio * 1 / rowRatio / canvasHeight, 0)
		local itemPosition = UDim2.new(colRatio / rowRatio * (colNum - 1) + 1 / horizontalPaddingRatio * colNum, 0, aspectRatio / canvasHeight * ((rowNum - 1) * 1 / rowRatio + rowNum * 1 / horizontalPaddingRatio), 0)
		local itemData = Dictionary.merge(p1.props.items and p1.props.items[i] or {}, p1.props.metadata and p1.props.metadata[i] or {}, itemDefaults)
		local itemId = itemData.id or itemData.name or #t + 1
		local itemElement = createElement(p1.props.component, Dictionary.merge({
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
		if t[itemId] then
			warn("An item already exists in grid by key: " .. itemId)
		end
		t[itemId] = itemElement
	end
	return Roact.createFragment(t)
end
return GridComponent
