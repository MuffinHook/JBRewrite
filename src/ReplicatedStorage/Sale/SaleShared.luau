local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleConf = require(ReplicatedStorage.Game.Garage.VehicleConf)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local SaleConsts = require(ReplicatedStorage.Sale.SaleConsts)
local SaleUtils = require(ReplicatedStorage.Sale.SaleUtils)
local GarageUtils = require(ReplicatedStorage.Garage.GarageUtils)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local Signal = require(ReplicatedStorage.Std.Signal)
local Interval = require(ReplicatedStorage.Std.Interval)
local t = {
	onSaleRefresh = Signal.new()
}
local v1 = SaleUtils.getNextSaleTime()
Interval.every(1):Connect(function() --[[ Line: 17 | Upvalues: SaleUtils (copy), v1 (ref), t (copy) ]]
	local v12 = SaleUtils.getNextSaleTime()
	if v1 + 0.01 < v12 then
		v1 = v12
		t.onSaleRefresh:Fire()
	end
end)
local function canVehicleCustomizationGoOnSale(p1) --[[ Line: 26 | Upvalues: GarageUtils (copy) ]]
	local v1 = not GarageUtils.isVehicleCustomizationLimited(p1)
	if v1 then
		v1 = not p1.None
		if v1 then
			v1 = if p1.Price and p1.Price < 1000000 then p1.Price > 0 else false
			if v1 then
				v1 = not p1.NoGarageUI
			end
		end
	end
	return v1
end
local function canVehicleGoOnSale(p1) --[[ Line: 32 | Upvalues: GarageUtils (copy) ]]
	local v1 = not GarageUtils.isVehicleLimited(p1)
	if v1 then
		v1 = not p1.None
		if v1 then
			v1 = if p1.Price and p1.Price < 1000000 then p1.Price > 0 else false
			if v1 then
				v1 = not p1.NoGarageUI and not p1.NoMainWorldGarageSpawn and not p1.ExcludeFromSale
			end
		end
	end
	return v1
end
local function applySeededSort(p1, p2) --[[ Line: 40 | Upvalues: SaleUtils (copy) ]]
	table.sort(p1, function(p1, p22) --[[ Line: 42 | Upvalues: p2 (copy) ]]
		return p1.Pointer[p2] < p22.Pointer[p2]
	end)
	local v2 = Random.new((SaleUtils.getNumSalesPassed()))
	for v3, v4 in p1 do
		v4.SortNumber = v2:NextNumber()
	end
	table.sort(p1, function(p1, p2) --[[ Line: 52 ]]
		return p1.SortNumber < p2.SortNumber
	end)
end
local function _getOnSaleVehicleCustomizations() --[[ Line: 56 | Upvalues: VehicleConf (copy), SaleConsts (copy), OwnershipConsts (copy), ReplicatedStorage (copy), applySeededSort (copy), GarageUtils (copy) ]]
	local t = {}
	local t2 = {}
	for v1, v2 in VehicleConf.CATEGORIES do
		if v2 ~= SaleConsts.CATEGORY_NAME and not (OwnershipConsts.COLOR_CATEGORY_TYPES[v2] or OwnershipConsts.TEXTURE_CATEGORY_TYPES[v2]) then
			for v3, v4 in require(ReplicatedStorage.Game.Garage.StoreData:FindFirstChild(v2)).Items do
				table.insert(t, {
					CategoryName = v2,
					Pointer = v4
				})
			end
			t2[v2] = true
		end
	end
	local count = 0
	for v5, v6 in t2 do
		count = count + 1
	end
	applySeededSort(t, "Name")
	local t3 = {}
	local t4 = {}
	local t5 = {}
	for v7, v8 in t do
		local CategoryName = v8.CategoryName
		local Pointer = v8.Pointer
		local v9 = not GarageUtils.isVehicleCustomizationLimited(Pointer)
		if v9 then
			v9 = not Pointer.None
			if v9 then
				v9 = if Pointer.Price and Pointer.Price < 1000000 then Pointer.Price > 0 else false
				v9 = v9 and not Pointer.NoGarageUI
			end
		end
		if v9 and not t3[CategoryName] then
			local v10 = table.clone(v8.Pointer)
			v10.CategoryName = CategoryName
			table.insert(t4, v10)
			if not t5[CategoryName] then
				t5[CategoryName] = {}
			end
			t5[CategoryName][v8.Pointer.Name] = true
			t3[CategoryName] = true
		end
		if #t4 >= SaleConsts.NUM_VEHICLE_CUSTOMIZATIONS then
			break
		end
	end
	return t4, t5
