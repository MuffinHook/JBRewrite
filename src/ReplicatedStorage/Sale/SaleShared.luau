local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleConf = require(ReplicatedStorage.Game.Garage.VehicleConf)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local SaleConsts = require(ReplicatedStorage.Sale.SaleConsts)
local SaleUtils = require(ReplicatedStorage.Sale.SaleUtils)
local GarageUtils = require(ReplicatedStorage.Garage.GarageUtils)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local Signal = require(ReplicatedStorage.Std.Signal)
local Interval = require(ReplicatedStorage.Std.Interval)
local SaleShared = {
	onSaleRefresh = Signal.new()
}
local lastKnownSaleTime = SaleUtils.getNextSaleTime()
Interval.every(1):Connect(function()
	local currentSaleTime = SaleUtils.getNextSaleTime()
	if lastKnownSaleTime + 0.01 < currentSaleTime then
		lastKnownSaleTime = currentSaleTime
		SaleShared.onSaleRefresh:Fire()
	end
end)
local function canVehicleCustomizationGoOnSale(vehicleCustomization)
	local isValidCustomization = not GarageUtils.isVehicleCustomizationLimited(vehicleCustomization)
	if isValidCustomization then
		isValidCustomization = not vehicleCustomization.None
		if isValidCustomization then
			isValidCustomization = if vehicleCustomization.Price and vehicleCustomization.Price < 1000000 then vehicleCustomization.Price > 0 else false
			if isValidCustomization then
				isValidCustomization = not vehicleCustomization.NoGarageUI
			end
		end
	end
	return isValidCustomization
end
local function canVehicleGoOnSale(vehicle)
	local isValidVehicle = not GarageUtils.isVehicleLimited(vehicle)
	if isValidVehicle then
		isValidVehicle = not vehicle.None
		if isValidVehicle then
			isValidVehicle = if vehicle.Price and vehicle.Price < 1000000 then vehicle.Price > 0 else false
			if isValidVehicle then
				isValidVehicle = not vehicle.NoGarageUI and not vehicle.NoMainWorldGarageSpawn and not vehicle.ExcludeFromSale
			end
		end
	end
	return isValidVehicle
end
local function applySeededSort(itemsTable, seedKey)
	table.sort(itemsTable, function(item1, item2)
		return item1.Pointer[seedKey] < item2.Pointer[seedKey]
	end)
	local randomGenerator = Random.new((SaleUtils.getNumSalesPassed()))
	for index, item in itemsTable do
		item.SortNumber = randomGenerator:NextNumber()
	end
	table.sort(itemsTable, function(item1, item2)
		return item1.SortNumber < item2.SortNumber
	end)
end
local function _getOnSaleVehicleCustomizations()
	local customizationResults = {}
	local seenCategories = {}
	for categoryIndex, categoryName in VehicleConf.CATEGORIES do
		if categoryName ~= SaleConsts.CATEGORY_NAME and not (OwnershipConsts.COLOR_CATEGORY_TYPES[categoryName] or OwnershipConsts.TEXTURE_CATEGORY_TYPES[categoryName]) then
			for customizationIndex, customizationItem in require(ReplicatedStorage.Game.Garage.StoreData:FindFirstChild(categoryName)).Items do
				table.insert(customizationResults, {
					CategoryName = categoryName,
					Pointer = customizationItem
				})
			end
			seenCategories[categoryName] = true
		end
	end
	local categoryCount = 0
	for categoryNameInMap, _ in seenCategories do
		categoryCount = categoryCount + 1
	end
	applySeededSort(customizationResults, "Name")
	local processedCategories = {}
	local onSaleCustomizations = {}
	local customizationsByCategory = {}
	for itemIndex, itemData in customizationResults do
		local CategoryName = itemData.CategoryName
		local Pointer = itemData.Pointer
		local isValidCustomizationItem = not GarageUtils.isVehicleCustomizationLimited(Pointer)
		if isValidCustomizationItem then
			isValidCustomizationItem = not Pointer.None
			if isValidCustomizationItem then
				isValidCustomizationItem = if Pointer.Price and Pointer.Price < 1000000 then Pointer.Price > 0 else false
				isValidCustomizationItem = isValidCustomizationItem and not Pointer.NoGarageUI
			end
		end
		if isValidCustomizationItem and not processedCategories[CategoryName] then
			local clonedCustomization = table.clone(itemData.Pointer)
			clonedCustomization.CategoryName = CategoryName
			table.insert(onSaleCustomizations, clonedCustomization)
			if not customizationsByCategory[CategoryName] then
				customizationsByCategory[CategoryName] = {}
			end
			customizationsByCategory[CategoryName][itemData.Pointer.Name] = true
			processedCategories[CategoryName] = true
		end
		if #onSaleCustomizations >= SaleConsts.NUM_VEHICLE_CUSTOMIZATIONS then
			break
		end
	end
	return onSaleCustomizations, customizationsByCategory
