-- Reviewed by Claude
-- variables reassigned
local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
return function(p1)
	local aspectRatio = p1.aspectRatio
	local width = p1.width
	local positionsBinding = Roact.joinBindings({
		pos0 = p1.pos0Binding,
		pos1 = p1.pos1Binding
	})
	local frameProps = {
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	frameProps.BackgroundColor3 = p1.lineColor or Color3.new(255/255, 255/255, 255/255)
	frameProps.BorderSizePixel = 0
	frameProps.Size = positionsBinding:map(function(p1)
		local xDifference = p1.pos1.X - p1.pos0.X
		local yDifference = p1.pos1.Y - p1.pos0.Y
		return UDim2.new(math.sqrt(yDifference * yDifference / aspectRatio / aspectRatio + xDifference * xDifference), 0, 0, width)
	end)
	frameProps.Rotation = positionsBinding:map(function(p1)
		return math.deg(-math.atan2((p1.pos1.Y - p1.pos0.Y) / aspectRatio, p1.pos1.X - p1.pos0.X))
	end)
	frameProps.Position = positionsBinding:map(function(p1)
		return UDim2.fromScale((p1.pos0.X + p1.pos1.X) * 0.5, 1 - (p1.pos0.Y + p1.pos1.Y) * 0.5)
	end)
	return createElement("Frame", frameProps)
end
