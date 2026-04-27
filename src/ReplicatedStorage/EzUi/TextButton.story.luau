local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(parent)
	local textBinding, setTextBinding = Roact.createBinding("hello, world!")
	local TextButton = require(script.Parent.TextButton)
	local mountRef = Roact.mount(Roact.createElement(TextButton, {
		size = UDim2.new(0.5, 0, 0, 30),
		position = UDim2.new(0.25, 0, 0.5, 0),
		text = textBinding,
		onClick = function(button, userInputState, inputObject)
			setTextBinding(("click %d"):format(inputObject))
		end
	}), parent)
	return function()
		Roact.unmount(mountRef)
	end
end
