local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local CurrentCamera = workspace.CurrentCamera
local ItemPlacerUtils = {
	getMouseLocation = function(skipMouseCheck)
		if InputUtils.isTouch() and not skipMouseCheck then
			local ViewportSize = CurrentCamera.ViewportSize
			return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
		else
			return UserInputService:GetMouseLocation()
		end
	end
}
function ItemPlacerUtils.raycastMouse(filterInstances, skipMouseCheck)
	local mouseLocation = ItemPlacerUtils.getMouseLocation(skipMouseCheck)
	local viewportRay = CurrentCamera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = filterInstances
	local hitResult = Raycast.collidable(viewportRay.Origin, viewportRay.Direction, 999, raycastParams)
	if hitResult then
		return hitResult
	else
		return nil
	end
end
return ItemPlacerUtils
