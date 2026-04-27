local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local function testComponent(props)
	return createElement("TextLabel", {
		BackgroundTransparency = 0.5,
		BackgroundColor3 = props.color,
		Size = props.size,
		Position = props.position,
		Text = props.title
	})
end
return function(parent)
	local Grid = require(script.Parent.Grid)
	local componentInstance = Roact.mount(createElement("Frame", {
		BackgroundTransparency = 0.5,
		Size = UDim2.new(0.9, 0, 0.9, 0),
		Position = UDim2.new(0.05, 0, 0.05, 0)
	}, Roact.createElement(Grid, {
		aspectRatio = 1,
		paddingRatio = 100,
		rowsPerPage = 3,
		colsPerRow = 3,
		component = testComponent,
		items = {
			{
				color = Color3.new(255/255, 0/255, 0/255),
				title = "1"
			},
			{
				color = Color3.new(0/255, 255/255, 0/255),
				title = "2"
			},
			{
				color = Color3.new(0/255, 0/255, 255/255),
				title = "3"
			}
		}
	})), parent)
	return function()
		Roact.unmount(componentInstance)
	end
end
