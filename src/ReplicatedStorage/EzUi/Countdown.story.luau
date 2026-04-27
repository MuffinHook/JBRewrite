local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(parent)
	local Countdown = require(script.Parent.Countdown)
	local mountedComponent = Roact.mount(createElement(Countdown, {
		endTime = workspace:GetServerTimeNow() + 1000
	}), parent)
	return function()
		Roact.unmount(mountedComponent)
	end
end
