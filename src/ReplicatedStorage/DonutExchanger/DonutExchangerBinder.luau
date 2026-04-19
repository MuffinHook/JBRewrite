-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMhA29iahpFWENIQU5HRV9ET05VVF9SRU1PVEVfTkFNRQ5GaW5kRmlyc3RDaGlsZApGaXJlU2VydmVyBmFjdGlvbgNuZXcMc2V0bWV0YXRhYmxlBE5hbWUFVGltZWQERGlzdAhDYWxsYmFjawRUYWxrC1ByaW1hcnlQYXJ0BFBhcnQJVmFsaWRSb290BG1haWQDQWRkCEdpdmVUYXNrBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBnNjcmlwdAZQYXJlbnQURG9udXRFeGNoYW5nZXJDb25zdHMDU3RkCkJhc2VPYmplY3QGQmluZGVyAlVJBk1vZHVsZQxDaXJjbGVBY3Rpb24HX19pbmRleAhUQUdfTkFNRQADBQICAAAADw4BDAD7AgAATQICEwAAAAD7BAEATQQE+QEAAAC8AgIDAgAAAJ8CAwK8AgJrAwAAAJ8CAgGpAgEAggICAAQDAQMCAwMDBAAQBQEYAAEAAAAAAAAAAAAAAAIAEQAAAAAJAQQAAAAy+wEAAE0BAe8AAAAAUgIAAJ8BAgL7BAEAnj0BBAQAAABSAwEApAICAAAAEECfAgMB2QIAABIAAQASAgIA4gMHAG8ECAAwBAO6AwAAAKkEAAAwBANxBAAAAIwECgAwBAPjBQAAADACA0YGAAAATQQBEwkAAABNBASbCgAAADAEA0QLAAAATQQBEwkAAAAwBANJDAAAAE0EARYNAAAA+wYDAE0GBl8OAAAAUgcDAE0IARMJAAAAnwYDALwEBP0PAAAAnwQAAYIBAgAQAwYDBwQAABBAAwgDCQMKAwsFBAMEBQYDDAMBAw0DDgMPAxADEQMSAQAMBgEYAAAAAAABAAAAAAAAAgAABwEAAAEAAAEAAAEAAwAAAAAAAQAAAAEAAAAAAAAAAAAAAAINAAAAAAoAAAECAECjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQECkAgcAAABgQE0CAiQIAAAATQICagkAAACfAQICpAIFAAAAQEBNAwChCgAAAE0DA0sLAAAAnwICAqQDBQAAAEBATQQAoQoAAABNBAR/DAAAAJ8DAgKkBAUAAABAQE0GAEAOAAAATQUGXA0AAACfBAICTQUE3Q8AAAD/BgIAAAAAADAGBm4QAAAAnj0GBQIAAABSCAYAUgkCAKQHEgAAABBBnwcDAcAHEwASAAIAEgAGABIAAQASAAUAMAcG7xQAAABNBwPvFAAAAE0IAbQVAAAAUgkGAJ8HAwCCBwAAFgMTBAAAAEADFAMVAxYEAABAQAMXBAAAYEADGAMZAxoDGwMcAx0DHgMfAyADBwQAABBBBgEDBgMhAQEBAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAEAAgABAAEAAAAAAAACAAAAAAAAGQAAAAAAAAEAAAAAAjT4BIBLeKncAhv1oexLPH9E4BP0BjxugQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:22
-- Luau version 6, Types version 3
-- Time taken: 0.001596 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DonutExchangerConsts_upvr = require(script.Parent.DonutExchangerConsts)
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.new(arg1) -- Line 12
    --[[ Upvalues[4]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: DonutExchangerConsts_upvr (readonly)
        [4]: CircleAction_upvr (readonly)
    ]]
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.maid:GiveTask(CircleAction_upvr.Add({
        Name = "Talk";
        Timed = false;
        Dist = 10;
        Callback = function(arg1_2, arg2) -- Line 16, Named "action"
            --[[ Upvalues[2]:
                [1]: any_new_result1_upvr (readonly)
                [2]: DonutExchangerConsts_upvr (copied, readonly)
            ]]
            if arg2 then
                any_new_result1_upvr.obj:FindFirstChild(DonutExchangerConsts_upvr.EXCHANGE_DONUT_REMOTE_NAME):FireServer()
            end
            return true
        end;
        Part = any_new_result1_upvr.obj.PrimaryPart;
        ValidRoot = any_new_result1_upvr.obj;
    }, any_new_result1_upvr.obj))
    return any_new_result1_upvr
end
return require(ReplicatedStorage.Std.Binder).new(DonutExchangerConsts_upvr.TAG_NAME, module_upvr)