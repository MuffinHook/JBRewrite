local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Minimap = require(script.Parent.Minimap)
return RoactRodux.connect(function(state, dispatch)
	return {
		points = state.minimapPoints,
		circles = state.minimapCircles
	}
end)(Minimap)