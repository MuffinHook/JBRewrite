local v1 = script:FindFirstAncestor("EzUi")
local Roact = require(v1.Parent.Roact)
local Dictionary = require(v1.Dictionary)
local Grid = require(v1.Grid)
local createElement = Roact.createElement
local v2 = Roact.PureComponent:extend("ScrollingGrid")
v2.defaultProps = {
	rowsPerPage = 3,
	colsPerRow = 9
}
function v2.init(p1) --[[ Line: 14 ]] end
function v2.render(p1) --[[ Line: 15 | Upvalues: createElement (copy), Grid (copy), Dictionary (copy) ]]
	local aspectRatio = p1.props.aspectRatio
	if p1.props.paddingRatio then
		assert(aspectRatio, "aspectRatio is required when using paddingRatio.")
		assert(p1.props.verticalPaddingRatio == nil, "cannot use paddingRatio & verticalPaddingRatio simultaneously.")
		p1.props.verticalPaddingRatio = p1.props.paddingRatio / aspectRatio
		p1.props.paddingRatio = nil
	end
	local colsPerRow = p1.props.colsPerRow
	local rowsPerPage = p1.props.rowsPerPage
	if p1.props.itemAspectRatio then
		p1.props.rowsPerPage = colsPerRow / aspectRatio * p1.props.itemAspectRatio
	end
	local v4 = (math.floor((#p1.props.items - 1) / p1.props.colsPerRow) + 1) / p1.props.rowsPerPage
	local v5 = math.max(1, v4 - aspectRatio / (p1.props.verticalPaddingRatio * aspectRatio) * (v4 - 1))
	return createElement("ScrollingFrame", {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Color3.new(255/255, 255/255, 255/255),
		CanvasSize = UDim2.new(0, 0, v5 - 0.0001, 0),
		Size = UDim2.new(1, 0, 1, 0),
		ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Selectable = false
	}, createElement(Grid, Dictionary.merge({
		canvasHeight = v5
	}, p1.props)))
end
return v2