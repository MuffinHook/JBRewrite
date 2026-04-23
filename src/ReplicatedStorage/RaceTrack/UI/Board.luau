local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local BoardEntry = require(script.Parent.BoardEntry)
local v1 = Roact.PureComponent:extend("Board")
function v1.render(p1) --[[ Line: 9 | Upvalues: createElement (copy), BoardEntry (copy), Dictionary (copy) ]]
	local t = {}
	for i, v in ipairs(p1.props.entries) do
		t[i] = createElement(BoardEntry, {
			rank = i,
			name = v.name,
			userId = v.userId,
			message = v.message
		})
	end
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0)
	}, Dictionary.merge({
		ListLayout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical
		})
	}, t))
end
return v1