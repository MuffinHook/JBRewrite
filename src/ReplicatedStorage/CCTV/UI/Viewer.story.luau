local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parent)
	local Viewer = require(script.Parent.Viewer)
	local viewerHandle = Roact.mount(Roact.createElement(Viewer, {
		size = UDim2.new(0.8, 0, 0.8, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		distance = 96,
		aspectRatio = 1.7777777777777777,
		cameraTag = "CCTVCamera",
		fieldOfView = 70
	}), parent)
	return function()
		Roact.unmount(viewerHandle)
	end
end
