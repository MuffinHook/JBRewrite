local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parent)
	local AppComponent = Roact.Component:extend("App")
	local SidebarHolder = require(script.Parent.SidebarHolder)
	function AppComponent.init(self)end
	function AppComponent.render(self)
		local buttonConfigs = {
			{
				name = "TeamSwitch",
				imageId = 4912231691
			},
			{
				name = "Contracts",
				imageId = 6132976621,
				count = 3,
				onClick = function(buttonInfo)
					print("clicked contracts", buttonInfo)
				end
			},
			{
				name = "Garage",
				imageId = 4912231022
			},
			{
				name = "Season",
				imageId = 6132976621
			}
		}
		return Roact.createElement(SidebarHolder, {
			buttons = buttonConfigs,
			size = UDim2.new(0.2, 0, 1, 0),
			anchorPoint = Vector2.new(0, 1),
			position = UDim2.new(0, 0, 0.5, 0)
		})
	end
	function AppComponent.willUnmount(self)end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), parent)
	return function()
		Roact.unmount(mountedComponent)
	end
end
