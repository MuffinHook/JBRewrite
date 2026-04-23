local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), createElement (copy) ]]
	local v1 = Roact.Component:extend("App")
	local Tooltip = require(script.Parent.Tooltip)
	function v1.init(p1) --[[ Line: 8 ]]
		p1:setState({
			visible = true
		})
	end
	function v1.render(p1) --[[ Line: 13 | Upvalues: createElement (ref), Tooltip (copy) ]]
		return createElement(Tooltip, {
			text = "noice"
		})
	end
	function v1.willUnmount(p1) --[[ Line: 18 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 21 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end