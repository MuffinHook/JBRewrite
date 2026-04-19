-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMbEEF0dGVtcHRCdXlSZW1vdGUORmluZEZpcnN0Q2hpbGQKRmlyZVNlcnZlcgZhY3Rpb24DbmV3BFBhcnQETmFtZQVOb1JheQVUaW1lZAREaXN0CENhbGxiYWNrA0J1eQNBZGQIR2l2ZVRhc2sMQ29tbWVyY2VOb2RlBVN0YXJ0BGluaXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUGTW9kdWxlAlVJDENpcmNsZUFjdGlvbgNTdGQGQmluZGVyBE1haWQABAUCAQAAAAsOAQkA+wIAAG8EAAC8AgIDAQAAAJ8CAwIOAgMAvAMCawIAAACfAwIBggABAAMDAQMCAwMADAQBGAABAAAAAAEBAAADDQAAAAAJAQIAAAAh+wEAAE0BAe8AAAAAnwEBAtkCAAASAAAA4gMHADAAA0QBAAAAbwQIADAEA7oCAAAAqQQBADAEA7YDAAAAqQQAADAEA3EEAAAAjAQMADAEA+MFAAAAMAIDRgYAAAD7BgEATQYGXwkAAABSBwMAUggAAJ8GAwC8BAH9CgAAAJ8EAAGCAQIACwMFAwYDBwMIAwkDCgMLBQYBAgMEBQYDDAMNAw4BAAkAARgAAAAAAgAJAQABAAABAAABAAABAAABAAIAAAAAAAAAAAEKAAAAAAMAAwAAAAz7AAAATQAA7wAAAABvAQEAwAICABICAQASAgIAnwADArwAABwDAAAAnwACAYIAAQAEAwUDDwYBAxABAQgRARgAAAAAAAAAABYAAAEJAAAAAAcAAAECACejAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgBABgAAAE0CAlwHAAAAnwECAk0CAd0IAAAApAMFAAAAQEBNBAChCQAAAE0EBH8KAAAAnwMCAqQEBQAAAEBATQUAoQkAAABNBQV2CwAAAJ8EAgL/BQEAAAAAAMAGDAASAAMAEgAEABIAAgAwBgUTDQAAAIIFAgAOAxIEAAAAQAMTAxQDFQQAAEBAAxYDFwMYAxkDGgMbBgIDEQECAQABGAAAAAAAAAABAAAAAAAAAQACAAAAAAAAAQAAAAAAAAEAAQAAAAAAGQEAAAAAA4uwfumJONB8Y2qqa37LHkn7qGmduXQU6A==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:17
-- Luau version 6, Types version 3
-- Time taken: 0.002761 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module.init() -- Line 8
    --[[ Upvalues[3]:
        [1]: Binder_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: CircleAction_upvr (readonly)
    ]]
    Binder_upvr.new("CommerceNode", function(arg1) -- Line 9
        --[[ Upvalues[2]:
            [1]: Maid_upvr (copied, readonly)
            [2]: CircleAction_upvr (copied, readonly)
        ]]
        local any_new_result1 = Maid_upvr.new()
        local tbl = {}
        tbl.Part = arg1
        tbl.Name = "Buy"
        tbl.NoRay = true
        tbl.Timed = false
        tbl.Dist = 12
        function tbl.Callback(arg1_2, arg2) -- Line 12, Named "action"
            --[[ Upvalues[1]:
                [1]: arg1 (readonly)
            ]]
            if arg2 then
                local AttemptBuyRemote_2 = arg1:FindFirstChild("AttemptBuyRemote")
                if AttemptBuyRemote_2 then
                    AttemptBuyRemote_2:FireServer()
                end
            end
        end
        any_new_result1:GiveTask(CircleAction_upvr.Add(tbl, arg1))
        return any_new_result1
    end):Start()
end
return module