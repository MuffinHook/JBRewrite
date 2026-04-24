-- Reviewed by Claude
local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local function testComponent(p1)
	return createElement("TextLabel", {
		BackgroundTransparency = 0.5,
		BackgroundColor3 = p1.color,
		Size = p1.size,
		Position = p1.position,
		Text = p1.title
	})
end
return function(p1)
	local ScrollingGrid = require(script.Parent.ScrollingGrid)
	local t = {}
	for i = 1, 31 do
		table.insert(t, {
			title = tostring(i),
			color = Color3.fromHSV(math.random(), 1, 1)
		})
	end
	local v1 = Roact.mount(createElement("Frame", {
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
			items = t
		})
	}), p1)
	return function()
		Roact.unmount(v1)
	end
end
