local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players_upvr = game:GetService("Players")
local TradeConsts_upvr = require(ReplicatedStorage.Trade.TradeConsts)
local module_2 = {
    setPlayerTradeRequestsEnabled = function(arg1, arg2) -- Line 9, Named "setPlayerTradeRequestsEnabled"
        local var5
        if arg1.Parent ~= Players_upvr then
            var5 = false
        else
            var5 = true
        end
        assert(var5, "Incorrect player passed")
        if typeof(arg2) ~= "boolean" then
            var5 = false
        else
            var5 = true
        end
        assert(var5, "Incorrect value passed")
        arg1:SetAttribute(TradeConsts_upvr.ARE_TRADE_REQUESTS_ENABLED_ATTR_NAME, arg2)
        return true
    end;
    getPlayerTradeRequestsEnabled = function(arg1) -- Line 15, Named "getPlayerTradeRequestsEnabled"
        local var6
        if arg1.Parent ~= Players_upvr then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "Incorrect player passed")
        return arg1:GetAttribute(TradeConsts_upvr.ARE_TRADE_REQUESTS_ENABLED_ATTR_NAME)
    end;
}
local PlayerDataConsts_upvr = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local OwnershipConsts_upvr = require(ReplicatedStorage.Ownership.OwnershipConsts)
local TradeTranslationUtils_upvr = require(script.Parent.TradeTranslationUtils)
function module_2.getCategories() -- Line 19
    local module = {}
    for i in pairs(PlayerDataConsts_upvr.ITEM_TYPE_SET) do
        local var20
        if i == PlayerDataConsts_upvr.VEHICLE_ITEM_TYPE then
            var20 = 100
        elseif i == PlayerDataConsts_upvr.HOME_ITEM_ITEM_TYPE then
            var20 = 200
        elseif i == PlayerDataConsts_upvr.ITEM_SKIN_ITEM_TYPE then
            var20 = 300
        elseif i == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
            var20 = 400
        end
        if i == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
            for i_2, v in ipairs(OwnershipConsts_upvr.VEHICLE_CUSTOMIZATION_CATEGORY_NAMES) do
                if not TradeConsts_upvr.MAP_CATEGORY_IGNORE[v] then
                    table.insert(module, {
                        categoryName = v;
                        categoryTitle = TradeTranslationUtils_upvr.getCategoryTitle(v);
                        match = {
                            itemType = i;
                            categoryName = v;
                        };
                        sortOrder = var20;
                    })
                    var20 += 1
                end
            end
        elseif not TradeConsts_upvr.MAP_CATEGORY_IGNORE[i] then
            i_2 = {}
            local var26 = i_2
            var26.categoryName = i
            var26.categoryTitle = TradeTranslationUtils_upvr.getCategoryTitle(i)
            v = {}
            local var27 = v
            var27.itemType = i
            var26.match = var27
            var26.sortOrder = var20
            table.insert(module, var26)
        end
    end
    table.sort(module, function(arg1, arg2) -- Line 67
        local var29
        if arg1.sortOrder >= arg2.sortOrder then
            var29 = false
        else
            var29 = true
        end
        return var29
    end)
    return module
end
return module_2