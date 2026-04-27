local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(storyParent)
	local sliderValue, updateSliderValue = Roact.createBinding(0)
	local Slider = require(script.Parent.Slider)
	local mountedComponent = Roact.mount(Roact.createElement(Slider, {
		size = UDim2.new(0.5, 0, 0, 30),
		position = UDim2.new(0.25, 0, 0.5, 0),
		min = 0,
		max = 50,
		step = 1,
		value = sliderValue,
		updateValue = updateSliderValue,
		text = sliderValue:map(function(currentValue)
			return ("%d"):format((1 - currentValue) * 0 + currentValue * 50)
		end)
	}), storyParent)
	return function()
		Roact.unmount(mountedComponent)
	end
end
