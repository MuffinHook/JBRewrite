-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTA25ldwxzZXRtZXRhdGFibGUGR2V0QWxsCkdldFBvb2xPYmoDb2JqCUdldEFjdGl2ZQVlcnJvch5Ob3RoaW5nIGV4aXN0cyBpbiB0aGlzIHBvb2wuLi4DR2V0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA1N0ZApCYXNlT2JqZWN0BkJpbmRlcgpOZXRPYmpQb29sFE5ldE9ialBvb2xJdGVtQmluZGVyB19faW5kZXgAAwUBAgAAAA37AQAATQEB7wAAAABSAgAAnwECAvsEAQCePQEEBAAAAFIDAQCkAgIAAAAQQJ8CAwGCAQIAAwMBAwIEAAAQQAALAQEYAAAAAAABAAAAAAAAAgwAAAAACQEBAAAAHMYBAAD7AgAAvAIC0AAAAACfAgIEZAIOALwHBkEBAAAAnwcCAk0IABMCAAAAmgcIAAgAAAC8BwZFAwAAAJ8HAgIqBwMAAQAAgFIBBgBlAAIAbgLx/wIAAAArAQQApAIFAAAAQEBvAwYAnwICAYIBAgAHAwMDBAMFAwYDBwQAAEBAAwgAEQkBGAABAAAAAAEAAAAAAAAAAAAAAAEB/QAKAQAAAAISAAAAAAgAAAECADajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgChBgAAAE0CAksHAAAAnwECAqQCBQAAAEBATQMAoQYAAABNAwN/CAAAAJ8CAgKkAwUAAABAQE0EAIwJAAAATQQEmgoAAACfAwIC/wQDAAAAAAAwBARuCwAAAJ49BAUBAAAAUgYEAFIHAQCkBQ0AAADAQJ8FAwHABQ4AEgABABIABAAwBQTvDwAAAMAFEAASAAMAMAUEfxEAAABNBQLvDwAAAG8GCQBSBwQAnwUDAIIFAAASAwoEAAAAQAMLAwwDDQQAAEBAAw4DDwMQAxEDEgMTAwIEAADAQAYAAwEGAQMJAgABAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAIAAAAAAAACAAEAAQAAAAAAAAIAAAAABgAAABIAAAAAAAEAAAAAAiMNJlJaMnbKT16hnz1FmiZTFTEmEclMUw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:17
-- Luau version 6, Types version 3
-- Time taken: 0.001797 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
function module_upvr.new(arg1) -- Line 11
    --[[ Upvalues[2]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    return any_new_result1
end
local NetObjPoolItemBinder_upvr = require(ReplicatedStorage.NetObjPool.NetObjPoolItemBinder)
function module_upvr.Get(arg1) -- Line 17
    --[[ Upvalues[1]:
        [1]: NetObjPoolItemBinder_upvr (readonly)
    ]]
    -- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
    local any_GetAll_result1, any_GetAll_result2, any_GetAll_result3 = NetObjPoolItemBinder_upvr:GetAll()
    -- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [20] 15. Error Block 5 start (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [20] 15. Error Block 5 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [6] 6. Error Block 2 start (CF ANALYSIS FAILED)
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [20.7]
    -- KONSTANTERROR: [6] 6. Error Block 2 end (CF ANALYSIS FAILED)
end
return require(ReplicatedStorage.Std.Binder).new("NetObjPool", module_upvr)