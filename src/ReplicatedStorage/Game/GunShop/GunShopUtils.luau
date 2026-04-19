-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:58
-- Luau version 6, Types version 3
-- Time taken: 0.004650 seconds

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
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local var25 = module_upvr.mapCategoryData[arg1]
    if not var25 then
        error("No data exists for category: %s":format(arg1))
    end
    return var25
end
function module_upvr.getAllData() -- Line 31
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr.allData
end
function module_upvr.doesTakeAmmo(arg1) -- Line 34
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr.takesAmmo[arg1]
end
function module_upvr.getDamage(arg1, arg2) -- Line 37
    --[[ Upvalues[1]:
        [1]: ItemDataUtils_upvr (readonly)
    ]]
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
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: ItemDataUtils_upvr (readonly)
    ]]
    if module_upvr.doesTakeAmmo(arg1) then
        return ItemDataUtils_upvr.getConfig(arg1).MagSize
    end
    return nil
end
local Localization_upvr = require(ReplicatedStorage.Module.Localization)
function module_upvr.getTranslatedTitleFromName(arg1) -- Line 57
    --[[ Upvalues[1]:
        [1]: Localization_upvr (readonly)
    ]]
    local any_AttemptFormatByKey_result1, any_AttemptFormatByKey_result2 = Localization_upvr:AttemptFormatByKey("Item2."..arg1)
    local var30
    local function INLINED() -- Internal function, doesn't exist in bytecode
        var30 = any_AttemptFormatByKey_result2
        return var30
    end
    if not any_AttemptFormatByKey_result1 or not INLINED() then
        var30 = arg1
    end
    return var30
end
return module_upvr