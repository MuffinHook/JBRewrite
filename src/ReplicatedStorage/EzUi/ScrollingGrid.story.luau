-- Reviewed by Claude
-- variables reassigned
local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local function testComponent(parent)
	return createElement("TextLabel", {
		BackgroundTransparency = 0.5,
		BackgroundColor3 = parent.color,
		Size = parent.size,
		Position = parent.position,
		Text = parent.title
	})
end
return function(parent)
	local ScrollingGrid = require(script.Parent.ScrollingGrid)
	local items = {}
	for i = 1, 31 do
		table.insert(items, {
			title = tostring(i),
			color = Color3.fromHSV(math.random(), 1, 1)
		})
	end
	local roactInstance = Roact.mount(createElement("Frame", {
		BackgroundTransparency = 0.5,
		Size = UDim2.new(0.9, 0, 0.9, 0),
		Position = UDim2.new(0.05, 0, 0.05, 0)
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.5
		}),
		Grid = Roact.createElement(ScrollingGrid, {
			aspectRatio = 1.5,
			paddingRatio = 128,
			rowsPerPage = 3,
			colsPerRow = 3,
			component = testComponent,
			items = items
		})
	}), parent)
	return function()
		Roact.unmount(roactInstance)
	end
end
