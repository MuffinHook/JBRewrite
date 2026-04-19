-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRBmFzc2VydAxzZXRtZXRhdGFibGUFR3JhcGgETm9kZQNuZXcPX29uV2Fsa2VkU2lnbmFsEUdldE9uV2Fsa2VkU2lnbmFsB0hhc0VkZ2UERmlyZQZXYWxrVG8EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkBlNpZ25hbAdfX2luZGV4AAQGAgEAAAAYuwEAA1IDAACkAgEAAAAAQJ8CAgG7AQEDUgMBAKQCAQAAAABAnwICAf8CAgAAAAAA+wUAAJ49AgQFAAAAUgQCAKQDAwAAACBAnwMDATAAAjEEAAAAMAECDgUAAACCAgIABgMBBAAAAEADAgQAACBAAwMDBAAGBQEYAAAAAAABAAAAAAIAAQAAAAAAAAIAAQACBwAAAAACAQEAAAANTQEAfgAAAABHAQcAAAAAgPsBAABNAQHvAQAAAJ8BAQIwAQB+AAAAAE0BAH4AAAAAggECAAIDBgMFABIHARgAAAAAAQAAAAAAAgAAEwAAAAAGAgAAAAAduwEBA1IDAQCkAgEAAAAAQJ8CAgFNAgAxAgAAAE0EAA4DAAAAUgUBALwCAigEAAAAnwIEAg4CDQAwAQAOAwAAAE0CAH4FAAAADgIGAE0CAH4FAAAAUgQBALwCAt0GAAAAnwIDAakCAQCCAgIAqQIAAIICAgAHAwEEAAAAQAMDAwQDCAMGAwkAGAoBGAAAAAAAAQAAAAAAAAAAAQABAAABAAAAAAACAAIAGQAAAAAEAAABAgAeowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgIfBwAAAJ8BAgL/AgMAAAAAADACAm4IAAAAwAMJABIAAgAwAwLvCgAAAMADCwASAAEAMAMCVwwAAADAAw0AMAMCXw4AAACCAgIADwMLBAAAAEADDAMNAw4EAABAQAMPAxADEQYAAwUGAQMHBgIDCgMAAQIBAAEYAAAAAAAAAAEAAAAAAAACAAEAAQAAAAwAAAAGAAAMAQAAAAADQjH+fI7QqFul6AcCcCrtpzIp6Qhw9ZR9

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:49
-- Luau version 6, Types version 3
-- Time taken: 0.001892 seconds

local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
function module_2_upvr.new(arg1, arg2) -- Line 6
    --[[ Upvalues[1]:
        [1]: module_2_upvr (readonly)
    ]]
    assert(arg1)
    assert(arg2)
    local module = {}
    setmetatable(module, module_2_upvr)
    module.Graph = arg1
    module.Node = arg2
    return module
end
local Signal_upvr = require(game:GetService("ReplicatedStorage").Std.Signal)
function module_2_upvr.GetOnWalkedSignal(arg1) -- Line 18
    --[[ Upvalues[1]:
        [1]: Signal_upvr (readonly)
    ]]
    if arg1._onWalkedSignal == nil then
        arg1._onWalkedSignal = Signal_upvr.new()
    end
    return arg1._onWalkedSignal
end
function module_2_upvr.WalkTo(arg1, arg2) -- Line 24
    assert(arg2)
    if arg1.Graph:HasEdge(arg1.Node, arg2) then
        arg1.Node = arg2
        if arg1._onWalkedSignal then
            arg1._onWalkedSignal:Fire(arg2)
        end
        return true
    end
    return false
end
return module_2_upvr