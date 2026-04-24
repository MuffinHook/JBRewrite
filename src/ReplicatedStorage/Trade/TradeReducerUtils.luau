-- Reviewed by Claude
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
local function getVehicleDataForMake(p1)
	for i, v in ipairs(VehicleData) do
		if v.Make == p1 then
			return v
		end
	end
end
local ItemSkinList = require(ReplicatedStorage.Game.ItemSkin.ItemSkinList)
local String = require(ReplicatedStorage.Std.String)
local function getItemSkinForName(p1)
	for i, v in ipairs(ItemSkinList) do
		if v.Name == p1 then
			return v
		end
	end
end
local t = {
	buildItemProps = function(p1)
		local v1 = nil
		local v2 = PopularSort.getRaw()
		local v3 = TradePopularSortData.getPopularTradeItemData() or {}
		local v4 = ItemUtils.getFullNameFromTable(p1)
		local v5 = getViewportProps(p1)
		if p1.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
			local CategoryName = p1.CategoryName
			local ItemName = p1.ItemName
			local v6 = StoreData.GetItemByName(CategoryName, ItemName)
			if v6 and typeof(v6) == "table" then
				if v6.NoTrade then
					return
				end
				local v7 = ItemUtils.getTranslatedTitleFromItemTable(p1)
				v1 = {
					salesIndex = v2[CategoryName] and v2[CategoryName][ItemName],
					categoryName = CategoryName,
					categoryTitle = GarageTranslationUtils.getCategoryTitle(CategoryName),
					title = v7,
					price = v6.Price,
					level = v6.Level,
					season = v6.Season,
					topPct = v6.TopPct,
					vip = v6.VIP,
					getInst = v5.getInst,
					getInstCompare = v5.getInstCompare,
					updateCamera = v5.updateCamera
				}
			else
				warn("Missing vehCust for: " .. CategoryName .. "/" .. ItemName)
				return
			end
		elseif p1.ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
			local Make = p1.Make
			local v10 = nil
			for i, v in ipairs(VehicleData) do
				if v.Make == Make then
					v10 = v
					break
				end
			end
			if v10 then
				if v10.NoTrade then
					return
				end
				v1 = {
					salesIndex = v2.Vehicles[Make],
					categoryTitle = "Vehicle",
					title = ItemUtils.getTranslatedTitleFromItemTable(p1),
					season = v10.Season,
					level = v10.Level,
					vip = v10.VIP,
					topPct = v10.TopPct,
					getInst = v5.getInst,
					getInstCompare = v5.getInstCompare,
					updateCamera = v5.updateCamera
				}
			else
				warn("Missing vehicleConf for: " .. Make)
				return
			end
		elseif p1.ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
			local ItemName = p1.ItemName
			local v11 = ReplicatedStorage.Resource.HomeItem:FindFirstChild(ItemName)
			if v11 then
				if v11:FindFirstChild("NoTrade") then
					return
				end
				local Level = v11:FindFirstChild("Level")
				local Season = v11:FindFirstChild("Season")
				local TopPct = v11:FindFirstChild("TopPct")
				local t = {
					title = ItemUtils.getTranslatedTitleFromItemTable(p1),
					categoryTitle = "Furniture"
				}
				t.level = if Level == nil then nil else Level.Value or nil
				t.season = if Season == nil then nil else Season.Value or nil
				t.topPct = if TopPct == nil then nil else TopPct.Value or nil
				t.getInst = v5.getInst
				t.getInstCompare = v5.getInstCompare
				t.updateCamera = v5.updateCamera
				v1 = t
			else
				warn("Missing homeItemModel for: " .. ItemName)
				return
			end
		elseif p1.ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
			local SkinName = p1.SkinName
			local v15 = nil
			for i, v in ipairs(ItemSkinList) do
				if v.Name == SkinName then
					v15 = v
					break
				end
			end
			if v15 then
				if v15.NoTrade then
					return
				end
				v1 = {
					title = ItemUtils.getTranslatedTitleFromItemTable(p1),
					categoryTitle = "Item Skin",
					season = v15.Season,
					level = v15.Level,
					vip = v15.VIP,
					topPct = v15.TopPct,
					getInst = v5.getInst,
					getInstCompare = v5.getInstCompare,
					updateCamera = v5.updateCamera
				}
			else
				return
			end
		elseif p1.ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
			v1 = {
				title = ItemUtils.getTranslatedTitleFromItemTable(p1),
				categoryTitle = "Safe",
				image = v5.image,
				getInstCompare = v5.getInstCompare
			}
		elseif p1.ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
			v1 = {
				title = ItemUtils.getTranslatedTitleFromItemTable(p1),
				categoryTitle = "Consumable",
				image = v5.image,
				getInstCompare = v5.getInstCompare
			}
		else
			error("Unsupported ItemType", p1.ItemType)
		end
		if p1.Id then
			v1.id = p1.Id
		end
		v1.itemType = assert(p1.ItemType, "missing ItemType")
		v1.info = {}
		local v16 = false
		if p1.History then
			local UserId = p1.History[1].UserId
			local UserId_2 = p1.History[#p1.History].UserId
			if UserId and UserId_2 then
				v16 = UserId == UserId_2
			end
		end
		v1.isOriginalOwner = v16
		local v17 = v3[v4]
		v1.uniqueCirculation = if v17 then v17.UniqueCirculation else 0
		v1.timesTraded = if v17 then v17.TimesTraded else 0
		if v1.uniqueCirculation > 0 then
			v1.tradePopularMetric = v1.timesTraded / v1.uniqueCirculation
		end
		table.insert(v1.info, {
			title = "Monthly Traded",
			value = String.comma(v1.timesTraded)
		})
		table.insert(v1.info, {
			title = "Monthly Unique",
			value = String.comma(v1.uniqueCirculation)
		})
		if p1.History then
			local UserId = p1.History[1].UserId
			local t3 = {
				title = "Original Owner",
				value = tostring(UserId)
			}
			table.insert(v1.info, t3)
			if UserId then
				PlayerUtils.promiseNameFromUserId(UserId):andThen(function(p1)
					t3.value = p1
				end):catch(warn)
			end
		end
		if p1.CreationTime then
			table.insert(v1.info, {
				title = "Created At",
				value = DateTime.fromUnixTimestamp(p1.CreationTime):FormatLocalTime("ll", "en-us")
			})
		end
		return v1
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
function t.update(p1, p2)
	local v1 = if p2.reset == true then t.getDefaults() else table.clone(p1)
	if p2.userId ~= nil then
		v1.userId = p2.userId
	end
	if p2.displayName ~= nil then
		v1.displayName = p2.displayName
	end
	if p2.ready ~= nil then
		v1.ready = p2.ready
	end
	if p2.accepted ~= nil then
		v1.accepted = p2.accepted
	end
	if p2.itemsOwnedOffering ~= nil then
		local t2 = {}
		for i, v in ipairs(p2.itemsOwnedOffering) do
			local v4 = t.buildItemProps(v)
			if v4 then
				table.insert(t2, v4)
			end
		end
		v1.offerItems = t2
	end
	return v1
end
function t.addItem(p1, p2)
	local item = p2.item
	assert(item ~= nil, "missing item")
	local v2 = false
	for i, v in ipairs(p1.offerItems) do
		if v.id == item.id then
			v2 = true
			break
		end
	end
	if v2 then
		return p1
	else
		local v3 = table.clone(p1)
		table.insert(v3.offerItems, item)
		return v3
	end
end
function t.removeItem(p1, p2)
	local item = p2.item
	assert(item ~= nil, "missing item")
	for i = #p1.offerItems, 1, -1 do
		if p1.offerItems[i].id == item.id then
			local v2 = table.clone(p1)
			table.remove(v2.offerItems, i)
			return v2
		end
	end
	return p1
end
function t.removeItemByIndex(p1, p2)
	assert(p2.index ~= nil, "missing item id")
	local v2 = table.clone(p1)
	table.remove(v2.offerItems, p2.index)
	return v2
end
return t
