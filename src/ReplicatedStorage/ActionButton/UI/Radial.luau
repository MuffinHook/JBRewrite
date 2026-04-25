-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local makeButton = require(script.Parent.makeButton)
local function calculateRadial(p1, p2)
	local count = p1.count
	local centerAngle = p1.centerAngle or -2.356194490192345
	local angleDelta = p1.angleBetween or 0.59839860068377
	local maxRings = math.floor((p1.maxSweepAngle or math.pi) / angleDelta)
	local ringCount = math.ceil(p2 / maxRings)
	if maxRings < count then
		count = math.min(maxRings, maxRings - (ringCount * maxRings - count))
	end
	local positionInRing = (p2 - 1) % maxRings + 1
	local heavy = p1.heavy
	local evenCount = if count % 2 == 0 then count + 1 else count
	local oddCount = if count % 2 == 0 then count - 1 else count
	local startAngle = centerAngle - angleDelta * (if p1.center and count then count elseif heavy and evenCount then evenCount else oddCount - 1) * 0.5
	local depthOffset = (heavy and evenCount - 1 or oddCount) - 2 * (positionInRing - 1)
	if depthOffset < 1 then
		depthOffset = -depthOffset + 1
	end
	return startAngle + angleDelta * (positionInRing - 1), depthOffset + (ringCount - 1) * maxRings, ringCount, centerAngle
end
local Radial = Roact.PureComponent:extend("Radial")
Radial.defaultProps = {
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
function Radial._makeButton(p1, p2, p3, p4, p5, p6, p7)
	local size = UDim2.new(p7 * 2, 0, p7 * 2, 0)
	return makeButton(p1.props, p2, p3, 100 - p3 + 500 * p4, size, (UDim2.new(0.5 + p5, 0, 0.5 + p6, 0)))
end
function Radial.render(p1)
	local buttonRadiusOuter = p1.props.buttonRadiusOuter
	local radiusOuter = p1.props.radiusOuter
	local outerConfig = {
		count = p1.props.countOuter,
		maxSweepAngle = p1.props.maxSweepAngleOuter,
		angleBetween = p1.props.angleBetweenOuter,
		heavy = true,
		center = false
	}
	local radiusInner = p1.props.radiusInner
	local buttonRadiusInner = p1.props.buttonRadiusInner
	local innerConfig = {
		count = p1.props.countInner,
		angleBetween = p1.props.angleBetweenInner,
		heavy = true,
		center = true
	}
	local outerButtons = {}
	for i = 1, outerConfig.count do
		local angle, count, rings = calculateRadial(outerConfig, i)
		local adjustedAngle = angle + outerConfig.angleBetween * ((rings - 1) % 2) * 0.5
		local baseDist = 2 * radiusOuter * math.sin(outerConfig.angleBetween / 2) * 0.5 - buttonRadiusOuter
		local radiusSum, buttonRadius = radiusOuter, buttonRadiusOuter
		for j = 1, rings - 1 do
			local distance = 2 * radiusSum * math.sin(outerConfig.angleBetween / 2)
			local cosOffset = radiusSum * (1 - math.cos(outerConfig.angleBetween / 2))
			radiusSum = radiusSum + (math.sqrt((2 * buttonRadius + 2 * baseDist) ^ 2 - (distance / 2) ^ 2) - cosOffset)
		end
		local posX = radiusSum * math.cos(adjustedAngle)
		local posY = radiusSum * math.sin(adjustedAngle)
		if count == 1 then
			buttonRadius = buttonRadius * 1.2
		end
		outerButtons[count] = p1:_makeButton("outer", count, rings, posX, posY, buttonRadius)
	end
	local innerButtons = {}
	for k = 1, innerConfig.count do
		local buttonRadiusFinal
		local innerAngle, innerCount, innerRings, baseCenterAngle = calculateRadial(innerConfig, k)
		local xOffset = radiusInner * math.cos(innerAngle) - radiusInner * math.cos(baseCenterAngle)
		buttonRadiusFinal = if innerCount == 1 then buttonRadiusInner * 1.2 else buttonRadiusInner
		innerButtons[innerCount] = p1:_makeButton("inner", innerCount, innerRings, xOffset, radiusInner * math.sin(innerAngle) - radiusInner * math.sin(baseCenterAngle), buttonRadiusFinal)
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
		}, innerButtons)
	}, outerButtons))
end
return Radial
