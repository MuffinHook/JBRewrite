local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")
local GarageItemUtils = require(script.Parent.GarageItemUtils)
local GarageUtils = require(script.Parent.GarageUtils)
local ItemUtils = require(ReplicatedStorage.App.ItemUtils)
local Rodux = require(ReplicatedStorage.Rodux)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local SortUtils = require(script.Parent.SortUtils)
local PopularSort = require(script.Parent.PopularSort)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local GarageConsts = require(ReplicatedStorage.Game.Garage.GarageConsts)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Customize = require(ReplicatedStorage.Game.Garage.Customize)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local VehicleConf = require(ReplicatedStorage.Game.Garage.VehicleConf)
local SaleConsts = require(ReplicatedStorage.Sale.SaleConsts)
local SaleShared = require(ReplicatedStorage.Sale.SaleShared)
local CreatorValues = require(ReplicatedStorage.Trade.CreatorValues)
local function updateVehicleCamera(camera, model)
	local rotationTime = os.clock() / 2
	camera.CFrame = CFrame.Angles(0, rotationTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(rotationTime * 0.5) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, model.BoundingBox.Size.Magnitude * 0.8)
end
local function cleanup(vehicleData)
	if vehicleData.inst then
		vehicleData.inst:Destroy()
		vehicleData.inst = nil
	end
	vehicleData.updateCamera = nil
end
local function setPageSpawn(vehicles, sortOptions)
	local spawnItems = {}
	for i, vehicle in ipairs(vehicles) do
		if vehicle.inst then
			vehicle.inst:Destroy()
			vehicle.inst = nil
		end
		vehicle.updateCamera = nil
	end
	local popularData = PopularSort.getRaw()
	for i = 1, #VehicleData do
		local offSalePrice, vehicleConfig
		local vehicleDataEntry = VehicleData[i]
		if not (vehicleDataEntry.NoGarageUI or vehicleDataEntry.NoMainWorldGarageSpawn and RunUtils.isMainWorld() or vehicleDataEntry.NoTradeWorldGarageSpawn and RunUtils.isTradeWorld()) then
			local salesIndex = popularData.Vehicles[vehicleDataEntry.Make]
			if vehicleDataEntry.Make == "Camaro" then
				salesIndex = 0
			end
			local vehicleItemTable = ItemUtils.createVehicleItemTable(vehicleDataEntry.Make)
			local fullItemName = ItemUtils.getFullNameFromTable(vehicleItemTable)
			local Price = vehicleDataEntry.Price
			if SaleShared.isVehicleOnSale(vehicleDataEntry.Make) then
				salesIndex, offSalePrice, Price = -i, Price, math.floor(Price * SaleConsts.VEHICLE_PRICE_MULTIPLIER)
			else
				offSalePrice = nil
			end
			local vehicleItem = {
				primaryIndex = i,
				salesIndex = salesIndex,
				vehicleType = vehicleDataEntry.Type,
				vehicleMake = vehicleDataEntry.Make,
				hiddenAll = vehicleDataEntry.HiddenAll,
				limited = GarageUtils.isVehicleLimited(vehicleDataEntry)
			}
			vehicleItem.lite = vehicleDataEntry.Lite or SaleShared.isVehicleOnSale(vehicleDataEntry.Make)
			vehicleItem.name = vehicleDataEntry.Make
			vehicleItem.title = ItemUtils.getTranslatedTitleFromItemTable(vehicleItemTable)
			vehicleItem.offSalePrice = offSalePrice
			vehicleItem.price = Price
			vehicleItem.level = vehicleDataEntry.Level
			vehicleItem.season = vehicleDataEntry.Season
			function vehicleItem.getInst()
				return getDefaultVehicleModel(vehicleDataEntry.Make, vehicleDataEntry.Type)
			end
			vehicleItem.updateCamera = updateVehicleCamera
			vehicleItem.creatorName = CreatorValues[fullItemName] and CreatorValues[fullItemName].CreatorName
			vehicleItem.aerialOnly = vehicleDataEntry.AerialSpawn
			if vehicleDataEntry.NoMainWorldGarageSpawn then
				vehicleConfig = not RunUtils.isMainWorld()
				if vehicleConfig then
					vehicleConfig = if vehicleDataEntry.NoTradeWorldGarageSpawn then not RunUtils.isTradeWorld() and not vehicleItem.limited else not vehicleItem.limited
				end
			else
				vehicleConfig = if vehicleDataEntry.NoTradeWorldGarageSpawn then not RunUtils.isTradeWorld() and not vehicleItem.limited else not vehicleItem.limited
			end
			vehicleItem.available = vehicleConfig
			table.insert(spawnItems, vehicleItem)
		end
	end
	if sortOptions.sortId then
		table.sort(spawnItems, SortUtils.getSortFunc(sortOptions.sortId))
	end
	return spawnItems
