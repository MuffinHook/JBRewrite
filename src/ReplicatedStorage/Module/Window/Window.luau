-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaDHNldG1ldGF0YWJsZQNuZXcFX21haWQHX2lzT3Blbg5fYmVmb3JlT3BlbkZ1bglfb25PcGVuZWQIR2l2ZVRhc2sRR2V0T25PcGVuZWRTaWduYWwJX29uQ2xvc2VkEUdldE9uQ2xvc2VkU2lnbmFsBmFzc2VydARGaXJlBE9wZW4FQ2xvc2UGSXNPcGVuB0Rlc3Ryb3kEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkBlNpZ25hbARNYWlkBldpbmRvdwtfX0NsYXNzTmFtZQdfX2luZGV4AAgEAAIAAAAW/wADAAAAAAD7AwAAnj0ABAMAAABSAgAApAEBAAAAAECfAQMB+wEBAE0BAe8CAAAAnwEBAjABAMEDAAAAqQEAADABACQEAAAAxgEAADABABcFAAAAggACAAYDAQQAAABAAwIDAwMEAwUACAIBGAAAAQAAAAAAAAIAAAAAAAEAAAIAAAIJAAAAAAQBAQAAABNNAQAUAAAAACsBDQD7AQAATQEB7wEAAACfAQECMAEAFAAAAABNAQDBAgAAAE0DABQAAAAAvAEB/QMAAACfAQMBTQEAFAAAAACCAQIABAMGAwIDAwMHABMIARgAAAABAAAAAAABAAAAAAAAAgAAFAAAAAAEAQEAAAATTQEAIAAAAAArAQ0A+wEAAE0BAe8BAAAAnwEBAjABACAAAAAATQEAwQIAAABNAwAgAAAAALwBAf0DAAAAnwEDAU0BACAAAAAAggECAAQDCQMCAwMDBwAaCgEYAAAAAQAAAAAAAQAAAAAAAAIAABsAAAAABAEAAAAAGU0DACQAAAAAVgIDALsBAgKkAQIAAAAQQJ8BAgGpAQEAMAEAJAAAAABNAQAXAwAAAA4BAwC8AQAXAwAAAJ8BAgFNAQAUBAAAAA4BBQBNAQAUBAAAALwBAd0FAAAAnwECAYIAAQAGAwQDCwQAABBAAwUDBgMMACENARgAAAAAAAAAAQAAAQAAAQAAAgAAAQAAAAACIgAAAAADAQAAAAASTQIAJAAAAAC7AQICpAECAAAAEECfAQIBqQEAADABACQAAAAATQEAIAMAAAAOAQUATQEAIAMAAAC8AQHdBAAAAJ8BAgGCAAEABQMEAwsEAAAQQAMJAwwAKw4BGAAAAAAAAAEAAAEAAAEAAAAAAiwAAAAAAgEAAAAAA00BACQAAAAAggECAAEDBAAyDwEYAAAAMwAAAAAEAQAAAAAWTQIAwQAAAAC7AQICpAECAAAAEECfAQIBvAEAMQMAAACfAQICDgEDALwBAGMEAAAAnwECAU0BAMEAAAAAxgIAADACAMEAAAAAvAIBUAUAAACfAgIBggABAAYDAwMLBAAAEEADDwMOAxAANRABGAAAAAAAAAEAAAABAAACAAEAAAEAAAE2AAAAAAUAAAECADajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgChBgAAAE0CAh8HAAAAnwECAqQCBQAAAEBATQMAoQYAAABNAwN2CAAAAJ8CAgL/AwUAAAAAAG8ECQAwBAPlCgAAADADA24LAAAAwAQMABIAAwASAAIAMAQD7w0AAADABA4AEgABADAEAywPAAAAwAQQABIAAQAwBAN1EQAAAMAEEgAwBAMWEwAAAMAEFAAwBANjFQAAAMAEFgAwBAMxFwAAAMAEGAAwBANQGQAAAIIDAgAaAxEEAAAAQAMSAxMDFAQAAEBAAxUDFgMXAxgDGQMaBgADAgYBAwgGAgMKBgMDDQYEAw4GBQMPBgYDEAcAAQIDBAUGAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAIAAQAAAQABAAAAAAsAAAAHAAAABwAACgAABwAAAwAACQEAAAAAB4H41Y6zklakUOyZg6qZs4Px4ML6szy/jw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:54
-- Luau version 6, Types version 3
-- Time taken: 0.002968 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local module_upvr = {
    __ClassName = "Window";
}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.new() -- Line 8
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: Maid_upvr (readonly)
    ]]
    local module = {}
    setmetatable(module, module_upvr)
    module._maid = Maid_upvr.new()
    module._isOpen = false
    module._beforeOpenFun = nil
    return module
end
function module_upvr.GetOnOpenedSignal(arg1) -- Line 19
    --[[ Upvalues[1]:
        [1]: Signal_upvr (readonly)
    ]]
    if not arg1._onOpened then
        arg1._onOpened = Signal_upvr.new()
        arg1._maid:GiveTask(arg1._onOpened)
    end
    return arg1._onOpened
end
function module_upvr.GetOnClosedSignal(arg1) -- Line 26
    --[[ Upvalues[1]:
        [1]: Signal_upvr (readonly)
    ]]
    if not arg1._onClosed then
        arg1._onClosed = Signal_upvr.new()
        arg1._maid:GiveTask(arg1._onClosed)
    end
    return arg1._onClosed
end
function module_upvr.Open(arg1) -- Line 33
    assert(not arg1._isOpen)
    arg1._isOpen = true
    if arg1._beforeOpenFun then
        arg1:_beforeOpenFun()
    end
    if arg1._onOpened then
        arg1._onOpened:Fire()
    end
end
function module_upvr.Close(arg1) -- Line 43
    assert(arg1._isOpen)
    arg1._isOpen = false
    if arg1._onClosed then
        arg1._onClosed:Fire()
    end
end
function module_upvr.IsOpen(arg1) -- Line 50
    return arg1._isOpen
end
function module_upvr.Destroy(arg1) -- Line 53
    assert(arg1._maid)
    if arg1:IsOpen() then
        arg1:Close()
    end
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr