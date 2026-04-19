-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:37
-- Luau version 6, Types version 3
-- Time taken: 0.003963 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HyperChromeConsts_upvr = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local module_upvr_2 = {
    getName = function(arg1, arg2) -- Line 7, Named "getName"
        --[[ Upvalues[1]:
            [1]: HyperChromeConsts_upvr (readonly)
        ]]
        return HyperChromeConsts_upvr.HYPERCHROME_PREFIX..arg1..HyperChromeConsts_upvr.LEVEL_PREFIX..arg2
    end;
    getItemGroupName = function(arg1) -- Line 10, Named "getItemGroupName"
        --[[ Upvalues[1]:
            [1]: HyperChromeConsts_upvr (readonly)
        ]]
        return HyperChromeConsts_upvr.HYPERCHROME_PREFIX..arg1
    end;
    getLevelFromName = function(arg1) -- Line 13, Named "getLevelFromName"
        --[[ Upvalues[1]:
            [1]: HyperChromeConsts_upvr (readonly)
        ]]
        return tonumber(string.match(arg1, HyperChromeConsts_upvr.LEVEL_PREFIX.."(.*)"))
    end;
}
local function getColorFromName(arg1) -- Line 16
    --[[ Upvalues[1]:
        [1]: HyperChromeConsts_upvr (readonly)
    ]]
    return string.match(arg1, HyperChromeConsts_upvr.HYPERCHROME_PREFIX.."(.*)"..HyperChromeConsts_upvr.LEVEL_PREFIX)
end
module_upvr_2.getColorFromName = getColorFromName
getColorFromName = {}
local var18_upvr = getColorFromName
local tbl = {}
local module_upvr = {}
for i, _ in HyperChromeConsts_upvr.COLOR_TO_INFO_MAP do
    for i_2 = 1, HyperChromeConsts_upvr.MAX_LEVEL do
        table.insert(var18_upvr, module_upvr_2.getName(i, i_2))
        tbl[i] = true
    end
end
for i_3, _ in tbl do
    table.insert(module_upvr, i_3)
end
function module_upvr_2.getListOfHyperChromeNames() -- Line 38
    --[[ Upvalues[1]:
        [1]: var18_upvr (readonly)
    ]]
    return var18_upvr
end
for _, v_3 in var18_upvr do
    ({
        [HyperChromeConsts_upvr.COLOR_SHIFT_NAME] = true;
    })[v_3] = true
    local var22_upvr
end
function module_upvr_2.isHyperChromeName(arg1) -- Line 47
    --[[ Upvalues[1]:
        [1]: var22_upvr (readonly)
    ]]
    local var23
    if var22_upvr[arg1] ~= true then
        var23 = false
    else
        var23 = true
    end
    return var23
end
local PlayerDataConsts_upvr = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
function module_upvr_2.isHyperChromeItem(arg1) -- Line 53
    --[[ Upvalues[2]:
        [1]: PlayerDataConsts_upvr (readonly)
        [2]: module_upvr_2 (readonly)
    ]]
    if arg1.ItemType == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE and arg1.CategoryName == "Color" and module_upvr_2.isHyperChromeName(arg1.ItemName) then
        return true
    end
    return false
end
function module_upvr_2.getColors() -- Line 62
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr
end
return module_upvr_2