local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 4 | Upvalues: Roact (copy) ]]
	local v1 = Roact.Component:extend("App")
	local Bounty = require(script.Parent.Bounty)
	function v1.init(p1) --[[ Line: 7 ]] end
	function v1.render(p1) --[[ Line: 8 | Upvalues: Roact (ref), Bounty (copy) ]]
		return Roact.createElement(Bounty, {
			amount = 1000
		})
	end
	function v1.willUnmount(p1) --[[ Line: 13 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 16 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end