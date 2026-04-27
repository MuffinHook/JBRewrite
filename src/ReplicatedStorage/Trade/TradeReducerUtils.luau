local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TradePopularSortData = require(script.Parent.TradePopularSortData)
local ItemUtils = require(ReplicatedStorage.App.ItemUtils)
local GarageTranslationUtils = require(ReplicatedStorage.Garage.GarageTranslationUtils)
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local SAFE_DATA = require(ReplicatedStorage.Safes.SafesConsts).SAFE_DATA
local PopularSort = require(ReplicatedStorage.Garage.PopularSort)
local PlayerUtils = require(ReplicatedStorage.Std.PlayerUtils)
local getViewportProps = require(ReplicatedStorage.App.getViewportProps)
local function getVehicleDataForMake(make)
	for i, vehicleData in ipairs(VehicleData) do
		if vehicleData.Make == make then
			return vehicleData
		end
	end
end
local ItemSkinList = require(ReplicatedStorage.Game.ItemSkin.ItemSkinList)
local String = require(ReplicatedStorage.Std.String)
local function getItemSkinForName(skinName)
	for i, skinData in ipairs(ItemSkinList) do
		if skinData.Name == skinName then
			return skinData
		end
	end
end
local tradeReducerUtils = {
	buildItemProps = function(item)
		local itemProps = nil
		local popularSortData = PopularSort.getRaw()
		local tradePopularData = TradePopularSortData.getPopularTradeItemData() or {}
		local itemFullName = ItemUtils.getFullNameFromTable(item)
		local viewportProps = getViewportProps(item)
		if item.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
			local CategoryName = item.CategoryName
			local ItemName = item.ItemName
			local itemStoreData = StoreData.GetItemByName(CategoryName, ItemName)
			if itemStoreData and typeof(itemStoreData) == "table" then
				if itemStoreData.NoTrade then
					return
				end
				local translatedTitle = ItemUtils.getTranslatedTitleFromItemTable(item)
				itemProps = {
					salesIndex = popularSortData[CategoryName] and popularSortData[CategoryName][ItemName],
					categoryName = CategoryName,
					categoryTitle = GarageTranslationUtils.getCategoryTitle(CategoryName),
					title = translatedTitle,
					price = itemStoreData.Price,
					level = itemStoreData.Level,
					season = itemStoreData.Season,
					topPct = itemStoreData.TopPct,
					vip = itemStoreData.VIP,
					getInst = viewportProps.getInst,
					getInstCompare = viewportProps.getInstCompare,
					updateCamera = viewportProps.updateCamera
				}
			else
				warn("Missing vehCust for: " .. CategoryName .. "/" .. ItemName)
				return
			end
		elseif item.ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
			local Make = item.Make
			local vehicleData = nil
			for i, vehicle in ipairs(VehicleData) do
				if vehicle.Make == Make then
					vehicleData = vehicle
					break
				end
			end
			if vehicleData then
				if vehicleData.NoTrade then
					return
				end
				itemProps = {
					salesIndex = popularSortData.Vehicles[Make],
					categoryTitle = "Vehicle",
					title = ItemUtils.getTranslatedTitleFromItemTable(item),
					season = vehicleData.Season,
					level = vehicleData.Level,
					vip = vehicleData.VIP,
					topPct = vehicleData.TopPct,
					getInst = viewportProps.getInst,
					getInstCompare = viewportProps.getInstCompare,
					updateCamera = viewportProps.updateCamera
				}
			else
				warn("Missing vehicleConf for: " .. Make)
				return
			end
		elseif item.ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
			local ItemName = item.ItemName
			local homeItemResource = ReplicatedStorage.Resource.HomeItem:FindFirstChild(ItemName)
			if homeItemResource then
				if homeItemResource:FindFirstChild("NoTrade") then
					return
				end
				local Level = homeItemResource:FindFirstChild("Level")
				local Season = homeItemResource:FindFirstChild("Season")
				local TopPct = homeItemResource:FindFirstChild("TopPct")
				local homeItemProps = {
					title = ItemUtils.getTranslatedTitleFromItemTable(item),
					categoryTitle = "Furniture"
				}
				homeItemProps.level = if Level == nil then nil else Level.Value or nil
				homeItemProps.season = if Season == nil then nil else Season.Value or nil
				homeItemProps.topPct = if TopPct == nil then nil else TopPct.Value or nil
				homeItemProps.getInst = viewportProps.getInst
				homeItemProps.getInstCompare = viewportProps.getInstCompare
				homeItemProps.updateCamera = viewportProps.updateCamera
				itemProps = homeItemProps
			else
				warn("Missing homeItemModel for: " .. ItemName)
				return
			end
		elseif item.ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
			local SkinName = item.SkinName
			local skinData = nil
			for i, skin in ipairs(ItemSkinList) do
				if skin.Name == SkinName then
					skinData = skin
					break
				end
			end
			if skinData then
				if skinData.NoTrade then
					return
				end
				itemProps = {
					title = ItemUtils.getTranslatedTitleFromItemTable(item),
					categoryTitle = "Item Skin",
					season = skinData.Season,
					level = skinData.Level,
					vip = skinData.VIP,
					topPct = skinData.TopPct,
					getInst = viewportProps.getInst,
					getInstCompare = viewportProps.getInstCompare,
					updateCamera = viewportProps.updateCamera
				}
			else
				return
			end
		elseif item.ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
			itemProps = {
				title = ItemUtils.getTranslatedTitleFromItemTable(item),
				categoryTitle = "Safe",
				image = viewportProps.image,
				getInstCompare = viewportProps.getInstCompare
			}
		elseif item.ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
			itemProps = {
				title = ItemUtils.getTranslatedTitleFromItemTable(item),
				categoryTitle = "Consumable",
				image = viewportProps.image,
				getInstCompare = viewportProps.getInstCompare
			}
		else
			error("Unsupported ItemType", item.ItemType)
		end
		if item.Id then
			itemProps.id = item.Id
		end
		itemProps.itemType = assert(item.ItemType, "missing ItemType")
		itemProps.info = {}
		local isOriginalOwner = false
		if item.History then
			local firstUserId = item.History[1].UserId
			local lastUserId = item.History[#item.History].UserId
			if firstUserId and lastUserId then
				isOriginalOwner = firstUserId == lastUserId
			end
		end
		itemProps.isOriginalOwner = isOriginalOwner
		local popularItemData = tradePopularData[itemFullName]
		itemProps.uniqueCirculation = if popularItemData then popularItemData.UniqueCirculation else 0
		itemProps.timesTraded = if popularItemData then popularItemData.TimesTraded else 0
		if itemProps.uniqueCirculation > 0 then
			itemProps.tradePopularMetric = itemProps.timesTraded / itemProps.uniqueCirculation
		end
		table.insert(itemProps.info, {
			title = "Monthly Traded",
			value = String.comma(itemProps.timesTraded)
		})
		table.insert(itemProps.info, {
			title = "Monthly Unique",
			value = String.comma(itemProps.uniqueCirculation)
		})
		if item.History then
			local firstOwnerId = item.History[1].UserId
			local ownerInfoEntry = {
				title = "Original Owner",
				value = tostring(firstOwnerId)
			}
			table.insert(itemProps.info, ownerInfoEntry)
			if firstOwnerId then
				PlayerUtils.promiseNameFromUserId(firstOwnerId):andThen(function(ownerName)
					ownerInfoEntry.value = ownerName
				end):catch(warn)
			end
		end
		if item.CreationTime then
			table.insert(itemProps.info, {
				title = "Created At",
				value = DateTime.fromUnixTimestamp(item.CreationTime):FormatLocalTime("ll", "en-us")
			})
		end
		return itemProps
	end,
	getDefaults = function()
		return {
			userId = nil,
			displayName = nil,
			ready = false,
			accepted = false,
			offerItems = {}
		}
	end
}
function tradeReducerUtils.update(currentTrader, updateAction)
	local updatedTrader = if updateAction.reset == true then tradeReducerUtils.getDefaults() else table.clone(currentTrader)
	if updateAction.userId ~= nil then
		updatedTrader.userId = updateAction.userId
	end
	if updateAction.displayName ~= nil then
		updatedTrader.displayName = updateAction.displayName
	end
	if updateAction.ready ~= nil then
		updatedTrader.ready = updateAction.ready
	end
	if updateAction.accepted ~= nil then
		updatedTrader.accepted = updateAction.accepted
	end
	if updateAction.itemsOwnedOffering ~= nil then
		local processedItems = {}
		for i, itemData in ipairs(updateAction.itemsOwnedOffering) do
			local builtItemProps = tradeReducerUtils.buildItemProps(itemData)
			if builtItemProps then
				table.insert(processedItems, builtItemProps)
			end
		end
		updatedTrader.offerItems = processedItems
	end
	return updatedTrader
end
function tradeReducerUtils.addItem(currentTrader, action)
	local item = action.item
	assert(item ~= nil, "missing item")
	local itemExists = false
	for i, existingItem in ipairs(currentTrader.offerItems) do
		if existingItem.id == item.id then
			itemExists = true
			break
		end
	end
	if itemExists then
		return currentTrader
	else
		local updatedTrader = table.clone(currentTrader)
		table.insert(updatedTrader.offerItems, item)
		return updatedTrader
	end
end
function tradeReducerUtils.removeItem(currentTrader, action)
	local item = action.item
	assert(item ~= nil, "missing item")
	for i = #currentTrader.offerItems, 1, -1 do
		if currentTrader.offerItems[i].id == item.id then
			local updatedTrader = table.clone(currentTrader)
			table.remove(updatedTrader.offerItems, i)
			return updatedTrader
		end
	end
	return currentTrader
end
function tradeReducerUtils.removeItemByIndex(currentTrader, action)
	assert(action.index ~= nil, "missing item id")
	local updatedTrader = table.clone(currentTrader)
	table.remove(updatedTrader.offerItems, action.index)
	return updatedTrader
end
return tradeReducerUtils
