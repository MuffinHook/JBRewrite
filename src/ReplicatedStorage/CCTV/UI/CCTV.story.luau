-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1)
	local CCTV = require(script.Parent.CCTV)
	local v1 = Roact.mount(Roact.createElement(CCTV, {
		size = UDim2.new(0.5, 0, 0.5, 0),
		position = UDim2.new(0.5, 0, 0.5, 0),
		distance = 96,
		aspectRatio = 1.7777777777777777,
		cameraCFrame = workspace.CurrentCamera.CFrame,
		fieldOfView = 70
	}), p1)
	return function()
		Roact.unmount(v1)
	end
end