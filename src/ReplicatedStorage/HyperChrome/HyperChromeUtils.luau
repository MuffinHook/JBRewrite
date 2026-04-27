local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local HyperChromeUtils = {
	getName = function(colorName, levelNumber)
		return HyperChromeConsts.HYPERCHROME_PREFIX .. colorName .. HyperChromeConsts.LEVEL_PREFIX .. levelNumber
	end,
	getItemGroupName = function(colorName)
		return HyperChromeConsts.HYPERCHROME_PREFIX .. colorName
	end,
	getLevelFromName = function(itemName)
		local match = string.match
		return tonumber(match(itemName, HyperChromeConsts.LEVEL_PREFIX .. "(.*)"))
	end,
	getColorFromName = function(itemName)
		return string.match(itemName, HyperChromeConsts.HYPERCHROME_PREFIX .. "(.*)" .. HyperChromeConsts.LEVEL_PREFIX)
	end
}
local MAX_LEVEL = HyperChromeConsts.MAX_LEVEL
local allHyperChromeNames = {}
local colorSet = {}
local colorList = {}
for colorName, colorInfo in HyperChromeConsts.COLOR_TO_INFO_MAP do
	for i = 1, MAX_LEVEL do
		table.insert(allHyperChromeNames, (HyperChromeUtils.getName(colorName, i)))
		colorSet[colorName] = true
	end
end
for color, colorIsValid in colorSet do
	table.insert(colorList, color)
end
function HyperChromeUtils.getListOfHyperChromeNames()
	return allHyperChromeNames
end
local hyperChromeNameLookup = {
	[HyperChromeConsts.COLOR_SHIFT_NAME] = true
}
for index, hyperChromeName in allHyperChromeNames do
	hyperChromeNameLookup[hyperChromeName] = true
end
function HyperChromeUtils.isHyperChromeName(itemName)
	return hyperChromeNameLookup[itemName] == true
end
function HyperChromeUtils.isHyperChromeItem(itemData)
	return itemData.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE and (itemData.CategoryName == "Color" and HyperChromeUtils.isHyperChromeName(itemData.ItemName)) and true or false
end
function HyperChromeUtils.getColors()
	return colorList
end
return HyperChromeUtils