end
local function _getOnSaleVehicles()
	local vehicleResults = {}
	for vehicleIndex, vehicleData in VehicleData do
		table.insert(vehicleResults, {
			Pointer = vehicleData
		})
	end
	applySeededSort(vehicleResults, "Make")
	local onSaleVehicles = {}
	local seenMakes = {}
	for itemIndex, itemData in vehicleResults do
		local Pointer = itemData.Pointer
		local isValidVehicleItem = not GarageUtils.isVehicleLimited(Pointer)
		if isValidVehicleItem then
			isValidVehicleItem = not Pointer.None
			if isValidVehicleItem then
				isValidVehicleItem = if Pointer.Price and Pointer.Price < 1000000 then Pointer.Price > 0 else false
				isValidVehicleItem = isValidVehicleItem and (not Pointer.NoGarageUI and (not Pointer.NoMainWorldGarageSpawn and not Pointer.ExcludeFromSale))
			end
		end
		if isValidVehicleItem then
			table.insert(onSaleVehicles, itemData.Pointer)
			seenMakes[itemData.Pointer.Make] = true
		end
		if #onSaleVehicles >= SaleConsts.NUM_VEHICLES then
			break
		end
	end
	return onSaleVehicles, seenMakes
end
SaleShared._cachedOnSaleVehicleCustomizations = nil
SaleShared._cachedOnSaleVehicleCustomizationsMap = nil
local function cacheOnSaleVehicleCustomizationsIfNeeded()
	if SaleShared._cachedOnSaleVehicleCustomizations == nil then
		local customizationsList, customizationsMap = _getOnSaleVehicleCustomizations()
		SaleShared._cachedOnSaleVehicleCustomizations = customizationsList
		SaleShared._cachedOnSaleVehicleCustomizationsMap = customizationsMap
		task.delay(math.min(60, SaleUtils.getTimeToNextSale() - 1), function()
			SaleShared._cachedOnSaleVehicleCustomizations = nil
			SaleShared._cachedOnSaleVehicleCustomizationsMap = nil
		end)
	end
end
function SaleShared.getOnSaleVehicleCustomizations()
	cacheOnSaleVehicleCustomizationsIfNeeded()
	return SaleShared._cachedOnSaleVehicleCustomizations
end
function SaleShared.isVehicleCustomizationOnSale(categoryName, itemName)
	assert(categoryName ~= nil, "categoryName must not be nil")
	assert(itemName ~= nil, "itemName must not be nil")
	cacheOnSaleVehicleCustomizationsIfNeeded()
	return if SaleShared._cachedOnSaleVehicleCustomizationsMap[categoryName] == nil then false else SaleShared._cachedOnSaleVehicleCustomizationsMap[categoryName][itemName] == true
end
SaleShared._cachedOnSaleVehicles = nil
SaleShared._cachedOnSaleVehiclesMap = nil
local function cacheOnSaleVehiclesIfNeeded()
	if SaleShared._cachedOnSaleVehicles == nil then
		local vehiclesList, vehiclesMap = _getOnSaleVehicles()
		SaleShared._cachedOnSaleVehicles = vehiclesList
		SaleShared._cachedOnSaleVehiclesMap = vehiclesMap
		task.delay(math.min(60, SaleUtils.getTimeToNextSale() - 1), function()
			SaleShared._cachedOnSaleVehicles = nil
			SaleShared._cachedOnSaleVehiclesMap = nil
		end)
	end
end
function SaleShared.getOnSaleVehicles()
	cacheOnSaleVehiclesIfNeeded()
	return SaleShared._cachedOnSaleVehicles
end
function SaleShared.isVehicleOnSale(vehicleMake)
	assert(vehicleMake ~= nil, "vehicleMake must not be nil")
	cacheOnSaleVehiclesIfNeeded()
	return SaleShared._cachedOnSaleVehiclesMap[vehicleMake] == true
end
return SaleShared
