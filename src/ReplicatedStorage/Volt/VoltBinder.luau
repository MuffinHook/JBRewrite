-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMbEUVOR0lORV9TT1VORF9OQU1FDkZpbmRGaXJzdENoaWxkCFZlbG9jaXR5CU1hZ25pdHVkZQRtYXRoA2Ficw1QbGF5YmFja1NwZWVkA25ldwxzZXRtZXRhdGFibGUDb2JqBkVuZ2luZQRtYWlkCUhlYXJ0YmVhdAdDb25uZWN0CEdpdmVUYXNrBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQpSdW5TZXJ2aWNlB3JlcXVpcmUDU3RkCkJhc2VPYmplY3QGQmluZGVyBFZvbHQKVm9sdENvbnN0cwdfX2luZGV4CFRBR19OQU1FAAMGAAIAAAAX+wAAAPsCAQBNAgIjAAAAALwAAAMBAAAAnwADAvsBAABNAQGFAgAAAE0BAaoDAAAADgAJALsCAQNSBQEApAQIAAAcYICfBAIClQMEBT4CAwQwAgAoCQAAAIIAAQAKAwEDAgMDAwQCAAAAAADAYkACAAAAAAAAFEADBQMGBAAcYIADBwAQAAEYAAAAAAAAAAEAAAAAAQEAAAAAAAAAAAIRAAAAAAgBBAAAAB/7AQAATQEB7wAAAABSAgAAnwECAvsEAQCePQEEBAAAAFIDAQCkAgIAAAAQQJ8CAwFNAgETAwAAAE0CAmYEAAAATQMBFgUAAAD7BQIATQUF/QYAAADZBwAAEgACABICAwC8BQXHBwAAAJ8FAwC8AwP9CAAAAJ8DAAGCAQIACQMIAwkEAAAQQAMKAwsDDAMNAw4DDwEACwgBGAAAAAAAAQAAAAAAAAIAAAABAAAAAAAAAAAAAAAAAAgMAAAAAAkAAAECADujAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIGAAAAUEBNAwChBwAAAE0DA0sIAAAAnwICAqQDBgAAAFBATQQAoQcAAABNBAR/CQAAAJ8DAgKkBAYAAABQQE0FADsKAAAATQUFFwsAAACfBAIC/wUCAAAAAAAwBQVuDAAAAJ49BQUCAAAAUgcFAFIIAgCkBg4AAADQQJ8GAwHABg8AEgACABIABQASAAEAEgAEADAGBe8QAAAATQYD7xAAAABNBwS0EQAAAFIIBQCfBgMAggYAABIDEAQAAABAAxEDEgMTAxQEAABQQAMVAxYDFwMYAxkDGgMJBAAA0EAGAQMIAxsBAQEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAgABAAEAAAAAAAACAAAAAAAAEAAAAAAAAAEAAAAAApRrzgd3x1Iq5ZSO155kdLTkc9lzpq+kBg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:57
-- Luau version 6, Types version 3
-- Time taken: 0.001818 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local VoltConsts_upvr = require(ReplicatedStorage.Volt.VoltConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local RunService_upvr = game:GetService("RunService")
function module_upvr.new(arg1) -- Line 11
    --[[ Upvalues[4]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: RunService_upvr (readonly)
        [4]: VoltConsts_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    local Engine_upvr = any_new_result1.obj.Engine
    any_new_result1.maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 16
        --[[ Upvalues[2]:
            [1]: Engine_upvr (readonly)
            [2]: VoltConsts_upvr (copied, readonly)
        ]]
        local SOME = Engine_upvr:FindFirstChild(VoltConsts_upvr.ENGINE_SOUND_NAME)
        if SOME then
            SOME.PlaybackSpeed = (math.abs(Engine_upvr.Velocity.Magnitude) + 5) / 150
        end
    end))
    return any_new_result1
end
return require(ReplicatedStorage.Std.Binder).new(VoltConsts_upvr.TAG_NAME, module_upvr)