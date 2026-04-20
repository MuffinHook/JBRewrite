local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RewardSpinnerConsts_upvr = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local String_upvr = require(ReplicatedStorage.Std.String)
local TradeReducerUtils_upvr = require(ReplicatedStorage.Trade.TradeReducerUtils)
return function(arg1) -- Line 7
    local module = {}
    if arg1.RarityId then
        local var7 = RewardSpinnerConsts_upvr.RARITY_ID_TO_RARITY[arg1.RarityId]
        if not var7 then
            error("Invalid item rarity: "..tostring(arg1.RarityId))
        end
        module.rarityIndex = var7.index
        local len = #RewardSpinnerConsts_upvr.RARITIES
        module.rarityTitle = var7.name
        module.bubbleColor = var7.color
        if var7.index == len then
            module.backGlowEnabled = true
        elseif len - 2 <= var7.index then
            module.frontGlowEnabled = true
        end
    end
    if arg1.ImageId then
        module.image = "rbxassetid://"..tostring(arg1.ImageId)
    end
    local var9
    if arg1.Type == "Cash" then
        module.typeTitle = "Cash"
        if 0 < arg1.Amount then
            var9 = '+'
        else
            var9 = ""
        end
        module.title = var9..'$'..String_upvr.comma(arg1.Amount)
        return module
    end
    if arg1.Type == "Nitro" then
        module.typeTitle = "Nitro"
        if 0 < arg1.Amount then
            var9 = '+'
        else
            var9 = ""
        end
        module.title = var9..String_upvr.comma(arg1.Amount)
        return module
    end
    if arg1.Type == "HyperChrome" then
        module.typeTitle = "Color"
        module.title = "HyperChrome!"
        var9 = "Level "
        module.subTitle = var9..tostring(arg1.Level)
        return module
    end
    if arg1.Type == "UniqueItem" then
        var9 = arg1
        local any_buildItemProps_result1 = TradeReducerUtils_upvr.buildItemProps(var9)
        if not any_buildItemProps_result1 then
            var9 = print
            var9(arg1)
            var9 = error
            var9("No item props found for rewardData ^")
        end
        var9 = any_buildItemProps_result1.title
        module.title = var9
        var9 = any_buildItemProps_result1.categoryTitle
        module.typeTitle = var9
        var9 = any_buildItemProps_result1.getInst
        module.getInst = var9
        var9 = any_buildItemProps_result1.getInstCompare
        module.getInstCompare = var9
        var9 = any_buildItemProps_result1.updateCamera
        module.updateCamera = var9
        var9 = any_buildItemProps_result1.image
        module.image = var9
    end
    return module
end