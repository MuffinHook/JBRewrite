-- Reviewed by Claude
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
local function updateVehicleCamera(p1, p2)
	local v1 = os.clock() / 2
	p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1 * 0.5) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, p2.BoundingBox.Size.Magnitude * 0.8)
end
local function cleanup(p1)
	if p1.inst then
		p1.inst:Destroy()
		p1.inst = nil
	end
	p1.updateCamera = nil
end
local function setPageSpawn(p1, p2)
	local t = {}
	for i, v in ipairs(p1) do
		if v.inst then
			v.inst:Destroy()
			v.inst = nil
		end
		v.updateCamera = nil
	end
	local v1 = PopularSort.getRaw()
	for i = 1, #VehicleData do
		local v2, v3
		local v4 = VehicleData[i]
		if not (v4.NoGarageUI or v4.NoMainWorldGarageSpawn and RunUtils.isMainWorld() or v4.NoTradeWorldGarageSpawn and RunUtils.isTradeWorld()) then
			local v5 = v1.Vehicles[v4.Make]
			if v4.Make == "Camaro" then
				v5 = 0
			end
			local v6 = ItemUtils.createVehicleItemTable(v4.Make)
			local v7 = ItemUtils.getFullNameFromTable(v6)
			local Price = v4.Price
			if SaleShared.isVehicleOnSale(v4.Make) then
				v5, v2, Price = -i, Price, math.floor(Price * SaleConsts.VEHICLE_PRICE_MULTIPLIER)
			else
				v2 = nil
			end
			local t2 = {
				primaryIndex = i,
				salesIndex = v5,
				vehicleType = v4.Type,
				vehicleMake = v4.Make,
				hiddenAll = v4.HiddenAll,
				limited = GarageUtils.isVehicleLimited(v4)
			}
			t2.lite = v4.Lite or SaleShared.isVehicleOnSale(v4.Make)
			t2.name = v4.Make
			t2.title = ItemUtils.getTranslatedTitleFromItemTable(v6)
			t2.offSalePrice = v2
			t2.price = Price
			t2.level = v4.Level
			t2.season = v4.Season
			function t2.getInst()
				return getDefaultVehicleModel(v4.Make, v4.Type)
			end
			t2.updateCamera = updateVehicleCamera
			t2.creatorName = CreatorValues[v7] and CreatorValues[v7].CreatorName
			t2.aerialOnly = v4.AerialSpawn
			if v4.NoMainWorldGarageSpawn then
				v3 = not RunUtils.isMainWorld()
				if v3 then
					v3 = if v4.NoTradeWorldGarageSpawn then not RunUtils.isTradeWorld() and not t2.limited else not t2.limited
				end
			else
				v3 = if v4.NoTradeWorldGarageSpawn then not RunUtils.isTradeWorld() and not t2.limited else not t2.limited
			end
			t2.available = v3
			table.insert(t, t2)
		end
	end
	if p2.sortId then
		table.sort(t, SortUtils.getSortFunc(p2.sortId))
	end
	return t
end
local function setCategory(p1, p2)
	assert(p2.categoryName ~= nil, "missing category Name")
	for i, v in ipairs(p1) do
		if v.inst then
			v.inst:Destroy()
			v.inst = nil
		end
		v.updateCamera = nil
	end
	local categoryName = p2.categoryName
	local v2 = StoreData.GetCategoryByName(categoryName)
	local t = {}
	local v3 = VehicleUtils.GetLocalVehiclePacket()
	local v4 = PopularSort.getRaw()
	local v6
	for v9, v10 in if v2.GetItems then v2.GetItems() else v2.Items do
		local v7, v8
		local v11 = v10.CategoryName or categoryName
		v6 = if v11 == categoryName then v2 else StoreData.GetCategoryByName(v11)
		local v12 = not v10.NoGarageUI
		if v3 then
			if v10.Makes and not v10.Makes[v3.Make] then
				v12 = false
			end
			if v2.IsValidForMake and not v2.IsValidForMake(v10) then
				v12 = false
			end
			local v13 = VehicleConf.MAP_CATEGORY_TO_FUNC[v11]
			if v13 and not v13(v3) then
				v12 = false
			end
		end
		if v12 then
			local v14 = v10.Name
			local v15 = v4[v11] and v4[v11][v14]
			local v16 = GarageItemUtils.getVehicleCustomizationItemOwned(v11, v14)
			local Price = v10.Price
			if SaleShared.isVehicleCustomizationOnSale(v11, v14) then
				v15, v7, Price = -v9, Price, math.floor(Price * SaleConsts.VEHICLE_CUSTOMIZATION_PRICE_MULTIPLIER)
			else
				v7 = nil
			end
			if v10.FakeLimited then
				v15 = -v9
			end
			local v19 = ItemUtils.getFullNameFromTable(v16)
			local v20 = ItemUtils.getTranslatedTitleFromItemTable(v16)
			local t2 = {
				id = v19,
				primaryIndex = v9,
				salesIndex = v15,
				name = v10.Name,
				title = v20,
				offSalePrice = v7,
				price = Price,
				hiddenAll = v10.HiddenAll,
				limited = GarageUtils.isVehicleCustomizationLimited(v10),
				isNone = v10.None,
				level = v10.Level,
				season = v10.Season,
				topPct = v10.TopPct,
				vip = v10.VIP,
				categoryName = v11,
				getInst = function()
					return v6.GetInstance(v10)
				end,
				updateCamera = v6.Update
			}
			v8 = if v6.onItemSelected == nil then false else function()
	return v6.onItemSelected(v10)
end
			t2.onItemSelected = v8
			t2.creatorName = CreatorValues[v19] and CreatorValues[v19].CreatorName
			t2.fakeLimited = v10.FakeLimited
			t2.available = not t2.limited
			table.insert(t, t2)
		end
	end
	if p2.sortId then
		table.sort(t, SortUtils.getSortFunc(p2.sortId))
	end
	return t
end
local function setPageSaves()
	local t = {}
	for i = 1, GarageConsts.NUM_SAVE_SLOTS do
		local v1
		local t2 = {
			name = "s" .. i,
			title = ("Save #%d"):format(i)
		}
		v1 = GarageConsts.NUM_FREE_SAVE_SLOTS < i
		t2.vip = v1
		t2.available = true
		function t2.getInstForSelection(p1)
			local v1 = VehicleUtils.GetLocalVehiclePacket()
			local v2 = getDefaultVehicleModel(v1.Make, v1.Type)
			local v3 = StoreData.GetMapFromSelection(p1)
			Customize.ApplyAll(v3, {
				Model = v2,
				Make = v1.Make,
				Type = v1.Type
			}, p1)
			return v2
		end
		t2.updateCamera = updateVehicleCamera
		table.insert(t, t2)
	end
	return t
end
return Rodux.createReducer({}, {
	setCategory = function(p1, p2)
		return setCategory(p1, p2)
	end,
	setSaveSlot = function()
		return setPageSaves()
	end,
	setPage = function(p1, p2)
		local pageName = p2.pageName
		if pageName == "Spawn" then
			return setPageSpawn(p1, p2)
		end
		if pageName == "Customize" then
			return setCategory(p1, p2)
		end
		if pageName == "Saves" then
			return setPageSaves()
		end
		error("Page not handled by itemsReducer")
	end,
	setSort = function(p1, p2)
		assert(p2.id ~= nil, "missing sort id")
		local t = {}
		for i = 1, #p1 do
			table.insert(t, p1[i])
		end
		table.sort(t, SortUtils.getSortFunc(p2.id))
		return t
	end
})
