local v1 = script:FindFirstAncestor("EzUi")
local Dictionary = require(v1.Dictionary)
local Roact = require(v1.Parent.Roact)
local createElement = Roact.createElement
local GridUtils = require(script.Parent.GridUtils)
local v2 = Roact.PureComponent:extend("Grid")
v2.defaultProps = {
	rowsPerPage = 3,
	colsPerRow = 9,
	itemAspectRatio = nil,
	canvasHeight = 1,
	infHorizontal = false,
	reverseY = false
}
function v2.init(p1) --[[ Line: 18 ]] end
function v2.render(p1) --[[ Line: 19 | Upvalues: GridUtils (copy), Dictionary (copy), createElement (copy), Roact (copy) ]]
	local aspectRatio = p1.props.aspectRatio
	if p1.props.paddingRatio then
		assert(aspectRatio, "aspectRatio is required when using paddingRatio.")
		assert(p1.props.verticalPaddingRatio == nil, "cannot use paddingRatio & verticalPaddingRatio simultaneously.")
		p1.props.verticalPaddingRatio = p1.props.paddingRatio / aspectRatio
		p1.props.paddingRatio = nil
	end
	local v1 = p1.props.verticalPaddingRatio * aspectRatio
	local colsPerRow = p1.props.colsPerRow
	local rowsPerPage = p1.props.rowsPerPage
	if p1.props.itemAspectRatio then
		rowsPerPage = colsPerRow / aspectRatio * p1.props.itemAspectRatio
		p1.props.rowsPerPage = rowsPerPage
	end
	local v2 = GridUtils.getRowRatio(p1.props)
	local v3 = GridUtils.getColRatio(p1.props, v2)
	local v4 = p1.props.itemDefaults or {}
	local canvasHeight = p1.props.canvasHeight
	local t = {}
	for i = 1, #p1.props.items do
		local v6, v7
		if p1.props.infHorizontal then
			v6 = 1
			v7 = i
		else
			v6 = math.floor((i - 1) / colsPerRow) + 1
			v7 = (i - 1) % colsPerRow + 1
		end
		if p1.props.reverseY then
			v6 = rowsPerPage - v6 + 1
		end
		local v8 = UDim2.new(v3 / v2, 0, aspectRatio * 1 / v2 / canvasHeight, 0)
		local v9 = UDim2.new(v3 / v2 * (v7 - 1) + 1 / v1 * v7, 0, aspectRatio / canvasHeight * ((v6 - 1) * 1 / v2 + v6 * 1 / v1), 0)
		local v12 = Dictionary.merge(p1.props.items and p1.props.items[i] or {}, p1.props.metadata and p1.props.metadata[i] or {}, v4)
		local v13 = v12.id or v12.name or #t + 1
		local v14 = createElement(p1.props.component, Dictionary.merge({
			size = v8,
			position = v9,
			aspectRatio = v3,
			cornerPixel = 4,
			paddingRatio = v2 / v1,
			verticalPaddingRatio = v1 / v2,
			parentAspectRatio = aspectRatio,
			parentVerticalPaddingRatio = v1 / aspectRatio,
			layoutOrder = 2 * v7,
			index = i,
			rowIndex = v6,
			colIndex = v7
		}, v12))
		if t[v13] then
			warn("An item already exists in grid by key: " .. v13)
		end
		t[v13] = v14
	end
	return Roact.createFragment(t)
end
return v2