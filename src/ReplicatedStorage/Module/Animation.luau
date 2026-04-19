-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRBHRpY2sIT25VcGRhdGUFRXZlbnQKRGlzY29ubmVjdApPbkNvbXBsZXRlDHNldG1ldGF0YWJsZQhEdXJhdGlvbgZhc3NlcnQIT25DYW5jZWwJSGVhcnRiZWF0B0Nvbm5lY3QDbmV3B0Rlc3Ryb3kEZ2FtZQpSdW5TZXJ2aWNlCkdldFNlcnZpY2UHX19pbmRleAAECQEDAAAAMKQBAQAAAABAnwEBAvsDAAAmAgED+wQBANQEAgACAAAAqQMAAakDAQAOAwEA+wIBAPsEAgBNBATOAgAAAA4EDAD7BQEA7AQCBfEEAgAEAAAAjAQBAPsFAgBNBQXOAgAAAFIGAABSBwIAUggEAJ8FBAEOAxIA+wQCAE0EBDYDAAAAvAQEGgQAAACfBAIB+wQCAMYFAAAwBQQ2AwAAAPsEAgBNBASzBQAAAA4EBAD7BAIATQQEswUAAACfBAEBggABAAYDAQQAAABAAwIDAwMEAwUAEAABGAAAAAEAAQAAAAABAQIAAAABAAEAAQIAAAAAAAACAQAAAAAAAQAAAAEAAAABAAAAAxEAAAAABwECAAAALP8CAwAAAAAA+wMAAJ49AgMDAAAApAEBAAAAAECfAQMCTQMA5QIAAAC7AQMCpAIEAAAAMECfAgIBTQIA5QIAAABNAwDOBQAAADADAc4FAAAATQMAswYAAAAwAwGzBgAAAE0DAMwHAAAAMAMBzAcAAACkAwkAAACAQJ8DAQL7BAEATQQE/QoAAADZBgAAEgADABIAAgASAAEAvAQExwsAAACfBAMCMAQBNgwAAACCAQIADQMGBAAAAEADBwMIBAAAMEADAgMFAwkDAQQAAIBAAwoDCwMDAQAFDAEYAAAAAAAAAAABAAAAAAABAAMAAAABAAAAAQAAAAIAAAEAAAAAAAAAAAAAABYGAAAAAAMBAAAAABVNAQA2AAAAACsBAgCpAQAAggECAE0BADYAAAAAvAEBGgEAAACfAQIBxgEAADABADYAAAAATQEAzAIAAAAOAQMATQEAzAIAAACfAQEBqQEBAIIBAgADAwMDBAMJACgNARgAAAABAAMAAAAAAQAAAQAAAQAAAgAqAAAAAAMAAAECABSjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEDAAAAAAAwAQFuBAAAAMACBQASAAEAEgAAADACAe8GAAAAwAIHADACAVAIAAAAggECAAkDDgQAAABAAw8DEAMRBgEDDAYCAw0CAQIBAAEYAAAAAAAAAAIAAQABAAAAACMAAA4BAAAAAAN8/4A6ui6+jK/g0ZPE99ufDOeXTk476js=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:22
-- Luau version 6, Types version 3
-- Time taken: 0.003869 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
local RunService_upvr = game:GetService("RunService")
function module_upvr.new(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: RunService_upvr (readonly)
    ]]
    local setmetatable_result1_upvr = setmetatable({}, module_upvr)
    assert(arg1.Duration)
    setmetatable_result1_upvr.OnUpdate = arg1.OnUpdate
    setmetatable_result1_upvr.OnComplete = arg1.OnComplete
    setmetatable_result1_upvr.OnCancel = arg1.OnCancel
    local tick_result1_upvr = tick()
    local Duration_upvr = arg1.Duration
    setmetatable_result1_upvr.Event = RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 16
        --[[ Upvalues[3]:
            [1]: tick_result1_upvr (readonly)
            [2]: Duration_upvr (readonly)
            [3]: setmetatable_result1_upvr (readonly)
        ]]
        local var10 = tick_result1_upvr
        local var11
        if Duration_upvr > var11 then
            var10 = false
        else
            var10 = true
        end
        if var10 then
            var11 = Duration_upvr
        end
        if setmetatable_result1_upvr.OnUpdate then
            local var12 = var11 / Duration_upvr
            if var12 ~= var12 then
                var12 = 1
            end
            setmetatable_result1_upvr.OnUpdate(arg1_2, var11, var12)
        end
        if var10 then
            setmetatable_result1_upvr.Event:Disconnect()
            setmetatable_result1_upvr.Event = nil
            if setmetatable_result1_upvr.OnComplete then
                setmetatable_result1_upvr.OnComplete()
            end
        end
    end)
    return setmetatable_result1_upvr
end
function module_upvr.Destroy(arg1) -- Line 40
    if not arg1.Event then
        return false
    end
    arg1.Event:Disconnect()
    arg1.Event = nil
    if arg1.OnCancel then
        arg1.OnCancel()
    end
    return true
end
return module_upvr