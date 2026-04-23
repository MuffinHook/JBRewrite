local v1 = script:FindFirstAncestor("EzUi")
local Dictionary = require(v1.Dictionary)
local Roact = require(v1.Parent.Roact)
local createElement = Roact.createElement
local v2 = Roact.PureComponent:extend("PaddedContainer")
v2.defaultProps = {
	backgroundTransparency = 0,
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	anchorPoint = Vector2.new(0, 0),
	paddingLeft = 1,
	paddingRight = 1,
	paddingTop = 1,
	paddingBottom = 1,
	zIndex = nil
}
local v3 = math.random()
function v2.render(p1) --[[ Line: 21 | Upvalues: v3 (ref), Roact (copy), v2 (copy), createElement (copy), Dictionary (copy) ]]
	local backgroundColor = p1.props.backgroundColor
	if not backgroundColor and p1.props.backgroundTransparency < 1 then
		v3 = v3 + 0.07725424859373685
		v3 = v3 % 1
		backgroundColor = Color3.fromHSV(v3, 0.8, 0.8)
	end
	local verticalPaddingRatio = p1.props.verticalPaddingRatio
	local v22 = verticalPaddingRatio * p1.props.aspectRatio
	local paddingLeft = p1.props.paddingLeft
	local paddingRight = p1.props.paddingRight
	local paddingTop = p1.props.paddingTop
	local paddingBottom = p1.props.paddingBottom
	if p1.props.paddingNone then
		paddingLeft = 0
		paddingRight = 0
		paddingTop = 0
		paddingBottom = 0
	end
	local v32 = p1.props.size.X.Scale - paddingLeft / v22 - paddingRight / v22
	if v32 < 0 then
		warn("PaddedContainer: innerScaleX < 0: " .. tostring(v32))
	end
	local v4 = p1.props.size.Y.Scale - paddingTop / verticalPaddingRatio - paddingBottom / verticalPaddingRatio
	if v4 < 0 then
		warn("PaddedContainer: innerScaleY < 0: " .. tostring(v4))
	end
	local v5 = v32 / v4
	local function v6(p1, p2, p3) --[[ Line: 54 | Upvalues: Roact (ref), v2 (ref), v5 (copy), v4 (copy), v6 (copy) ]]
		local v1 = p1.props[Roact.Children]
		if v1 then
			if p1.props.Size and typeof(p1.props.Size) == "UDim2" then
				p2 = p2 * (p1.props.Size.X.Scale / p1.props.Size.Y.Scale)
				p3 = p3 * p1.props.Size.Y.Scale
			end
			for v22, v3 in v1 do
				if typeof(v3) == "table" and v3.props then
					if v3.component == v2 or (v3.props.exposePaddedContainerProps or v3.props.injectPaddedContainerProps) then
						v3.props.aspectRatio = p2 * v5
						v3.props.verticalPaddingRatio = p3 * v4
					end
					if v3.props[Roact.Children] then
						v6(v3, p2, p3)
					end
				end
			end
		end
	end
	v6(p1, p1.props.aspectRatio, verticalPaddingRatio)
	local v7 = UDim2.new(v32, 0, v4, 0)
	local v8 = p1.props.position + UDim2.new(paddingLeft / v22, 0, paddingTop / verticalPaddingRatio, 0)
	if p1.props.component then
		return createElement(p1.props.component, Dictionary.merge(p1.props.props, {
			size = v7,
			position = v8,
			aspectRatio = v5,
			[Roact.Children] = p1.props[Roact.Children],
			[Roact.Ref] = p1.props[Roact.Ref]
		}))
	else
		return createElement("Frame", {
			BackgroundTransparency = p1.props.backgroundTransparency,
			BackgroundColor3 = backgroundColor,
			BorderSizePixel = 0,
			ZIndex = p1.props.zIndex,
			Size = v7,
			Position = v8,
			AnchorPoint = p1.props.anchorPoint,
			Visible = p1.props.visible,
			[Roact.Children] = p1.props[Roact.Children],
			[Roact.Ref] = p1.props[Roact.Ref]
		})
	end
end
return v2