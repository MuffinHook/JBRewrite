local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 4 | Upvalues: Roact (copy) ]]
	local Board = require(script.Parent.Board)
	local v1 = Roact.mount(Roact.createElement(Board, {}), p1)
	return function() --[[ Line: 7 | Upvalues: Roact (ref), v1 (copy) ]]
		Roact.unmount(v1)
	end
end