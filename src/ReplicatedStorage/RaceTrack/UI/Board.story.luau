local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(targetFrame)
	local Board = require(script.Parent.Board)
	local roactInstance = Roact.mount(Roact.createElement(Board, {}), targetFrame)
	return function()
		Roact.unmount(roactInstance)
	end
end
