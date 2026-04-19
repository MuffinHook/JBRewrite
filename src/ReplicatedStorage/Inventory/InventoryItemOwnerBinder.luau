-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:43
-- Luau version 6, Types version 3
-- Time taken: 0.002743 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_upvr.new(arg1) -- Line 12
    --[[ Upvalues[4]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: Signal_upvr (readonly)
        [4]: RxInstanceUtils_upvr (readonly)
    ]]
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.Name = arg1.Name
    any_new_result1_upvr._onCharacterChanged = Signal_upvr.new()
    if not arg1.Value then
    else
        any_new_result1_upvr.maid.observeChar = RxInstanceUtils_upvr.observeProperty(arg1.Value, "PrimaryPart", function(arg1_3) -- Line 23
            --[[ Upvalues[2]:
                [1]: any_new_result1_upvr (readonly)
                [2]: arg1 (readonly)
            ]]
            task.wait()
            if arg1_3 then
                any_new_result1_upvr.Character = arg1.Value
            else
                any_new_result1_upvr.Character = nil
            end
            any_new_result1_upvr._onCharacterChanged:Fire(any_new_result1_upvr.Character)
        end)
    end
    any_new_result1_upvr.maid:GiveTask(arg1.Changed:Connect(function() -- Line 19, Named "update"
        --[[ Upvalues[3]:
            [1]: arg1 (readonly)
            [2]: any_new_result1_upvr (readonly)
            [3]: RxInstanceUtils_upvr (copied, readonly)
        ]]
        if not arg1.Value then
        else
            any_new_result1_upvr.maid.observeChar = RxInstanceUtils_upvr.observeProperty(arg1.Value, "PrimaryPart", function(arg1_2) -- Line 23
                --[[ Upvalues[2]:
                    [1]: any_new_result1_upvr (copied, readonly)
                    [2]: arg1 (copied, readonly)
                ]]
                task.wait()
                if arg1_2 then
                    any_new_result1_upvr.Character = arg1.Value
                else
                    any_new_result1_upvr.Character = nil
                end
                any_new_result1_upvr._onCharacterChanged:Fire(any_new_result1_upvr.Character)
            end)
        end
    end))
    return any_new_result1_upvr
end
function module_upvr.GetAttribute(arg1, arg2) -- Line 38
    return arg1["attr"..tostring(arg2)]
end
function module_upvr.SetAttribute(arg1, arg2, arg3) -- Line 41
    arg1["attr"..tostring(arg2)] = arg3
end
return require(ReplicatedStorage.Std.Binder).new("InventoryItemOwner", module_upvr)