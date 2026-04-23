local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProgressBar = require(script.Parent.ProgressBar)
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ProgressBar (copy) ]]
	local v1 = Roact.Component:extend("App")
	function v1.init(p1) --[[ Line: 7 ]] end
	function v1.render(p1) --[[ Line: 8 | Upvalues: Roact (ref), ProgressBar (ref) ]]
		return Roact.createElement(ProgressBar, {})
	end
	function v1.willUnmount(p1) --[[ Line: 11 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 14 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end