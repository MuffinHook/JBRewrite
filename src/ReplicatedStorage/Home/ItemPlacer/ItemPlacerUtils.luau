-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZB2lzVG91Y2gMVmlld3BvcnRTaXplAVgBWQdWZWN0b3IzA25ldxBHZXRNb3VzZUxvY2F0aW9uEGdldE1vdXNlTG9jYXRpb24SVmlld3BvcnRQb2ludFRvUmF5DVJheWNhc3RQYXJhbXMaRmlsdGVyRGVzY2VuZGFudHNJbnN0YW5jZXMKY29sbGlkYWJsZQZPcmlnaW4JRGlyZWN0aW9uDHJheWNhc3RNb3VzZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UQVXNlcklucHV0U2VydmljZQdyZXF1aXJlA1N0ZApJbnB1dFV0aWxzB1JheWNhc3QJd29ya3NwYWNlDUN1cnJlbnRDYW1lcmEAAwcBAwAAAB3GAQAA+wIAAE0CAtUAAAAAnwIBAg4CEQArABAA+wIBAE0CArABAAAATQUCeQMAAABbBAUCTQYCeAUAAABbBQYEjAYAAEw2AAKkAwgAABxggJ8DBAJSAQMAggECAPsCAgC8AgIGCQAAAJ8CAgJSAQIAggECAAoDAQMCAgAAAAAAAOA/AwMCAAAAAAAA2D8DBAMFAwYEABxggAMHAAgIARgAAQAAAAAAAQAAAgAAAAAAAAAAAAAAAAIAAAAAAgkAAAAACgIDAAAAIPsCAABNAgImAAAAAFIDAQCfAgIC+wMBAE0FAnkBAAAATQYCeAIAAAC8AwNGAwAAAJ8DBAKkBAYAABRAgJ8EAQIwAAR9BwAAAPsFAgBNBQWaCAAAAE0GA0MJAAAATQcDYQoAAACMCOcDUgkEAJ8FBQIOBQEAggUCAMYGAACCBgIACwMIAwMDBAMJAwoDBgQAFECAAwsDDAMNAw4AEw8BGAAAAAAAAQAAAAAAAAACAAABAAEAAAAAAAAAAAABAQIAFAAAAAAHAAABAgAuowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAqQCBgAAAFBATQMAoQcAAABNAwPlCAAAAJ8CAgKkAwYAAABQQE0EAKEHAAAATQQEwgkAAACfAwICpAQLAAAAoEBNBARIDAAAAP8FAgAAAAAAwAYNABIAAgASAAQAEgABADAGBSYOAAAAwAYPABIABQASAAQAEgADADAGBQcQAAAAggUCABEDEAQAAABAAxEDEgMTAxQEAABQQAMVAxYDFwMYBAAAoEADGQYAAwgGAQMPAgABAQABGAAAAAAAAAABAAAAAAABAAAAAAAAAQAAAAAAAAEAAAACAAEAAAAAAAsAAAAAAAwBAAAAAAIFeHeZpfZRrbTUcy1l98SXdWBg7Te8HZg=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:13
-- Luau version 6, Types version 3
-- Time taken: 0.001692 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera_upvr = workspace.CurrentCamera
local module_upvr = {}
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local UserInputService_upvr = game:GetService("UserInputService")
function module_upvr.getMouseLocation(arg1) -- Line 8
    --[[ Upvalues[3]:
        [1]: InputUtils_upvr (readonly)
        [2]: CurrentCamera_upvr (readonly)
        [3]: UserInputService_upvr (readonly)
    ]]
    if InputUtils_upvr.isTouch() and not arg1 then
        local ViewportSize = CurrentCamera_upvr.ViewportSize
        return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.375, 0)
    end
    return UserInputService_upvr:GetMouseLocation()
end
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
function module_upvr.raycastMouse(arg1, arg2) -- Line 19
    --[[ Upvalues[3]:
        [1]: module_upvr (readonly)
        [2]: CurrentCamera_upvr (readonly)
        [3]: Raycast_upvr (readonly)
    ]]
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