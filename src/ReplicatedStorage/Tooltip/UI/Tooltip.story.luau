-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1)
	local v1 = Roact.Component:extend("App")
	local Tooltip = require(script.Parent.Tooltip)
	function v1.init(p1)
		p1:setState({
			visible = true
		})
	end
	function v1.render(p1)
		return createElement(Tooltip, {
			text = "noice"
		})
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
