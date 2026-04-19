-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:38
-- Luau version 6, Types version 3
-- Time taken: 0.002814 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local SafesConsts_upvr = require(ReplicatedStorage_upvr.Safes.SafesConsts)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Players_upvr = game:GetService("Players")
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local CashBuyUI_upvr = require(ReplicatedStorage_upvr.Game.CashBuyUI)
function module.init(arg1) -- Line 11
    --[[ Upvalues[7]:
        [1]: waitForChild_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: SafesConsts_upvr (readonly)
        [4]: Audio_upvr (readonly)
        [5]: Players_upvr (readonly)
        [6]: store_upvr (readonly)
        [7]: CashBuyUI_upvr (readonly)
    ]]
    local em_upvr = arg1.em
    waitForChild_upvr(ReplicatedStorage_upvr, SafesConsts_upvr.FIREWORK_FX_REMOTE_NAME):andThen(function(arg1_2) -- Line 13
        --[[ Upvalues[1]:
            [1]: em_upvr (readonly)
        ]]
        arg1_2.OnClientEvent:Connect(function() -- Line 14
            --[[ Upvalues[1]:
                [1]: em_upvr (copied, readonly)
            ]]
            em_upvr.at2y4lws(10)
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, SafesConsts_upvr.SAFE_PURCHASE_REMOTE_NAME):andThen(function(arg1_3) -- Line 19
        --[[ Upvalues[4]:
            [1]: Audio_upvr (copied, readonly)
            [2]: Players_upvr (copied, readonly)
            [3]: store_upvr (copied, readonly)
            [4]: CashBuyUI_upvr (copied, readonly)
        ]]
        arg1_3.OnClientEvent:Connect(function(arg1_4) -- Line 20
            --[[ Upvalues[4]:
                [1]: Audio_upvr (copied, readonly)
                [2]: Players_upvr (copied, readonly)
                [3]: store_upvr (copied, readonly)
                [4]: CashBuyUI_upvr (copied, readonly)
            ]]
            if arg1_4 then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer, 4977134975, {
                    Volume = 0.3;
                })
            else
                store_upvr:dispatch({
                    type = "setSafesOpen";
                    value = false;
                })
                CashBuyUI_upvr.Open()
            end
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, SafesConsts_upvr.UPDATE_SAFES_INVENTORY_REMOTE_NAME):andThen(function(arg1_5) -- Line 35
        --[[ Upvalues[1]:
            [1]: store_upvr (copied, readonly)
        ]]
        arg1_5.OnClientEvent:Connect(function(arg1_6) -- Line 36
            --[[ Upvalues[1]:
                [1]: store_upvr (copied, readonly)
            ]]
            local tbl = {
                type = "setSafesInventoryItems";
            }
            tbl.itemsOwned = arg1_6
            store_upvr:dispatch(tbl)
        end)
    end)
end
return module