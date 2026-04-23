local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Minimap = require(script.Parent.Minimap)
return RoactRodux.connect(function(p1, p2) --[[ Line: 5 ]]
	return {
		points = p1.minimapPoints,
		circles = p1.minimapCircles
	}
end)(Minimap)