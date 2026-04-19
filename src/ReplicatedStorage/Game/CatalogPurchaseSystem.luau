-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:10
-- Luau version 6, Types version 3
-- Time taken: 0.002443 seconds

local Players_upvr = game:GetService("Players")
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local function catalogPurchase_upvr(arg1, arg2) -- Line 10, Named "catalogPurchase"
    --[[ Upvalues[4]:
        [1]: Maid_upvr (readonly)
        [2]: MarketplaceService_upvr (readonly)
        [3]: Players_upvr (readonly)
        [4]: CircleAction_upvr (readonly)
    ]]
    local any_new_result1 = Maid_upvr.new()
    local tbl = {}
    tbl.Part = arg1
    tbl.Timed = false
    tbl.Name = "Buy %s":format(arg2.displayNameObj.Value)
    tbl.Dist = 16
    function tbl.Callback(arg1_2, arg2_2) -- Line 12, Named "action"
        --[[ Upvalues[3]:
            [1]: MarketplaceService_upvr (copied, readonly)
            [2]: Players_upvr (copied, readonly)
            [3]: arg2 (readonly)
        ]]
        if arg2_2 then
            MarketplaceService_upvr:PromptPurchase(Players_upvr.LocalPlayer, arg2.assetIdObj.Value, true)
        end
        return true
    end
    CircleAction_upvr.Add(tbl, arg1)
    any_new_result1:GiveTask(function() -- Line 26
        --[[ Upvalues[2]:
            [1]: CircleAction_upvr (copied, readonly)
            [2]: arg1 (readonly)
        ]]
        CircleAction_upvr.Remove(arg1)
    end)
    return any_new_result1
end
local module = {}
local ManifestBinder_upvr = require(ReplicatedStorage.ManifestBinder)
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
function module.init() -- Line 33
    --[[ Upvalues[5]:
        [1]: ManifestBinder_upvr (readonly)
        [2]: catalogPurchase_upvr (readonly)
        [3]: MarketplaceService_upvr (readonly)
        [4]: Players_upvr (readonly)
        [5]: Notification_upvr (readonly)
    ]]
    ManifestBinder_upvr.new("CatalogPurchase", {
        assetIdObj = "AssetId";
        displayNameObj = "DisplayName";
    }, catalogPurchase_upvr):Start()
    MarketplaceService_upvr.PromptPurchaseFinished:Connect(function(arg1, arg2, arg3) -- Line 40
        --[[ Upvalues[2]:
            [1]: Players_upvr (copied, readonly)
            [2]: Notification_upvr (copied, readonly)
        ]]
        if arg1 ~= Players_upvr.LocalPlayer then
        else
            if not arg3 then return end
            Notification_upvr.new({
                Text = "Go to the Roblox avatar editor to wear this item!";
            })
        end
    end)
end
return module