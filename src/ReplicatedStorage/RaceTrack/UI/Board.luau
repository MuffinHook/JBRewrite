-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local BoardEntry = require(script.Parent.BoardEntry)
local BoardComponent = Roact.PureComponent:extend("Board")
function BoardComponent.render(self)
	local boardEntries = {}
	for i, entry in ipairs(self.props.entries) do
		boardEntries[i] = createElement(BoardEntry, {
			rank = i,
			name = entry.name,
			userId = entry.userId,
			message = entry.message
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
	}, boardEntries))
end
return BoardComponent