end
local function _getOnSaleVehicles() --[[ Line: 113 | Upvalues: VehicleData (copy), applySeededSort (copy), GarageUtils (copy), SaleConsts (copy) ]]
	local t = {}
	for v1, v2 in VehicleData do
		table.insert(t, {
			Pointer = v2
		})
	end
	applySeededSort(t, "Make")
	local t2 = {}
	local t3 = {}
	for v3, v4 in t do
		local Pointer = v4.Pointer
		local v5 = not GarageUtils.isVehicleLimited(Pointer)
		if v5 then
			v5 = not Pointer.None
			if v5 then
				v5 = if Pointer.Price and Pointer.Price < 1000000 then Pointer.Price > 0 else false
				v5 = v5 and (not Pointer.NoGarageUI and (not Pointer.NoMainWorldGarageSpawn and not Pointer.ExcludeFromSale))
			end
		end
		if v5 then
			table.insert(t2, v4.Pointer)
			t3[v4.Pointer.Make] = true
		end
		if #t2 >= SaleConsts.NUM_VEHICLES then
			break
		end
	end
	return t2, t3
end
t._cachedOnSaleVehicleCustomizations = nil
t._cachedOnSaleVehicleCustomizationsMap = nil
local function cacheOnSaleVehicleCustomizationsIfNeeded() --[[ Line: 139 | Upvalues: t (copy), _getOnSaleVehicleCustomizations (copy), SaleUtils (copy) ]]
	if t._cachedOnSaleVehicleCustomizations == nil then
		local v3, v4 = _getOnSaleVehicleCustomizations()
		t._cachedOnSaleVehicleCustomizations = v3
		t._cachedOnSaleVehicleCustomizationsMap = v4
		task.delay(math.min(60, SaleUtils.getTimeToNextSale() - 1), function() --[[ Line: 144 | Upvalues: t (ref) ]]
			t._cachedOnSaleVehicleCustomizations = nil
			t._cachedOnSaleVehicleCustomizationsMap = nil
		end)
	end
end
function t.getOnSaleVehicleCustomizations() --[[ Line: 150 | Upvalues: cacheOnSaleVehicleCustomizationsIfNeeded (copy), t (copy) ]]
	cacheOnSaleVehicleCustomizationsIfNeeded()
	return t._cachedOnSaleVehicleCustomizations
end
function t.isVehicleCustomizationOnSale(p1, p2) --[[ Line: 154 | Upvalues: cacheOnSaleVehicleCustomizationsIfNeeded (copy), t (copy) ]]
	assert(p1 ~= nil, "categoryName must not be nil")
	assert(p2 ~= nil, "itemName must not be nil")
	cacheOnSaleVehicleCustomizationsIfNeeded()
	return if t._cachedOnSaleVehicleCustomizationsMap[p1] == nil then false else t._cachedOnSaleVehicleCustomizationsMap[p1][p2] == true
end
t._cachedOnSaleVehicles = nil
t._cachedOnSaleVehiclesMap = nil
local function cacheOnSaleVehiclesIfNeeded() --[[ Line: 163 | Upvalues: t (copy), _getOnSaleVehicles (copy), SaleUtils (copy) ]]
	if t._cachedOnSaleVehicles == nil then
		local v3, v4 = _getOnSaleVehicles()
		t._cachedOnSaleVehicles = v3
		t._cachedOnSaleVehiclesMap = v4
		task.delay(math.min(60, SaleUtils.getTimeToNextSale() - 1), function() --[[ Line: 167 | Upvalues: t (ref) ]]
			t._cachedOnSaleVehicles = nil
			t._cachedOnSaleVehiclesMap = nil
		end)
	end
end
function t.getOnSaleVehicles() --[[ Line: 173 | Upvalues: cacheOnSaleVehiclesIfNeeded (copy), t (copy) ]]
	cacheOnSaleVehiclesIfNeeded()
	return t._cachedOnSaleVehicles
end
function t.isVehicleOnSale(p1) --[[ Line: 177 | Upvalues: cacheOnSaleVehiclesIfNeeded (copy), t (copy) ]]
	assert(p1 ~= nil, "vehicleMake must not be nil")
	cacheOnSaleVehiclesIfNeeded()
	return t._cachedOnSaleVehiclesMap[p1] == true
end
return t