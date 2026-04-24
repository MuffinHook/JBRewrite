-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local CurrentCamera = workspace.CurrentCamera
local t = {
	getMouseLocation = function(p1)
		if InputUtils.isTouch() and not p1 then
			local ViewportSize = CurrentCamera.ViewportSize
			return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
		else
			return UserInputService:GetMouseLocation()
		end
	end
}
function t.raycastMouse(p1, p2)
	local v1 = t.getMouseLocation(p2)
	local v2 = CurrentCamera:ViewportPointToRay(v1.X, v1.Y)
	local instance3 = RaycastParams.new()
	instance3.FilterDescendantsInstances = p1
	local var4 = Raycast.collidable(v2.Origin, v2.Direction, 999, instance3)
	if var4 then
		return var4
	else
		return nil
	end
end
return t
