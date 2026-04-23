local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1) --[[ Line: 6 | Upvalues: Roact (copy), createElement (copy) ]]
	local Countdown = require(script.Parent.Countdown)
	local v1 = Roact.mount(createElement(Countdown, {
		endTime = workspace:GetServerTimeNow() + 1000
	}), p1)
	return function() --[[ Line: 14 | Upvalues: Roact (ref), v1 (copy) ]]
		Roact.unmount(v1)
	end
end