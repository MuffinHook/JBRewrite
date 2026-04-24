-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpectateSelector = require(script.Parent.SpectateSelector)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1)
	local v1 = Roact.mount(createElement(SpectateSelector, {}), p1)
	return function()
		Roact.unmount(v1)
	end
end
