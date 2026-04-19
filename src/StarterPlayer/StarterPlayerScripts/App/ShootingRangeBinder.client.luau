-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMfBmNhbmNlbAR0YXNrBHdhaXQRU2hvb3RpbmdSYW5nZVBhcnQORmluZEZpcnN0Q2hpbGQKQ2FuQ29sbGlkZQdyZXNvbHZlB3NldE9wZW4HZ2V0T3BlbgthbmRUaGVuQ2FsbAVkZWxheQtnZXREdXJhdGlvbgVhd2FpdANuZXcIR2l2ZVRhc2sRcHJvbWlzZUlubmVyTW9kZWwHYW5kVGhlbgtHaXZlUHJvbWlzZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQdyZXF1aXJlBURvb3IyCURvb3JVdGlscwNTdGQGQmluZGVyBE1haWQHUHJvbWlzZRNTaG9vdGluZ1JhbmdlVGFyZ2V0BVN0YXJ0AAQCAAIAAAAJqQAAAN4AAAD7AAEADgAEAPsAAQC8AACBAAAAAJ8AAgGCAAEAAQMBAA0AARgAAAEAAQAAAAIOAAAAAAkBBQAAADKkAQIAAAQAgG8CAwCfAQIBbwMEALwBAAMFAAAAnwEDAg4BAwCpAgEAMAIB0wYAAAD7AgAADgIjAPsCAgBNAgIdBwAAAJ8CAQL7BAMATQQELggAAAD7BQQA+wcDAE0HBzoJAAAA+wgEAJ8HAgJWBgcAvAICoQoAAACfAgUC+wQCAE0EBL4LAAAA+wYDAE0GBukNAAAA+wcEAJ8GAgKQBQYMvAICoQoAAACfAgQC3gIBAPsCAQC8AgINDgAAAJ8CAgFIANv/ggABAA8DAgMDBAAEAIACAAAAAAAA4D8DBAMFAwYDBwMIAwkDCgMLAgAAAAAAAPA/AwwDDQATAAEYAAAAAAEAAAABAQAAAgABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAP4DAAAA/AYUAAAAAAkBAwAAAB/7AQAATQEB7wAAAACfAQECqQIBAMYDAADZBgAAEgEC/xIBA/+8BAH9AQAAAJ8EAwH7BgEATQYGeQIAAABSBwAAnwYCAtkIAQASAQL/EgED/xICAgASAgEAEgAAALwGBrUDAAAAnwYDALwEAekEAAAAnwQAAcECAACCAQIABQMOAw8DEAMRAxICAAEIAAEYAAAAAAIBAQAAAAAABgAAAAAAAAAAAAAAAAAAAAAOAAkAAAAACQAAAQIANaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAKUHAAAATQMDvAgAAACfAgICpAMGAAAAUEBNBAChCQAAAE0EBH8KAAAAnwMCAqQEBgAAAFBATQUAoQkAAABNBQV2CwAAAJ8EAgKkBQYAAABQQE0GAKEJAAAATQYGcgwAAACfBQICTQYD7w0AAABvBw4AwAgPABIABAASAAIAEgAFAJ8GAwK8BgYcEAAAAJ8GAgGCAAEAEQMTBAAAAEADFAMVAxYDFwQAAFBAAxgDGQMaAxsDHAMdAw4DHgYCAx8BAgEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAIAAAAAAAAAGgAAAQEAAAAAA5uC0Aw2ykfXaJSM7H5oYaTrmsd4qUa6DQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:29:32
-- Luau version 6, Types version 3
-- Time taken: 0.002366 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local DoorUtils_upvr = require(ReplicatedStorage.Door2.DoorUtils)
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
require(ReplicatedStorage.Std.Binder).new("ShootingRangeTarget", function(arg1) -- Line 8
    --[[ Upvalues[3]:
        [1]: Maid_upvr (readonly)
        [2]: DoorUtils_upvr (readonly)
        [3]: Promise_upvr (readonly)
    ]]
    local any_new_result1 = Maid_upvr.new()
    local var7_upvw = true
    local var8_upvw
    any_new_result1:GiveTask(function() -- Line 13
        --[[ Upvalues[2]:
            [1]: var7_upvw (read and write)
            [2]: var8_upvw (read and write)
        ]]
        var7_upvw = false
        if var8_upvw then
            var8_upvw:cancel()
        end
    end)
    any_new_result1:GivePromise(DoorUtils_upvr.promiseInnerModel(arg1):andThen(function(arg1_2) -- Line 19
        --[[ Upvalues[5]:
            [1]: var7_upvw (read and write)
            [2]: var8_upvw (read and write)
            [3]: Promise_upvr (copied, readonly)
            [4]: DoorUtils_upvr (copied, readonly)
            [5]: arg1 (readonly)
        ]]
        task.wait(0.5)
        local ShootingRangePart = arg1_2:FindFirstChild("ShootingRangePart")
        if ShootingRangePart then
            ShootingRangePart.CanCollide = true
        end
        while var7_upvw do
            var8_upvw = Promise_upvr.resolve():andThenCall(DoorUtils_upvr.setOpen, arg1, not DoorUtils_upvr.getOpen(arg1)):andThenCall(Promise_upvr.delay, DoorUtils_upvr.getDuration(arg1) or 1)
            var8_upvw:await()
        end
    end))
    return any_new_result1
end):Start()