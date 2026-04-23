local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy) ]]
	local v1, v2 = Roact.createBinding("hello, world!")
	local TextButton = require(script.Parent.TextButton)
	local v3 = Roact.mount(Roact.createElement(TextButton, {
		size = UDim2.new(0.5, 0, 0, 30),
		position = UDim2.new(0.25, 0, 0.5, 0),
		text = v1,
		onClick = function(p1, p2, p3) --[[ Name: onClick | Line: 14 | Upvalues: v2 (copy) ]]
			v2(("click %d"):format(p3))
		end
	}), p1)
	return function() --[[ Line: 20 | Upvalues: Roact (ref), v3 (copy) ]]
		Roact.unmount(v3)
	end
end