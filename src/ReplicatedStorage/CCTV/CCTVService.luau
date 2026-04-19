-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMeD29uUmVxdWVzdFByb21wdARGaXJlBmFjdGlvbgZSZW1vdmUDbmV3BFBhcnQETmFtZQVUaW1lZAREaXN0CENhbGxiYWNrFU9wZW4gU2VjdXJpdHkgQ2FtZXJhcwNBZGQIR2l2ZVRhc2sFU3RhcnQKQ0NUVlByb21wdARpbml0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA1N0ZAZCaW5kZXIETWFpZAZTaWduYWwCVUkGTW9kdWxlDENpcmNsZUFjdGlvbgZzY3JpcHQGUGFyZW50DENhbWVyYUJpbmRlcgAFBAIBAAAACQ4BBgD7AgAATQICjAAAAAC8AgLdAQAAAJ8CAgGpAgEAggICAAIDAQMCABEDARgAAQAAAAAAAgASAAAAAAIAAgAAAAb7AAAATQAAaQAAAAD7AQEAnwACAYIAAQABAwQAHwABGAAAAAAAASAAAAAABwEDAAAAIfsBAABNAQHvAAAAAJ8BAQLAAgEAEgIBAOIDBwAwAANEAgAAAG8ECAAwBAO6AwAAAKkEAAAwBANxBAAAAIwECAAwBAPjBQAAADACA0YGAAAA+wQCAE0EBF8JAAAAUgUDAFIGAACfBAMB2QYBABICAgASAAAAvAQB/QoAAACfBAMBggECAAsDBQYAAwYDBwMIAwkDCgUFAgMEBQYDCwMMAw0CAAEPAAEYAAAAAAEABgEAAQAAAQAAAQAAAQACAAAAAAABAAAAAAAEEAAAAAADAAUAAAAR+wAAALwAABwAAAAAnwACAfsAAQBNAADvAQAAAG8BAgDAAgMAEgICABICAwASAgQAnwADArwBABwAAAAAnwECAYIAAQAEAw4DBQMPBgIBAgwQARgAAAAAAgAAAAAAAAAAFgAAAQ0AAAAACQAAAQIAPqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQICfwcAAACfAQICpAIFAAAAQEBNAwChBgAAAE0DA3YIAAAAnwICAqQDBQAAAEBATQQAoQYAAABNBAQfCQAAAJ8DAgKkBAUAAABAQE0GAEALAAAATQUGXAoAAACfBAICTQUE3QwAAACkBgUAAABAQKQHDgAAANBATQcHJA8AAABNBweWEAAAAJ8GAgL/BwIAAAAAAE0IA+8RAAAAnwgBAjAIB4wSAAAAwAgTABIABgASAAEAEgACABIABwASAAUAMAgHExQAAACCBwIAFQMRBAAAAEADEgMTAxQEAABAQAMVAxYDFwMYAxkDGgMbAxwEAADQQAMdAx4DBQMBBgMDEAEDAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAQACAAAAAAAAAAACAAEAAAAAAQAAAAAAAAAbAQAAAAAEZ9xuvpAl07X2UqIq+3I9fxfEecpVGAS/

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:53
-- Luau version 6, Types version 3
-- Time taken: 0.001956 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {
    onRequestPrompt = require(ReplicatedStorage.Std.Signal).new();
}
local CameraBinder_upvr = require(script.Parent.CameraBinder)
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.init() -- Line 12
    --[[ Upvalues[5]:
        [1]: CameraBinder_upvr (readonly)
        [2]: Binder_upvr (readonly)
        [3]: Maid_upvr (readonly)
        [4]: module_upvr (readonly)
        [5]: CircleAction_upvr (readonly)
    ]]
    CameraBinder_upvr:Start()
    Binder_upvr.new("CCTVPrompt", function(arg1) -- Line 15
        --[[ Upvalues[3]:
            [1]: Maid_upvr (copied, readonly)
            [2]: module_upvr (copied, readonly)
            [3]: CircleAction_upvr (copied, readonly)
        ]]
        local any_new_result1 = Maid_upvr.new()
        local tbl = {}
        tbl.Part = arg1
        tbl.Name = "Open Security Cameras"
        tbl.Timed = false
        tbl.Dist = 8
        function tbl.Callback(arg1_2, arg2) -- Line 17, Named "action"
            --[[ Upvalues[1]:
                [1]: module_upvr (copied, readonly)
            ]]
            if arg2 then
                module_upvr.onRequestPrompt:Fire()
            end
            return true
        end
        CircleAction_upvr.Add(tbl, arg1)
        any_new_result1:GiveTask(function() -- Line 31
            --[[ Upvalues[2]:
                [1]: CircleAction_upvr (copied, readonly)
                [2]: arg1 (readonly)
            ]]
            CircleAction_upvr.Remove(arg1)
        end)
        return any_new_result1
    end):Start()
end
return module_upvr