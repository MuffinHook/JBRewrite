-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1)
	local Countdown = require(script.Parent.Countdown)
	local v1 = Roact.mount(createElement(Countdown, {
		endTime = workspace:GetServerTimeNow() + 1000
	}), p1)
	return function()
		Roact.unmount(v1)
	end
end
