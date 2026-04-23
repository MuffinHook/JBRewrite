-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local makeButton = require(script.Parent.makeButton)
local function calculateRadial(p1, p2)
	local count = p1.count
	local v2 = p1.centerAngle or -2.356194490192345
	local v3 = p1.angleBetween or 0.59839860068377
	local v4 = math.floor((p1.maxSweepAngle or math.pi) / v3)
	local v5 = math.ceil(p2 / v4)
	if v4 < count then
		count = math.min(v4, v4 - (v5 * v4 - count))
	end
	local v7 = (p2 - 1) % v4 + 1
	local heavy = p1.heavy
	local v8 = if count % 2 == 0 then count + 1 else count
	local v9 = if count % 2 == 0 then count - 1 else count
	local v11 = v2 - v3 * (if p1.center and count then count elseif heavy and v8 then v8 else v9 - 1) * 0.5
	local v13 = (heavy and v8 - 1 or v9) - 2 * (v7 - 1)
	if v13 < 1 then
		v13 = -v13 + 1
	end
	return v11 + v3 * (v7 - 1), v13 + (v5 - 1) * v4, v5, v2
end
local v1 = Roact.PureComponent:extend("Radial")
v1.defaultProps = {
	enabled = true,
	size = UDim2.new(1, 0, 1, 0),
	countOuter = 5,
	buttonRadiusOuter = 0.1,
	radiusOuter = 0.4,
	angleBetweenOuter = 0.59839860068377,
	maxSweepAngleOuter = 4.1887902047863905,
	countInner = 2,
	buttonRadiusInner = 0.12,
	radiusInner = 0.58,
	angleBetweenInner = 0.48
}
function v1._makeButton(p1, p2, p3, p4, p5, p6, p7)
	local v1 = UDim2.new(p7 * 2, 0, p7 * 2, 0)
	return makeButton(p1.props, p2, p3, 100 - p3 + 500 * p4, v1, (UDim2.new(0.5 + p5, 0, 0.5 + p6, 0)))
end
function v1.render(p1)
	local buttonRadiusOuter = p1.props.buttonRadiusOuter
	local radiusOuter = p1.props.radiusOuter
	local t = {
		count = p1.props.countOuter,
		maxSweepAngle = p1.props.maxSweepAngleOuter,
		angleBetween = p1.props.angleBetweenOuter,
		heavy = true,
		center = false
	}
	local radiusInner = p1.props.radiusInner
	local buttonRadiusInner = p1.props.buttonRadiusInner
	local t2 = {
		count = p1.props.countInner,
		angleBetween = p1.props.angleBetweenInner,
		heavy = true,
		center = true
	}
	local t3 = {}
	for i = 1, t.count do
		local v1, v2, v3 = calculateRadial(t, i)
		local v4 = v1 + t.angleBetween * ((v3 - 1) % 2) * 0.5
		local v6 = 2 * radiusOuter * math.sin(t.angleBetween / 2) * 0.5 - buttonRadiusOuter
		local sum, v7 = radiusOuter, buttonRadiusOuter
		for j = 1, v3 - 1 do
			local v9 = 2 * sum * math.sin(t.angleBetween / 2)
			local v11 = sum * (1 - math.cos(t.angleBetween / 2))
			sum = sum + (math.sqrt((2 * v7 + 2 * v6) ^ 2 - (v9 / 2) ^ 2) - v11)
		end
		local v12 = sum * math.cos(v4)
		local v13 = sum * math.sin(v4)
		if v2 == 1 then
			v7 = v7 * 1.2
		end
		t3[v2] = p1:_makeButton("outer", v2, v3, v12, v13, v7)
	end
	local t4 = {}
	for k = 1, t2.count do
		local v14
		local v15, v16, v17, v18 = calculateRadial(t2, k)
		local v19 = radiusInner * math.cos(v15) - radiusInner * math.cos(v18)
		v14 = if v16 == 1 then buttonRadiusInner * 1.2 else buttonRadiusInner
		t4[v16] = p1:_makeButton("inner", v16, v17, v19, radiusInner * math.sin(v15) - radiusInner * math.sin(v18), v14)
	end
	return createElement("Frame", {
		Visible = p1.props.enabled,
		BackgroundTransparency = 1,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
	}, Dictionary.merge({
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		}),
		Center = createElement("Frame", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		}, t4)
	}, t3))
end
return v1