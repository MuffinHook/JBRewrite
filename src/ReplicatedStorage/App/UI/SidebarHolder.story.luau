local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 4 | Upvalues: Roact (copy) ]]
	local v1 = Roact.Component:extend("App")
	local SidebarHolder = require(script.Parent.SidebarHolder)
	function v1.init(p1) --[[ Line: 7 ]] end
	function v1.render(p1) --[[ Line: 8 | Upvalues: Roact (ref), SidebarHolder (copy) ]]
		local t = {
			{
				name = "TeamSwitch",
				imageId = 4912231691
			},
			{
				name = "Contracts",
				imageId = 6132976621,
				count = 3,
				onClick = function(p1) --[[ Name: onClick | Line: 18 ]]
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
		return Roact.createElement(SidebarHolder, {
			buttons = t,
			size = UDim2.new(0.2, 0, 1, 0),
			anchorPoint = Vector2.new(0, 1),
			position = UDim2.new(0, 0, 0.5, 0)
		})
	end
	function v1.willUnmount(p1) --[[ Line: 38 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 41 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end