local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy) ]]
	local v1 = Roact.Component:extend("App")
	local Checkbox = require(script.Parent.Checkbox)
	function v1.init(p1) --[[ Line: 8 ]]
		p1:setState({
			checked = false
		})
	end
	function v1.render(p1) --[[ Line: 13 | Upvalues: Roact (ref), Checkbox (copy) ]]
		return Roact.createElement(Checkbox, {
			size = UDim2.new(0, 30, 0, 30),
			position = UDim2.new(0.25, 0, 0.5, 0),
			value = p1.state.checked,
			onChecked = function(p12) --[[ Name: onChecked | Line: 18 | Upvalues: p1 (copy) ]]
				p1:setState({
					checked = p12
				})
			end
		})
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 27 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end