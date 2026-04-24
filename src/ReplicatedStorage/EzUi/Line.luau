-- Reviewed by Claude
local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
return function(p1)
	local aspectRatio = p1.aspectRatio
	local width = p1.width
	local v1 = Roact.joinBindings({
		pos0 = p1.pos0Binding,
		pos1 = p1.pos1Binding
	})
	local t = {
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	t.BackgroundColor3 = p1.lineColor or Color3.new(255/255, 255/255, 255/255)
	t.BorderSizePixel = 0
	t.Size = v1:map(function(p1)
		local v1 = p1.pos1.X - p1.pos0.X
		local v2 = p1.pos1.Y - p1.pos0.Y
		return UDim2.new(math.sqrt(v2 * v2 / aspectRatio / aspectRatio + v1 * v1), 0, 0, width)
	end)
	t.Rotation = v1:map(function(p1)
		return math.deg(-math.atan2((p1.pos1.Y - p1.pos0.Y) / aspectRatio, p1.pos1.X - p1.pos0.X))
	end)
	t.Position = v1:map(function(p1)
		return UDim2.fromScale((p1.pos0.X + p1.pos1.X) * 0.5, 1 - (p1.pos0.Y + p1.pos1.Y) * 0.5)
	end)
	return createElement("Frame", t)
end