end
local function setCategory(items, categoryOptions)
	assert(categoryOptions.categoryName ~= nil, "missing category Name")
	for i, item in ipairs(items) do
		if item.inst then
			item.inst:Destroy()
			item.inst = nil
		end
		item.updateCamera = nil
	end
	local categoryName = categoryOptions.categoryName
	local categoryData = StoreData.GetCategoryByName(categoryName)
	local categoryItems = {}
	local playerVehiclePacket = VehicleUtils.GetLocalVehiclePacket()
	local popularData = PopularSort.getRaw()
	local categoryReference
	for itemIndex, itemEntry in if categoryData.GetItems then categoryData.GetItems() else categoryData.Items do
		local onItemSelectedCallback, isItemValid
		local itemCategoryName = itemEntry.CategoryName or categoryName
		categoryReference = if itemCategoryName == categoryName then categoryData else StoreData.GetCategoryByName(itemCategoryName)
		local isItemEligible = not itemEntry.NoGarageUI
		if playerVehiclePacket then
			if itemEntry.Makes and not itemEntry.Makes[playerVehiclePacket.Make] then
				isItemEligible = false
			end
			if categoryData.IsValidForMake and not categoryData.IsValidForMake(itemEntry) then
				isItemEligible = false
			end
			local categoryValidator = VehicleConf.MAP_CATEGORY_TO_FUNC[itemCategoryName]
			if categoryValidator and not categoryValidator(playerVehiclePacket) then
				isItemEligible = false
			end
		end
		if isItemEligible then
			local itemName = itemEntry.Name
			local itemPopularityIndex = popularData[itemCategoryName] and popularData[itemCategoryName][itemName]
			local customizationItemData = GarageItemUtils.getVehicleCustomizationItemOwned(itemCategoryName, itemName)
			local Price = itemEntry.Price
			if SaleShared.isVehicleCustomizationOnSale(itemCategoryName, itemName) then
				itemPopularityIndex, onItemSelectedCallback, Price = -itemIndex, Price, math.floor(Price * SaleConsts.VEHICLE_CUSTOMIZATION_PRICE_MULTIPLIER)
			else
				onItemSelectedCallback = nil
			end
			if itemEntry.FakeLimited then
				itemPopularityIndex = -itemIndex
			end
			local customizationFullName = ItemUtils.getFullNameFromTable(customizationItemData)
			local customizationTitle = ItemUtils.getTranslatedTitleFromItemTable(customizationItemData)
			local customizationItem = {
				id = customizationFullName,
				primaryIndex = itemIndex,
				salesIndex = itemPopularityIndex,
				name = itemEntry.Name,
				title = customizationTitle,
				offSalePrice = onItemSelectedCallback,
				price = Price,
				hiddenAll = itemEntry.HiddenAll,
				limited = GarageUtils.isVehicleCustomizationLimited(itemEntry),
				isNone = itemEntry.None,
				level = itemEntry.Level,
				season = itemEntry.Season,
				topPct = itemEntry.TopPct,
				vip = itemEntry.VIP,
				categoryName = itemCategoryName,
				getInst = function()
					return categoryReference.GetInstance(itemEntry)
				end,
				updateCamera = categoryReference.Update
			}
			isItemValid = if categoryReference.onItemSelected == nil then false else function()
		return categoryReference.onItemSelected(itemEntry)
	end
			customizationItem.onItemSelected = isItemValid
			customizationItem.creatorName = CreatorValues[customizationFullName] and CreatorValues[customizationFullName].CreatorName
			customizationItem.fakeLimited = itemEntry.FakeLimited
			customizationItem.available = not customizationItem.limited
			table.insert(categoryItems, customizationItem)
		end
	end
	if categoryOptions.sortId then
		table.sort(categoryItems, SortUtils.getSortFunc(categoryOptions.sortId))
	end
	return categoryItems
end
local function setPageSaves()
	local saveSlots = {}
	for i = 1, GarageConsts.NUM_SAVE_SLOTS do
		local isVipSlot
		local saveSlot = {
			name = "s" .. i,
			title = ("Save #%d"):format(i)
		}
		isVipSlot = GarageConsts.NUM_FREE_SAVE_SLOTS < i
		saveSlot.vip = isVipSlot
		saveSlot.available = true
		function saveSlot.getInstForSelection(selectionData)
			local playerVehicle = VehicleUtils.GetLocalVehiclePacket()
			local vehicleModel = getDefaultVehicleModel(playerVehicle.Make, playerVehicle.Type)
			local mapData = StoreData.GetMapFromSelection(selectionData)
			Customize.ApplyAll(mapData, {
				Model = vehicleModel,
				Make = playerVehicle.Make,
				Type = playerVehicle.Type
			}, selectionData)
			return vehicleModel
		end
		saveSlot.updateCamera = updateVehicleCamera
		table.insert(saveSlots, saveSlot)
	end
	return saveSlots
end
return Rodux.createReducer({}, {
	setCategory = function(items, categoryOptions)
		return setCategory(items, categoryOptions)
	end,
	setSaveSlot = function()
		return setPageSaves()
	end,
	setPage = function(items, pageOptions)
		local pageName = pageOptions.pageName
		if pageName == "Spawn" then
			return setPageSpawn(items, pageOptions)
		end
		if pageName == "Customize" then
			return setCategory(items, pageOptions)
		end
		if pageName == "Saves" then
			return setPageSaves()
		end
		error("Page not handled by itemsReducer")
	end,
	setSort = function(items, sortOptions)
		assert(sortOptions.id ~= nil, "missing sort id")
		local sortedItems = {}
		for i = 1, #items do
			table.insert(sortedItems, items[i])
		end
		table.sort(sortedItems, SortUtils.getSortFunc(sortOptions.id))
		return sortedItems
	end
})
