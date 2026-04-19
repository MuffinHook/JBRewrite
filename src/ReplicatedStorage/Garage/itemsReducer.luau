local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GarageUtils = require(script.Parent.GarageUtils)
local ItemUtils = require(ReplicatedStorage.App.ItemUtils)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local SortUtils = require(script.Parent.SortUtils)
local PopularSort = require(script.Parent.PopularSort)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local SaleConsts = require(ReplicatedStorage.Sale.SaleConsts)
local SaleShared = require(ReplicatedStorage.Sale.SaleShared)
local CreatorValues = require(ReplicatedStorage.Trade.CreatorValues)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local VehicleConf = require(ReplicatedStorage.Game.Garage.VehicleConf)
local GarageItemUtils = require(script.Parent.GarageItemUtils)
local GarageConsts = require(ReplicatedStorage.Game.Garage.GarageConsts)
local Customize = require(ReplicatedStorage.Game.Garage.Customize)
local Rodux = require(ReplicatedStorage.Rodux)

local function updateVehicleCamera(cameraPart, item)
	local time = os.clock() / 2
	local rotationY = time % (-math.pi * 2)
	local tiltX = math.sin(time * 0.5) * 0.25 - 0.3
	local distance = item.BoundingBox.Size.Magnitude * 0.8

	cameraPart.CFrame =
		CFrame.Angles(0, rotationY, 0)
		* CFrame.Angles(tiltX, 0, 0)
		* CFrame.new(0, 0, distance)
end

local function cleanupExistingItems(items)
	for _, item in ipairs(items) do
		if item.inst then
			item.inst:Destroy()
			item.inst = nil
		end

		item.updateCamera = nil
	end
end

local function canShowVehicleInCurrentWorld(vehicleInfo)
	if vehicleInfo.NoMainWorldGarageSpawn and RunUtils.isMainWorld() then
		return false
	end

	if vehicleInfo.NoTradeWorldGarageSpawn and RunUtils.isTradeWorld() then
		return false
	end

	return true
end

local function buildSpawnPageItems(previousItems, action)
	cleanupExistingItems(previousItems)

	local items = {}

	for index = 1, #VehicleData do
		local vehicleInfo = VehicleData[index]

		if canShowVehicleInCurrentWorld(vehicleInfo) then
			local salesIndex = PopularSort.getRaw().Vehicles[vehicleInfo.Make]

			if vehicleInfo.Make == "Camaro" then
				salesIndex = 0
			end

			local vehicleItemTable = ItemUtils.createVehicleItemTable(vehicleInfo.Make)
			local fullName = ItemUtils.getFullNameFromTable(vehicleItemTable)

			local price = vehicleInfo.Price
			local offSalePrice

			if SaleShared.isVehicleOnSale(vehicleInfo.Make) then
				salesIndex = -index
				offSalePrice = price
				price = math.floor(price * SaleConsts.VEHICLE_PRICE_MULTIPLIER)
			end

			local entry = {
				primaryIndex = index,
				salesIndex = salesIndex,
				vehicleType = vehicleInfo.Type,
				vehicleMake = vehicleInfo.Make,
				hiddenAll = vehicleInfo.HiddenAll,
				limited = GarageUtils.isVehicleLimited(vehicleInfo),
				lite = vehicleInfo.Lite or SaleShared.isVehicleOnSale(vehicleInfo.Make),
				name = vehicleInfo.Make,
				title = ItemUtils.getTranslatedTitleFromItemTable(vehicleItemTable),
				offSalePrice = offSalePrice,
				price = price,
				level = vehicleInfo.Level,
				season = vehicleInfo.Season,
				getInst = function()
					return getDefaultVehicleModel(vehicleInfo.Make, vehicleInfo.Type)
				end,
				updateCamera = updateVehicleCamera,
				aerialOnly = vehicleInfo.AerialSpawn,
				available = true,
			}

			local creatorData = CreatorValues[fullName]
			if creatorData then
				entry.creatorName = creatorData.CreatorName
			end

			entry.available = not entry.limited

			table.insert(items, entry)
		end
	end

	if action.sortId then
		table.sort(items, SortUtils.getSortFunc(action.sortId))
	end

	return items
end

