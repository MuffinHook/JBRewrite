-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKCkNoYXRBY3RpdmUHR2V0Q29yZQdTZXRDb3JlCnNldEVuYWJsZWQKZ2V0RW5hYmxlZARoaWRlBGdhbWUPVGV4dENoYXRTZXJ2aWNlCkdldFNlcnZpY2UKU3RhcnRlckd1aQAFBQEDAAAGAwAABQEBHd4AAAAqAA4AAAAAgPsBAgBvAwAAvAEBiwEAAACfAQMC3gEBAPsBAgBvAwAAqQQAALwBAb8CAAAAnwEEAYIAAQD7AQIAbwMAALwBAYsBAAAAnwEDAisBBgD7AQIAbwMAAPsEAQC8AQG/AgAAAJ8BBAGCAAEAAwMBAwIDAwAIBAEYAAEAAQAAAAAAAQAAAAAAAQIAAAAAAAEAAAAAAAIJAAAAAAEAAQAAAAL7AAAAggACAAAAEwUBGAAAFAAAAAACAAEAAAAG+wAAAE0AAL4AAAAAqQEBAJ8AAgGCAAEAAQMEABgAARgAAAAAAAEZAAAAAAIAAQAAAAj7AAAATQAAvgAAAACpAQAAnwACAcAAAQASAgAAggACAAIDBAYCAQIWBgEYAAAAAAABAAAXAAAAAAYAAAECACGjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMC/wIDAAAAAACpAwEAqQQBANkFAAASAQP/EgEE/xIAAQAwBQK+BQAAANkFAQASAQP/MAUCogYAAADABQcAEgACADAFAu8IAAAAwQMAAIICAgAJAwcEAAAAQAMIAwkDCgMEAwUGAwMGAwABAwEAARgAAAAAAAAAAQAAAAAAAQACAQIAAAAAAAsAAAADAAAABgABAAAAAATZ1EEWP4iDd0jy64ArmT6+qcxWYusQKxc=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:09
-- Luau version 6, Types version 3
-- Time taken: 0.001819 seconds

local module_upvr = {}
local var2_upvw = true
local var3_upvw = true
local StarterGui_upvr = game:GetService("StarterGui")
function module_upvr.setEnabled(arg1) -- Line 8
    --[[ Upvalues[3]:
        [1]: var2_upvw (read and write)
        [2]: var3_upvw (read and write)
        [3]: StarterGui_upvr (readonly)
    ]]
    var2_upvw = arg1
    if arg1 == false then
        var3_upvw = StarterGui_upvr:GetCore("ChatActive")
        StarterGui_upvr:SetCore("ChatActive", false)
    elseif not StarterGui_upvr:GetCore("ChatActive") then
        StarterGui_upvr:SetCore("ChatActive", var3_upvw)
    end
end
function module_upvr.getEnabled() -- Line 19
    --[[ Upvalues[1]:
        [1]: var2_upvw (read and write)
    ]]
    return var2_upvw
end
function module_upvr.hide() -- Line 22
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    module_upvr.setEnabled(false)
    return function() -- Line 24
        --[[ Upvalues[1]:
            [1]: module_upvr (copied, readonly)
        ]]
        module_upvr.setEnabled(true)
    end
end
return module_upvr