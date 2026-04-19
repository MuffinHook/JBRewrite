-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:12
-- Luau version 6, Types version 3
-- Time taken: 0.002596 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CartBinder_upvr = require(script.Parent.CartBinder)
local module = {}
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local CartConsts_upvr = require(script.Parent.CartConsts)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module.init() -- Line 11
    --[[ Upvalues[4]:
        [1]: CartBinder_upvr (readonly)
        [2]: RxInstanceUtils_upvr (readonly)
        [3]: CartConsts_upvr (readonly)
        [4]: CircleAction_upvr (readonly)
    ]]
    CartBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 12
        --[[ Upvalues[3]:
            [1]: RxInstanceUtils_upvr (copied, readonly)
            [2]: CartConsts_upvr (copied, readonly)
            [3]: CircleAction_upvr (copied, readonly)
        ]]
        local _obj_upvr = arg1._obj
        RxInstanceUtils_upvr.yieldForProperty(_obj_upvr, "PrimaryPart")
        local PrimaryPart_upvr = _obj_upvr.PrimaryPart
        CircleAction_upvr.Add({
            Part = PrimaryPart_upvr;
            ValidRoot = _obj_upvr;
            Name = "Sit";
            Timed = false;
            Dist = 16;
            PreUpdateFun = function(arg1_3) -- Line 23, Named "preUpdateFun"
                --[[ Upvalues[1]:
                    [1]: arg1 (readonly)
                ]]
                local var9
                if arg1:GetOccupant() ~= nil then
                    var9 = false
                else
                    var9 = true
                end
                arg1_3.Enabled = var9
            end;
            PreUpdatePeriod = 0.5;
            Callback = function(arg1_2, arg2) -- Line 16, Named "action"
                --[[ Upvalues[2]:
                    [1]: _obj_upvr (readonly)
                    [2]: CartConsts_upvr (copied, readonly)
                ]]
                if arg2 then
                    _obj_upvr:FindFirstChild(CartConsts_upvr.ATTEMPT_SIT_REMOTE_NAME):FireServer()
                    return true
                end
            end;
        }, PrimaryPart_upvr)
        arg1._maid:GiveTask(function() -- Line 38
            --[[ Upvalues[2]:
                [1]: CircleAction_upvr (copied, readonly)
                [2]: PrimaryPart_upvr (readonly)
            ]]
            CircleAction_upvr.Remove(PrimaryPart_upvr)
        end)
    end)
    CartBinder_upvr:Start()
end
function module.getCartForCharacter(arg1) -- Line 44
    --[[ Upvalues[1]:
        [1]: CartBinder_upvr (readonly)
    ]]
    assert(arg1:IsDescendantOf(workspace))
    for _, v in ipairs(CartBinder_upvr:GetAll()) do
        if v:GetOccupant() == arg1 then
            return v
        end
    end
end
return module