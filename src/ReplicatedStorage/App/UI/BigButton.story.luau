-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local BigButton = require(script.Parent.BigButton)
	function v1.init(p1)end
	function v1.render(p1)
		return Roact.createElement(BigButton, {
			count = 3,
			imageId = 4912231216
		})
	end
	function v1.willUnmount(p1)end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end