local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
return function(props)
	local aspectRatio = props.aspectRatio
	local width = props.width
	local positionsBinding = Roact.joinBindings({
		pos0 = props.pos0Binding,
		pos1 = props.pos1Binding
	})
	local frameProps = {
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	frameProps.BackgroundColor3 = props.lineColor or Color3.new(255/255, 255/255, 255/255)
	frameProps.BorderSizePixel = 0
	frameProps.Size = positionsBinding:map(function(positions)
		local xDifference = positions.pos1.X - positions.pos0.X
		local yDifference = positions.pos1.Y - positions.pos0.Y
		return UDim2.new(math.sqrt(yDifference * yDifference / aspectRatio / aspectRatio + xDifference * xDifference), 0, 0, width)
	end)
	frameProps.Rotation = positionsBinding:map(function(positions)
		return math.deg(-math.atan2((positions.pos1.Y - positions.pos0.Y) / aspectRatio, positions.pos1.X - positions.pos0.X))
	end)
	frameProps.Position = positionsBinding:map(function(positions)
		return UDim2.fromScale((positions.pos0.X + positions.pos1.X) * 0.5, 1 - (positions.pos0.Y + positions.pos1.Y) * 0.5)
	end)
	return createElement("Frame", frameProps)
end
