local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local t = {
	getName = function(p1, p2) --[[ Name: getName | Line: 7 | Upvalues: HyperChromeConsts (copy) ]]
		return HyperChromeConsts.HYPERCHROME_PREFIX .. p1 .. HyperChromeConsts.LEVEL_PREFIX .. p2
	end,
	getItemGroupName = function(p1) --[[ Name: getItemGroupName | Line: 10 | Upvalues: HyperChromeConsts (copy) ]]
		return HyperChromeConsts.HYPERCHROME_PREFIX .. p1
	end,
	getLevelFromName = function(p1) --[[ Name: getLevelFromName | Line: 13 | Upvalues: HyperChromeConsts (copy) ]]
		local match = string.match
		return tonumber(match(p1, HyperChromeConsts.LEVEL_PREFIX .. "(.*)"))
	end,
	getColorFromName = function(p1) --[[ Name: getColorFromName | Line: 16 | Upvalues: HyperChromeConsts (copy) ]]
		return string.match(p1, HyperChromeConsts.HYPERCHROME_PREFIX .. "(.*)" .. HyperChromeConsts.LEVEL_PREFIX)
	end
}
local MAX_LEVEL = HyperChromeConsts.MAX_LEVEL
local t2 = {}
local t3 = {}
local t4 = {}
for v1, v2 in HyperChromeConsts.COLOR_TO_INFO_MAP do
	for i = 1, MAX_LEVEL do
		table.insert(t2, (t.getName(v1, i)))
		t3[v1] = true
	end
end
for v4, v5 in t3 do
	table.insert(t4, v4)
end
function t.getListOfHyperChromeNames() --[[ Line: 38 | Upvalues: t2 (copy) ]]
	return t2
end
local t5 = {
	[HyperChromeConsts.COLOR_SHIFT_NAME] = true
}
for v6, v7 in t2 do
	t5[v7] = true
end
function t.isHyperChromeName(p1) --[[ Line: 47 | Upvalues: t5 (copy) ]]
	return t5[p1] == true
end
function t.isHyperChromeItem(p1) --[[ Line: 53 | Upvalues: PlayerDataConsts (copy), t (copy) ]]
	return p1.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE and (p1.CategoryName == "Color" and t.isHyperChromeName(p1.ItemName)) and true or false
end
function t.getColors() --[[ Line: 62 | Upvalues: t4 (copy) ]]
	return t4
end
return t