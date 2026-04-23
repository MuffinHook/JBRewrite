local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 4 | Upvalues: Roact (copy) ]]
	local v1 = Roact.Component:extend("App")
	local BigButton = require(script.Parent.BigButton)
	function v1.init(p1) --[[ Line: 7 ]] end
	function v1.render(p1) --[[ Line: 8 | Upvalues: Roact (ref), BigButton (copy) ]]
		return Roact.createElement(BigButton, {
			count = 3,
			imageId = 4912231216
		})
	end
	function v1.willUnmount(p1) --[[ Line: 14 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 17 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end