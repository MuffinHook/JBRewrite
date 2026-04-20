
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)

-- Decomp Error: Original EzUi line component failed decompilation; rebuilt as a simple frame divider.
return function(props)
	props = props or {}
	return Roact.createElement("Frame", {
		BackgroundColor3 = props.color or props.BackgroundColor3 or Color3.new(1, 1, 1),
		BackgroundTransparency = props.transparency or props.BackgroundTransparency or 0,
		BorderSizePixel = 0,
		LayoutOrder = props.LayoutOrder or props.layoutOrder,
		Position = props.Position or props.position,
		Size = props.Size or props.size or UDim2.new(1, 0, 0, 1),
		ZIndex = props.ZIndex or props.zIndex,
	})
end
