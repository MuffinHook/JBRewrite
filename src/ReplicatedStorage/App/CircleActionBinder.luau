-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMrFENpcmNsZUFjdGlvbkRpc2FibGVkDEdldEF0dHJpYnV0ZQdFbmFibGVkFENpcmNsZUFjdGlvbkR1cmF0aW9uCER1cmF0aW9uBVRpbWVkCmdldFRhZ1BhcnQFTW9kZWwDSXNBCVZhbGlkUm9vdARQYXJ0EENpcmNsZUFjdGlvblRleHQETmFtZRBDaXJjbGVBY3Rpb25EaXN0BERpc3QMcHJlVXBkYXRlRnVuCkZpcmVTZXJ2ZXINcHJlc3NDYWxsYmFjawNuZXcMc2V0bWV0YXRhYmxlD09uUHJlc3NlZFJlbW90ZQxXYWl0Rm9yQ2hpbGQIQ2FsbGJhY2sMUHJlVXBkYXRlRnVuD1ByZVVwZGF0ZVBlcmlvZBFbIyMjIE1JU1NJTkcgIyMjXQRtYWlkDENpcmNsZUFjdGlvbgNBZGQIR2l2ZVRhc2sEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudBFDaXJjbGVBY3Rpb25VdGlscwNTdGQKQmFzZU9iamVjdAZCaW5kZXIGTW9kdWxlAlVJB19faW5kZXgABAYBAgAAAEH7AwAAbwUAALwDAxIBAAAAnwMDAioDAgABAAAAqQIAAakCAQBWAQIAMAEA8AIAAAD7AgAAbwQEALwCAhIBAAAAnwIDApABAgMwAQDlBQAAAE0CAOUFAAAAbwMGALcDAgACAAAAqQEAAakBAQAwAQBxBwAAAPsBAQBNAQG6CAAAAPsCAACfAQIC+wIAAG8ECQC8AgL+CgAAAJ8CAwIOAgMA+wIAADACAEkLAAAAMAEARAwAAAD7AgAAbwQNALwCAhIBAAAAnwIDAisCAwD7AgAATQICug4AAAAwAgC6DgAAAPsDAABvBRAAvAMDEgEAAACfAwMCkAIDDzACAOMRAAAAggABABIDAQMCAwMCAAAAAAAAAAADBAMFAvyp8dJNYlA/AwYDBwMIAwkDCgMLAwwDDQIAAAAAAAAkQAMOAw8AEhABGAAAAAAAAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAAAAgAAAAABAAAAAAABAAACAAEAAAAAAAAAAAAAAQAAAAAAAAABEwAAAAAFAgEAAAAH+wIAAFIEAQC8AgJrAAAAAJ8CAwGpAgEAggICAAEDEQAfEgEYAAAAAAABACAAAAAACwEEAAAAN/sBAABNAQHvAAAAAFICAACfAQIC+wQBAJ49AQQEAAAAUgMBAKQCAgAAABBAnwIDAW8EAwC8AgDTBAAAAJ8CAwLZAwAAEgAAABICAgDZBAEAEgACAOIFDABvBg0AMAYFugUAAACpBgAAMAYFcQYAAACMBgAAMAYF4wcAAAAwBAVGCAAAAKkGAQAwBgXwCQAAADADBaMKAAAAbwYOADAGBUQLAAAATQYBFg8AAAD7CAMATQgI3RAAAABNCAhfEQAAAFIJBQBSCgAAnwgDALwGBv0SAAAAnwYAAYIBAgATAxMDFAQAABBAAxUDFgMNAwYDDwMXAwMDGAMZBQcFBgcICQoLAxoCmpmZmZmZyT8DGwMcAx0DHgIAAQwTARgAAAAAAAEAAAAAAAACAAAAAgAADQAEAQAAAQAAAQAAAQABAAABAAEAAAMAAAAAAAAAAAAAAAACDQAAAAAJAAABAgA9owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBApAIHAAAAYEBNAgIkCAAAAE0CAvcJAAAAnwECAqQCBQAAAEBATQMAoQoAAABNAwNLCwAAAJ8CAgKkAwUAAABAQE0EAKEKAAAATQQEfwwAAACfAwICpAQFAAAAQEBNBQBADQAAAE0FBVwOAAAAnwQCAv8FAgAAAAAAMAUFbg8AAACePQUFAgAAAFIHBQBSCAIApAYRAAAAAEGfBgMBwAYSABIAAgASAAUAEgABABIABAAwBgXvEwAAAE0GA+8TAAAAbwcUAFIIBQCfBgMAggYAABUDHwQAAABAAyADIQMiBAAAQEADIwQAAGBAAyQDJQMmAycDKAMpAyoDKwMUBAAAAEEGAgMTAxwBAgEAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAEAAAAAAAACAAAAAAAAAgABAAEAAAAAAAACAAAAAAAAJgAAAAAAAQAAAAADPrwHWEB7cKFOIiHp5LmJBU6kECwMeG1Z

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:14
-- Luau version 6, Types version 3
-- Time taken: 0.003111 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local CircleActionUtils_upvr = require(script.Parent.CircleActionUtils)
local UI_upvr = require(ReplicatedStorage.Module.UI)
function module_upvr.new(arg1) -- Line 12
    --[[ Upvalues[4]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: CircleActionUtils_upvr (readonly)
        [4]: UI_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    local OnPressedRemote_upvr = arg1:WaitForChild("OnPressedRemote")
    any_new_result1.maid:GiveTask(UI_upvr.CircleAction.Add({
        Name = "[### MISSING ###]";
        Timed = false;
        Dist = 0;
        Callback = function(arg1_3, arg2) -- Line 31, Named "pressCallback"
            --[[ Upvalues[1]:
                [1]: OnPressedRemote_upvr (readonly)
            ]]
            OnPressedRemote_upvr:FireServer(arg2)
            return true
        end;
        Enabled = true;
        PreUpdateFun = function(arg1_2) -- Line 18, Named "preUpdateFun"
            --[[ Upvalues[2]:
                [1]: arg1 (readonly)
                [2]: CircleActionUtils_upvr (copied, readonly)
            ]]
            -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
            local var7
            if arg1:GetAttribute("CircleActionDisabled") ~= true then
                var7 = false
            else
                var7 = true
            end
            arg1_2.Enabled = not var7
            var7 = arg1:GetAttribute("CircleActionDuration")
            arg1_2.Duration = var7 or 0
            var7 = arg1_2.Duration
            if 0.001 >= var7 then
            else
            end
            arg1_2.Timed = true
            var7 = arg1
            var7 = arg1:IsA("Model")
            if var7 then
                var7 = arg1
                arg1_2.ValidRoot = var7
            end
            arg1_2.Part = CircleActionUtils_upvr.getTagPart(var7)
            var7 = arg1:GetAttribute("CircleActionText")
            if not var7 then
                var7 = arg1
                var7 = var7.Name
            end
            arg1_2.Name = var7
            arg1_2.Dist = arg1:GetAttribute("CircleActionDist") or 10
        end;
        PreUpdatePeriod = 0.2;
    }, arg1))
    return any_new_result1
end
return require(ReplicatedStorage.Std.Binder).new("CircleAction", module_upvr)