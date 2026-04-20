local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HyperChromeConsts_upvr = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local module_upvr_2 = {
    getName = function(arg1, arg2) -- Line 7, Named "getName"
        return HyperChromeConsts_upvr.HYPERCHROME_PREFIX..arg1..HyperChromeConsts_upvr.LEVEL_PREFIX..arg2
    end;
    getItemGroupName = function(arg1) -- Line 10, Named "getItemGroupName"
        return HyperChromeConsts_upvr.HYPERCHROME_PREFIX..arg1
    end;
    getLevelFromName = function(arg1) -- Line 13, Named "getLevelFromName"
        return tonumber(string.match(arg1, HyperChromeConsts_upvr.LEVEL_PREFIX.."(.*)"))
    end;
}
local function getColorFromName(arg1) -- Line 16
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
    return var18_upvr
end
for _, v_3 in var18_upvr do
    ({
        [HyperChromeConsts_upvr.COLOR_SHIFT_NAME] = true;
    })[v_3] = true
    local var22_upvr
end
function module_upvr_2.isHyperChromeName(arg1) -- Line 47
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
    if arg1.ItemType == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE and arg1.CategoryName == "Color" and module_upvr_2.isHyperChromeName(arg1.ItemName) then
        return true
    end
    return false
end
function module_upvr_2.getColors() -- Line 62
    return module_upvr
end
return module_upvr_2