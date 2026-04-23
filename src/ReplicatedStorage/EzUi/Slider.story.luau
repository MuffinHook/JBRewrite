local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy) ]]
	local v1, v2 = Roact.createBinding(0)
	local Slider = require(script.Parent.Slider)
	local v3 = Roact.mount(Roact.createElement(Slider, {
		size = UDim2.new(0.5, 0, 0, 30),
		position = UDim2.new(0.25, 0, 0.5, 0),
		min = 0,
		max = 50,
		step = 1,
		value = v1,
		updateValue = v2,
		text = v1:map(function(p1) --[[ Line: 20 ]]
			return ("%d"):format((1 - p1) * 0 + p1 * 50)
		end)
	}), p1)
	return function() --[[ Line: 26 | Upvalues: Roact (ref), v3 (copy) ]]
		Roact.unmount(v3)
	end
end