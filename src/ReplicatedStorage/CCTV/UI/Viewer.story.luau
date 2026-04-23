-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1)
	local Viewer = require(script.Parent.Viewer)
	local v1 = Roact.mount(Roact.createElement(Viewer, {
		size = UDim2.new(0.8, 0, 0.8, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		distance = 96,
		aspectRatio = 1.7777777777777777,
		cameraTag = "CCTVCamera",
		fieldOfView = 70
	}), p1)
	return function()
		Roact.unmount(v1)
	end
end