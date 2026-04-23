local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpectateSelector = require(script.Parent.SpectateSelector)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1) --[[ Line: 6 | Upvalues: Roact (copy), createElement (copy), SpectateSelector (copy) ]]
	local v1 = Roact.mount(createElement(SpectateSelector, {}), p1)
	return function() --[[ Line: 8 | Upvalues: Roact (ref), v1 (copy) ]]
		Roact.unmount(v1)
	end
end