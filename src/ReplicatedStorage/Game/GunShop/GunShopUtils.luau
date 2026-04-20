local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemDataUtils_upvr = require(ReplicatedStorage.App.ItemDataUtils)
local module_upvr = {
    mapCategoryData = {};
    allData = {};
    takesAmmo = {};
}
for _, v in ipairs(script.Parent.Data:GetChildren()) do
    module_upvr.mapCategoryData[v.Name] = require(v)
end
for _, v_2 in pairs(module_upvr.mapCategoryData) do
    for _, v_3 in ipairs(v_2) do
        table.insert(module_upvr.allData, v_3)
        if v_3.For then
            module_upvr.takesAmmo[v_3.For] = true
        end
    end
end
function module_upvr.getCategoryData(arg1) -- Line 24
    local var25 = module_upvr.mapCategoryData[arg1]
    if not var25 then
        error("No data exists for category: %s":format(arg1))
    end
    return var25
end
function module_upvr.getAllData() -- Line 31
    return module_upvr.allData
end
function module_upvr.doesTakeAmmo(arg1) -- Line 34
    return module_upvr.takesAmmo[arg1]
end
function module_upvr.getDamage(arg1, arg2) -- Line 37
    local any_getConfig_result1 = ItemDataUtils_upvr.getConfig(arg1)
    if not any_getConfig_result1 then
        return nil
    end
    if any_getConfig_result1.DamageFun then
        return any_getConfig_result1.DamageFun(arg2)
    end
    return assert(any_getConfig_result1.Damage)
end
function module_upvr.getMaxTotalAmmoForItem(arg1) -- Line 50
    if module_upvr.doesTakeAmmo(arg1) then
        return ItemDataUtils_upvr.getConfig(arg1).MagSize
    end
    return nil
end
local Localization_upvr = require(ReplicatedStorage.Module.Localization)
function module_upvr.getTranslatedTitleFromName(arg1) -- Line 57
    local any_AttemptFormatByKey_result1, any_AttemptFormatByKey_result2 = Localization_upvr:AttemptFormatByKey("Item2."..arg1)
    local var30
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var30 = any_AttemptFormatByKey_result2
        return var30
    end
    if not any_AttemptFormatByKey_result1 or not decompInlinedCondition() then
        var30 = arg1
    end
    return var30
end
return module_upvr