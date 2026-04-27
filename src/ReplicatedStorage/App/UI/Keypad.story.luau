local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(targetParent)
	local Keypad = require(script.Parent.Keypad)
	local mountedComponent = Roact.mount(Roact.createElement(Keypad, {
		size = UDim2.new(0.9, 0, 0.9, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		onSubmit = function(submittedValue)
			print(submittedValue, submittedValue == "0000")
		end
	}), targetParent)
	return function()
		Roact.unmount(mountedComponent)
	end
end