local function buildCustomizeCategoryItems(previousItems, action)
	assert(action.categoryName ~= nil, "missing category Name")

	cleanupExistingItems(previousItems)

	local categoryName = action.categoryName
	local categoryData = StoreData.GetCategoryByName(categoryName)
	local items = {}

	local localVehiclePacket = VehicleUtils.GetLocalVehiclePacket()
	local popularityData = PopularSort.getRaw()

	for itemIndex, itemData in ipairs(categoryData.Items) do
		local resolvedCategoryName = itemData.CategoryName or categoryName
		local resolvedCategoryData = categoryData

		if resolvedCategoryName ~= categoryName then
			resolvedCategoryData = StoreData.GetCategoryByName(resolvedCategoryName)
		end

		local shouldInclude = not itemData.NoGarageUI

		if localVehiclePacket then
			if itemData.Makes and not itemData.Makes[localVehiclePacket.Make] then
				shouldInclude = false
			end

			if categoryData.IsValidForMake and not categoryData.IsValidForMake(itemData) then
				shouldInclude = false
			end

			local validator = VehicleConf.MAP_CATEGORY_TO_FUNC[resolvedCategoryName]
			if validator and not validator(localVehiclePacket) then
				shouldInclude = false
			end
		end

		if shouldInclude then
			local itemName = itemData.Name
			local salesIndex = popularityData[resolvedCategoryName] and popularityData[resolvedCategoryName][itemName]
			local ownedItemTable = GarageItemUtils.getVehicleCustomizationItemOwned(resolvedCategoryName, itemName)

			local price = itemData.Price
			local offSalePrice

			if SaleShared.isVehicleCustomizationOnSale(resolvedCategoryName, itemName) then
				offSalePrice = price
				price = math.floor(price * SaleConsts.VEHICLE_CUSTOMIZATION_PRICE_MULTIPLIER)
				salesIndex = -itemIndex
			end

			if itemData.FakeLimited then
				salesIndex = -itemIndex
			end

			local fullName = ItemUtils.getFullNameFromTable(ownedItemTable)

			local entry = {
				id = fullName,
				primaryIndex = itemIndex,
				salesIndex = salesIndex,
				name = itemData.Name,
				title = ItemUtils.getTranslatedTitleFromItemTable(ownedItemTable),
				offSalePrice = offSalePrice,
				price = price,
				hiddenAll = itemData.HiddenAll,
				limited = GarageUtils.isVehicleCustomizationLimited(itemData),
				isNone = itemData.None,
				level = itemData.Level,
				season = itemData.Season,
				topPct = itemData.TopPct,
				vip = itemData.VIP,
				categoryName = resolvedCategoryName,
				getInst = function()
					return resolvedCategoryData.GetInstance(itemData)
				end,
				updateCamera = resolvedCategoryData.Update,
				fakeLimited = itemData.FakeLimited,
				available = true,
			}

			if resolvedCategoryData.onItemSelected then
				entry.onItemSelected = function()
					return resolvedCategoryData.onItemSelected(itemData)
				end
			end

			local creatorData = CreatorValues[fullName]
			if creatorData then
				entry.creatorName = creatorData.CreatorName
			end

			entry.available = not entry.limited

			table.insert(items, entry)
		end
	end

	if action.sortId then
		table.sort(items, SortUtils.getSortFunc(action.sortId))
	end

	return items
end

local function buildSaveSlotItems()
	local items = {}

	for slotIndex = 1, GarageConsts.NUM_SAVE_SLOTS do
		local entry = {
			name = "s" .. slotIndex,
			title = string.format("Save #%d", slotIndex),
			vip = GarageConsts.NUM_FREE_SAVE_SLOTS < slotIndex,
			available = true,
		}

		function entry.getInstForSelection(selection)
			local localVehiclePacket = VehicleUtils.GetLocalVehiclePacket()
			local model = getDefaultVehicleModel(localVehiclePacket.Make, localVehiclePacket.Type)

			Customize.ApplyAll(StoreData.GetMapFromSelection(selection), {
				Model = model,
				Make = localVehiclePacket.Make,
				Type = localVehiclePacket.Type,
			}, selection)

			return model
		end

		entry.updateCamera = updateVehicleCamera

		table.insert(items, entry)
	end

	return items
end

return Rodux.createReducer({}, {
	setCategory = function(state, action)
		return buildCustomizeCategoryItems(state, action)
	end,

	setSaveSlot = function()
		return buildSaveSlotItems()
	end,

	setPage = function(state, action)
		local pageName = action.pageName

		if pageName == "Spawn" then
			return buildSpawnPageItems(state, action)
		end

		if pageName == "Customize" then
			return buildCustomizeCategoryItems(state, action)
		end

		if pageName == "Saves" then
			return buildSaveSlotItems()
		end

		error("Page not handled by itemsReducer")
	end,

	setSort = function(state, action)
		assert(action.id ~= nil, "missing sort id")

		local sorted = {}

		for i = 1, #state do
			table.insert(sorted, state[i])
		end

		table.sort(sorted, SortUtils.getSortFunc(action.id))
		return sorted
	end,
})