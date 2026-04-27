local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(guiParent)
	local CCTV = require(script.Parent.CCTV)
	local cctvInstance = Roact.mount(Roact.createElement(CCTV, {
		size = UDim2.new(0.5, 0, 0.5, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		distance = 96,
		aspectRatio = 1.7777777777777777,
		cameraCFrame = workspace.CurrentCamera.CFrame,
		fieldOfView = 70
	}), guiParent)
	return function()
		Roact.unmount(cctvInstance)
	end
end
