local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parent)
	local AppComponent = Roact.Component:extend("App")
	local TopbarHolder = require(script.Parent.TopbarHolder)
	function AppComponent.init(self)end
	function AppComponent.render(self)
		return Roact.createElement(TopbarHolder, {
			buttons = {
				{
					name = "TeamSwitch",
					imageId = 4912231691
				},
				{
					name = "Contracts",
					imageId = 6132976621,
					count = 3,
					onClick = function(button)
						print("clicked contracts", button)
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
		})
	end
	function AppComponent.willUnmount(self)end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), parent)
	return function()
		Roact.unmount(mountedComponent)
	end
end