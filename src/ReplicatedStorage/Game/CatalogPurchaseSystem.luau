local Players_upvr = game:GetService("Players")
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local function catalogPurchase_upvr(arg1, arg2) -- Line 10, Named "catalogPurchase"
    local any_new_result1 = Maid_upvr.new()
    local tbl = {}
    tbl.Part = arg1
    tbl.Timed = false
    tbl.Name = "Buy %s":format(arg2.displayNameObj.Value)
    tbl.Dist = 16
    function tbl.Callback(arg1_2, arg2_2) -- Line 12, Named "action"
        if arg2_2 then
            MarketplaceService_upvr:PromptPurchase(Players_upvr.LocalPlayer, arg2.assetIdObj.Value, true)
        end
        return true
    end
    CircleAction_upvr.Add(tbl, arg1)
    any_new_result1:GiveTask(function() -- Line 26
        CircleAction_upvr.Remove(arg1)
    end)
    return any_new_result1
end
local module = {}
local ManifestBinder_upvr = require(ReplicatedStorage.ManifestBinder)
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
function module.init() -- Line 33
    ManifestBinder_upvr.new("CatalogPurchase", {
        assetIdObj = "AssetId";
        displayNameObj = "DisplayName";
    }, catalogPurchase_upvr):Start()
    MarketplaceService_upvr.PromptPurchaseFinished:Connect(function(arg1, arg2, arg3) -- Line 40
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