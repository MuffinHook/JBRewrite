-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:45
-- Luau version 6, Types version 3
-- Time taken: 0.003361 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryConsts_upvr = require(script.Parent.InventoryConsts)
local InventoryBinder_upvr = require(script.Parent.InventoryBinder)
local module = {}
local InventoryItemSystem_upvr = require(script.Parent.InventoryItemSystem)
function module.init() -- Line 13
    --[[ Upvalues[2]:
        [1]: InventoryBinder_upvr (readonly)
        [2]: InventoryItemSystem_upvr (readonly)
    ]]
    InventoryBinder_upvr:Start()
    InventoryItemSystem_upvr.init()
end
function module.getFor(arg1) -- Line 17
    --[[ Upvalues[2]:
        [1]: InventoryConsts_upvr (readonly)
        [2]: InventoryBinder_upvr (readonly)
    ]]
    local SOME = arg1:FindFirstChild(InventoryConsts_upvr.CURRENT_INVENTORY_VALUE_NAME)
    if not SOME then
    elseif SOME.Value then
        return InventoryBinder_upvr:Get(SOME.Value)
    end
end
local waitForChild_upvr = require(ReplicatedStorage.Std.waitForChild)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local BinderUtils_upvr = require(ReplicatedStorage.Std.Binder.BinderUtils)
function module.promiseFor(arg1) -- Line 26
    --[[ Upvalues[7]:
        [1]: waitForChild_upvr (readonly)
        [2]: InventoryConsts_upvr (readonly)
        [3]: Maid_upvr (readonly)
        [4]: Promise_upvr (readonly)
        [5]: RxInstanceUtils_upvr (readonly)
        [6]: BinderUtils_upvr (readonly)
        [7]: InventoryBinder_upvr (readonly)
    ]]
    return waitForChild_upvr(arg1, InventoryConsts_upvr.CURRENT_INVENTORY_VALUE_NAME):andThen(function(arg1_2) -- Line 27
        --[[ Upvalues[5]:
            [1]: Maid_upvr (copied, readonly)
            [2]: Promise_upvr (copied, readonly)
            [3]: RxInstanceUtils_upvr (copied, readonly)
            [4]: BinderUtils_upvr (copied, readonly)
            [5]: InventoryBinder_upvr (copied, readonly)
        ]]
        local any_new_result1_upvr = Maid_upvr.new()
        local any_new_result1 = Promise_upvr.new(function(arg1_3, arg2) -- Line 29
            --[[ Upvalues[5]:
                [1]: any_new_result1_upvr (readonly)
                [2]: RxInstanceUtils_upvr (copied, readonly)
                [3]: arg1_2 (readonly)
                [4]: BinderUtils_upvr (copied, readonly)
                [5]: InventoryBinder_upvr (copied, readonly)
            ]]
            any_new_result1_upvr:GiveTask(RxInstanceUtils_upvr.observeProperty(arg1_2, "Value", function(arg1_4) -- Line 30
                --[[ Upvalues[4]:
                    [1]: arg1_3 (readonly)
                    [2]: BinderUtils_upvr (copied, readonly)
                    [3]: InventoryBinder_upvr (copied, readonly)
                    [4]: arg2 (readonly)
                ]]
                if arg1_4 then
                    arg1_3(BinderUtils_upvr.promiseBoundClass(InventoryBinder_upvr, arg1_4))
                else
                    arg2()
                end
            end))
        end)
        any_new_result1:finally(function() -- Line 38
            --[[ Upvalues[1]:
                [1]: any_new_result1_upvr (readonly)
            ]]
            any_new_result1_upvr:Destroy()
        end)
        return any_new_result1
    end)
end
return module