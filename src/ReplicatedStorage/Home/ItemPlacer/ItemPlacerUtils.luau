local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera_upvr = workspace.CurrentCamera
local module_upvr = {}
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local UserInputService_upvr = game:GetService("UserInputService")
function module_upvr.getMouseLocation(arg1) -- Line 8
    if InputUtils_upvr.isTouch() and not arg1 then
        local ViewportSize = CurrentCamera_upvr.ViewportSize
        return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
    end
    return UserInputService_upvr:GetMouseLocation()
end
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
function module_upvr.raycastMouse(arg1, arg2) -- Line 19
    local any_getMouseLocation_result1 = module_upvr.getMouseLocation(arg2)
    local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(any_getMouseLocation_result1.X, any_getMouseLocation_result1.Y)
    local RaycastParams_new_result1 = RaycastParams.new()
    RaycastParams_new_result1.FilterDescendantsInstances = arg1
    local any_collidable_result1 = Raycast_upvr.collidable(any_ViewportPointToRay_result1.Origin, any_ViewportPointToRay_result1.Direction, 999, RaycastParams_new_result1)
    if any_collidable_result1 then
        return any_collidable_result1
    end
    return nil
end
return module_upvr