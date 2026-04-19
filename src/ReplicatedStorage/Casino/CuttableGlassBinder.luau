-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMpCUN1dFJlbW90ZQ5GaW5kRmlyc3RDaGlsZApGaXJlU2VydmVyBmFjdGlvbgVJc0N1dAxHZXRBdHRyaWJ1dGUHRW5hYmxlZAxwcmVVcGRhdGVGdW4GUmVtb3ZlA25ldwxzZXRtZXRhdGFibGUKQXR0YWNobWVudAlWYWxpZFJvb3QETmFtZQVOb1JheQVUaW1lZAhEdXJhdGlvbgREaXN0CENhbGxiYWNrDFByZVVwZGF0ZUZ1bg9QcmVVcGRhdGVQZXJpb2QQcHJvbXB0QXR0YWNobWVudAVCcmVhawNBZGQEbWFpZAhHaXZlVGFzawRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNTdGQKQmFzZU9iamVjdA5NYW5pZmVzdEJpbmRlcgJVSQZNb2R1bGUMQ2lyY2xlQWN0aW9uB19faW5kZXgNQ3V0dGFibGVHbGFzcw5ob2xlQXR0YWNobWVudARIb2xlBlByb21wdAAFBQIBAAAADA4BCgD7AgAAbwQAALwCAgMBAAAAnwIDArwDAmsCAAAAnwMCAakDAQCCAwIAggABAAMDAQMCAwMADwQBGAABAAAAAAEAAAEAAhAAAAAABQEBAAAADPsCAABvBAAAvAICEgEAAACfAgMCKgICAAAAAACpAQABqQEBADABAPACAAAAggABAAMDBQMGAwcAFggBGAAAAAAAAAAAAAAAARcAAAAAAgACAAAABvsAAABNAABpAAAAAPsBAQCfAAIBggABAAEDCQAmAAEYAAAAAAABJwAAAAAJAgMAAAA8+wIAAE0CAu8AAAAAUgMAAJ8CAgL7BQEAnj0CBAUAAABSBAIApAMCAAAAEECfAwMB2QMAABIAAADZBAEAEgAAAOIFDQBNBgESDgAAADAGBQ0DAAAAMAAFSQQAAABvBg8AMAYFugUAAACpBgEAMAYFtgYAAACpBgEAMAYFcQcAAABvBhAAMAYF5QgAAACMBggAMAYF4wkAAAAwAwVGCgAAADAEBaMLAAAAbwYQADAGBUQMAAAA+wYCAE0GBl8RAAAAUgcFAFIIAACfBgMBTQYCFhIAAADZCAIAEgICABIAAAC8Bgb9EwAAAJ8GAwGCAgIAFAMKAwsEAAAQQAMMAw0DDgMPAxADEQMSAxMDFAMVBQoDBAUGBwgJCgsMAxYDFwIAAAAAAADgPwMYAxkDGgMAAQILCgEYAAAAAAABAAAAAAAAAgAHAAMBAAAAAQABAAABAAABAAABAAABAAABAAEAAQAAAgAAAAAAAQAAAAAAAAAEDAAAAAAKAAABAgA6owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgJLBwAAAJ8BAgKkAgUAAABAQE0DAIkIAAAAnwICAqQDBQAAAEBATQUAQAoAAABNBAVcCQAAAJ8DAgJNBAPdCwAAAP8FAgAAAAAAMAUFbgwAAACePQUFAQAAAFIHBQBSCAEApAYOAAAA0ECfBgMBwAYPABIAAQASAAUAEgAEADAGBe8QAAAATQYC7xAAAABvBxEA4ggUAG8JFQAwCQiCEgAAAG8JFgAwCQgSEwAAAFIJBQCfBgQAggYAABcDGwQAAABAAxwDHQMeBAAAQEADHwMgAyEDIgMjAyQDJQMLBAAA0EAGAwMKAyYDJwMWBQISEwMoAykBAwEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAQAAAAAAAAEAAgABAAEAAAAAAAACAAAAAAAiAAAAAQAAAQAAAf0AAQAAAAAExXQw1cAFeo/F6zEGt23kELVsJ6H3sFrU

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:01
-- Luau version 6, Types version 3
-- Time taken: 0.002743 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.new(arg1, arg2) -- Line 11
    --[[ Upvalues[3]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: CircleAction_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    local tbl = {
        Attachment = arg2.promptAttachment;
    }
    tbl.ValidRoot = arg1
    tbl.Name = "Break"
    tbl.NoRay = true
    tbl.Timed = true
    tbl.Duration = 0.5
    tbl.Dist = 8
    function tbl.Callback(arg1_2, arg2_2) -- Line 15, Named "action"
        --[[ Upvalues[1]:
            [1]: arg1 (readonly)
        ]]
        if arg2_2 then
            arg1:FindFirstChild("CutRemote"):FireServer()
            return true
        end
    end
    function tbl.PreUpdateFun(arg1_3) -- Line 22, Named "preUpdateFun"
        --[[ Upvalues[1]:
            [1]: arg1 (readonly)
        ]]
        local var6
        if arg1:GetAttribute("IsCut") ~= false then
            var6 = false
        else
            var6 = true
        end
        arg1_3.Enabled = var6
    end
    tbl.PreUpdatePeriod = 0.5
    CircleAction_upvr.Add(tbl, arg1)
    any_new_result1.maid:GiveTask(function() -- Line 38
        --[[ Upvalues[2]:
            [1]: CircleAction_upvr (copied, readonly)
            [2]: arg1 (readonly)
        ]]
        CircleAction_upvr.Remove(arg1)
    end)
    return any_new_result1
end
return require(ReplicatedStorage.ManifestBinder).new("CuttableGlass", {
    holeAttachment = "Hole";
    promptAttachment = "Prompt";
}, module_upvr)