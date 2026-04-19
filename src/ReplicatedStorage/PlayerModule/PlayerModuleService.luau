-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZBVZhbHVlDHNldElzSnVtcGluZxRzZXRDYW1lcmFTZW5zaXRpdml0eQpHZXRDYW1lcmFzFmFjdGl2ZUNhbWVyYUNvbnRyb2xsZXITZ2V0Q2FtZXJhQ29udHJvbGxlchpHZXRDYW1lcmFUb1N1YmplY3REaXN0YW5jZRpnZXRDYW1lcmFUb1N1YmplY3REaXN0YW5jZRpTZXRDYW1lcmFUb1N1YmplY3REaXN0YW5jZRpzZXRDYW1lcmFUb1N1YmplY3REaXN0YW5jZQ1HZXRNb3ZlVmVjdG9yDWdldE1vdmVWZWN0b3IEZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2ULTG9jYWxQbGF5ZXINUGxheWVyU2NyaXB0cwxXYWl0Rm9yQ2hpbGQMUGxheWVyTW9kdWxlDUNvbnRyb2xNb2R1bGUKTWFudWFsSnVtcAxDYW1lcmFNb2R1bGURQ2FtZXJhU2Vuc2l0aXZpdHkHcmVxdWlyZQtHZXRDb250cm9scwAHAgEBAAAGAwAABQEBBPsBAAAwAAHsAAAAAIIAAQABAwEACwIBGAAAAAEMAAAAAAIBAQAABgMAAAUBAgT7AQAAMAAB7AAAAACCAAEAAQMBAA4DARgAAAABDwAAAAACAAEAAAAL+wAAALwAALAAAAAAnwACAg4ABABNAQCFAQAAAA4BAQCCAQIAxgEAAIIBAgACAwQDBQARBgEYAAAAAAEBAAEBAwASAAAAAAMAAQAAABL7AQAAvAEBsAAAAACfAQICDgEFAE0CAYUBAAAADgICAFIAAgBlAAEAxgAAAA4ABAC8AQAwAgAAAJ8BAgCCAQAAxgEAAIIBAgADAwQDBQMHABsIARgAAAAAAQEAAQEAAwQBAAAAAgASAAAAAAUBAQAABgMAAAUBAhT7AgAAvAICsAAAAACfAgICDgIFAE0DAoUBAAAADgMCAFIBAwBlAAEAxgEAAA4BBgBSBAAAvAIBPAIAAACfAgMBqQIBAIICAgCpAgAAggICAAMDBAMFAwkAIgoBGAAAAAABAQABAQADCwEAAAABAAIAEgAAAAACAAEAAAAF+wAAALwAAP0AAAAAnwACAIIAAAABAwsAKgwBGAAAAAAAKwAAAAALAAABAgBBowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAk0BADEEAAAAbwMFALwBAdMGAAAAnwEDAm8DBwC8AQHTBgAAAJ8BAwJvBAgAvAIB0wYAAACfAgMCbwUJALwDAtMGAAAAnwMDAm8GCgC8BAHTBgAAAJ8EAwJvBwsAvAUE0wYAAACfBQMCpAYNAAAAwEBSBwEAnwYCArwHBn0OAAAAnwcCAv8IBAAAAAAAwAkPABIAAwAwCQjZEAAAAMAJEQASAAUAMAkI3hIAAADACRMAEgAGAMAKFAASAAYAMAoIEBUAAADAChYAEgAGADAKCBwXAAAAwAoYABIABwAwCgjdGQAAAIIIAgAaAw0EAAAAQAMOAw8DEAMRAxIDEwMUAxUDFgMXAxgEAADAQAMZBgADAgYBAwMGAgYDAwgGBAMKBgUDDAYAAQIDBAUBAAEYAAAAAAAAAAEAAAAAAAAAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAIAAQAAAAMAAAADAAoAAAAHAAAACAAAAAMBAAAAAAa49Mq3odslceKJ7mKXnAMtyOzdw4owoLY=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:12
-- Luau version 6, Types version 3
-- Time taken: 0.002689 seconds

local PlayerModule = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
local var1_2_upvr = require(PlayerModule)
local module = {}
local ManualJump_upvr = PlayerModule:WaitForChild("ControlModule"):WaitForChild("ManualJump")
function module.setIsJumping(arg1) -- Line 11
    --[[ Upvalues[1]:
        [1]: ManualJump_upvr (readonly)
    ]]
    ManualJump_upvr.Value = arg1
end
local CameraSensitivity_upvr = PlayerModule:WaitForChild("CameraModule"):WaitForChild("CameraSensitivity")
function module.setCameraSensitivity(arg1) -- Line 14
    --[[ Upvalues[1]:
        [1]: CameraSensitivity_upvr (readonly)
    ]]
    CameraSensitivity_upvr.Value = arg1
end
local function _() -- Line 17, Named "getCameraController"
    --[[ Upvalues[1]:
        [1]: var1_2_upvr (readonly)
    ]]
    local any_GetCameras_result1_3 = var1_2_upvr:GetCameras()
    if any_GetCameras_result1_3 then
        local activeCameraController_2 = any_GetCameras_result1_3.activeCameraController
        if activeCameraController_2 then
            return activeCameraController_2
        end
    end
    return nil
end
function module.getCameraToSubjectDistance() -- Line 27
    --[[ Upvalues[1]:
        [1]: var1_2_upvr (readonly)
    ]]
    local any_GetCameras_result1 = var1_2_upvr:GetCameras()
    if any_GetCameras_result1 then
        if any_GetCameras_result1.activeCameraController then
            -- KONSTANTWARNING: GOTO [11] #10
        end
    end
    local var12
    if var12 then
        return var12:GetCameraToSubjectDistance()
    end
    return nil
end
function module.setCameraToSubjectDistance(arg1) -- Line 34
    --[[ Upvalues[1]:
        [1]: var1_2_upvr (readonly)
    ]]
    local any_GetCameras_result1_2 = var1_2_upvr:GetCameras()
    if any_GetCameras_result1_2 then
        if any_GetCameras_result1_2.activeCameraController then
            -- KONSTANTWARNING: GOTO [11] #10
        end
    end
    local var15
    if var15 then
        var15:SetCameraToSubjectDistance(arg1)
        return true
    end
    return false
end
local any_GetControls_result1_upvr = var1_2_upvr:GetControls()
function module.getMoveVector() -- Line 42
    --[[ Upvalues[1]:
        [1]: any_GetControls_result1_upvr (readonly)
    ]]
    return any_GetControls_result1_upvr:GetMoveVector()
end
return module