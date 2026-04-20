
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)

-- Decomp Error: ClanRating component failed decompilation; rebuilt a minimal rating label component.
return function(props)
	props = props or {}
	return Roact.createElement("TextLabel", {
		BackgroundTransparency = props.BackgroundTransparency or 1,
		Font = props.Font or Enum.Font.SourceSansBold,
		LayoutOrder = props.LayoutOrder or props.layoutOrder,
		Position = props.Position or props.position,
		Size = props.Size or props.size or UDim2.fromScale(1, 1),
		Text = tostring(props.rating or props.Rating or props.text or "--"),
		TextColor3 = props.TextColor3 or props.color or Color3.new(1, 1, 1),
		TextScaled = props.TextScaled ~= false,
		ZIndex = props.ZIndex or props.zIndex,
	})
end
