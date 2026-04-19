-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYBmFzc2VydAxzZXRtZXRhdGFibGUDbmV3BE1haWQIRHVyYXRpb24Cb3MFY2xvY2sGQm9ybkF0C09uQ29tcGxldGVkCEdpdmVUYXNrCk9uQ2FuY2VsZWQLSXNDb21wbGV0ZWQERmlyZQRtYXRoBWNsYW1wBlVwZGF0ZQdEZXN0cm95BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA1N0ZAZTaWduYWwHX19pbmRleAAEBQEDAAAAQrsBAANSAgAApAEBAAAAAECfAQIBjAMAALcDAgAAAAAAqQIAAakCAQC7AQICpAEBAAAAAECfAQIB/wEEAAAAAAD7BAAAnj0BBAQAAABSAwEApAIDAAAAIECfAgMB+wIBAE0CAu8EAAAAnwIBAjACAXYFAAAAMAAB5QYAAACkAgkAACBwgJ8CAQIwAgF0CgAAAPsCAgBNAgLvBAAAAJ8CAQIwAgHPCwAAAE0CAXYFAAAATQQBzwsAAAC8AgL9DAAAAJ8CAwH7AgIATQIC7wQAAACfAgECMAIBwQ0AAABNAgF2BQAAAE0EAcENAAAAvAIC/QwAAACfAgMBqQIAADACAQAOAAAAggECAA8DAQQAAABAAwIEAAAgQAMDAwQDBQMGAwcEACBwgAMIAwkDCgMLAwwADQMBGAAAAAAAAQAAAAAAAAAAAgABAAAAAAAAAgAAAAAAAgABAAAAAAEAAAAAAAEAAAAAAAABAAAAAAABAAAAAAAAAgAAAg4AAAAACAEAAAAAIaQBAgAABACAnwEBAk0DAHQDAAAAJgIBA00EAOUEAAAA7AMCBIwEAQB9BA0AAwAAAE0EAAAFAAAAKgQJAAAAAICpBAEAMAQAAAUAAABNBADPBgAAALwEBN0HAAAAnwQCAYwGAACMBwEANC4DBAYHAABSBQMApAQKAAAkgICfBAQCggQCAAsDBgMHBAAEAIADCAMFAwwDCQMNAw4DDwQAJICAACEQARgAAAABAAABAAABAAABAAAAAQAAAQAAAAADAAAAAAAAAAAiAAAAAAQBAAAAABdNAQB2AAAAAEcBAgAAAACAggABAE0BAHYAAAAAxgIAADACAHYAAAAATQIAAAEAAAAqAgYAAAAAgE0CAMECAAAAvAIC3QMAAACfAgIBvAIBUAQAAACfAgIBggABAAUDBAMMAwsDDQMRAC0RARgAAAAAAQIAAQAAAQAAAAEAAAAAAgAAAS4AAAAABQAAAQIAJqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQICHwcAAACfAQICpAIFAAAAQEBNAwChBgAAAE0DA3YIAAAAnwICAv8DAwAAAAAAMAMDbgkAAADABAoAEgADABIAAgASAAEAMAQD7wsAAADABAwAMAQDJg0AAADABA4AMAQDUA8AAACCAwIAEAMSBAAAAEADEwMUAxUEAABAQAMWAxcDBAMYBgADAwYBAxAGAgMRAwABAgEAARgABAAAAAAAAQAAAAAAAAEAAAAAAAAEAAEAAQAAAAAAFAAADAAADAEAAAAAA0Uf3uq27vRa8HRQ7kWGPSU1B8med9u06w==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:22
-- Luau version 6, Types version 3
-- Time taken: 0.002481 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
function module_2_upvr.new(arg1) -- Line 13
    --[[ Upvalues[3]:
        [1]: module_2_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: Signal_upvr (readonly)
    ]]
    local var5 = arg1
    assert(var5)
    if 0 >= arg1 then
        var5 = false
    else
        var5 = true
    end
    assert(var5)
    local module = {}
    setmetatable(module, module_2_upvr)
    module.Maid = Maid_upvr.new()
    module.Duration = arg1
    module.BornAt = os.clock()
    module.OnCompleted = Signal_upvr.new()
    module.Maid:GiveTask(module.OnCompleted)
    module.OnCanceled = Signal_upvr.new()
    module.Maid:GiveTask(module.OnCanceled)
    module.IsCompleted = false
    return module
end
function module_2_upvr.Update(arg1) -- Line 33
    local var7 = (os.clock() - arg1.BornAt) / arg1.Duration
    if 1 <= var7 and arg1.IsCompleted == false then
        arg1.IsCompleted = true
        arg1.OnCompleted:Fire()
    end
    return math.clamp(var7, 0, 1)
end
function module_2_upvr.Destroy(arg1) -- Line 45
    if arg1.Maid == nil then
    else
        arg1.Maid = nil
        if arg1.IsCompleted == false then
            arg1.OnCanceled:Fire()
        end
        arg1.Maid:Destroy()
    end
end
return module_2_upvr