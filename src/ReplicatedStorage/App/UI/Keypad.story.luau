local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 4 | Upvalues: Roact (copy) ]]
	local Keypad = require(script.Parent.Keypad)
	local v1 = Roact.mount(Roact.createElement(Keypad, {
		size = UDim2.new(0.9, 0, 0.9, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		onSubmit = function(p1) --[[ Name: onSubmit | Line: 10 ]]
			print(p1, p1 == "0000")
		end
	}), p1)
	return function() --[[ Line: 16 | Upvalues: Roact (ref), v1 (copy) ]]
		Roact.unmount(v1)
	end
end