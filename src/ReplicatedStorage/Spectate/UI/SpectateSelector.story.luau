local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpectateSelector = require(script.Parent.SpectateSelector)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(parentContainer)
	local tbl = Roact.mount(createElement(SpectateSelector, {}), parentContainer)
	return function()
		Roact.unmount(tbl)
	end
end
