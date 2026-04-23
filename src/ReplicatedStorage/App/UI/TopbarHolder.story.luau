-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local TopbarHolder = require(script.Parent.TopbarHolder)
	function v1.init(p1)end
	function v1.render(p1)
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
					onClick = function(p1)
						print("clicked contracts", p1)
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
	function v1.willUnmount(p1)end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end