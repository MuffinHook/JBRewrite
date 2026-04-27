local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HomeItemUIUtils = require(ReplicatedStorage.Home.HomeItem.HomeItemUIUtils)
local Rodux = require(ReplicatedStorage.Rodux)
local function defaultSort(items)
	table.sort(items, function(item1, item2)
		if item1.limited == item2.limited then
			if item1.season == item2.season then
				return item1.name < item2.name
			else
				return (item1.season or (1 / 0)) > (item2.season or (1 / 0))
			end
		else
			return item2.limited
		end
	end)
end
return Rodux.createReducer({}, {
	setFurnitureCategory = function(state, action)
		local items = {}
		for index, item in ReplicatedStorage.Resource.HomeItem:GetChildren() do
			local price, level, season, topPct, upDot, category, maxPlaced, isLimited
			local Price = item:FindFirstChild("Price")
			price = if Price then Price.Value else nil
			local Level = item:FindFirstChild("Level")
			level = if Level then Level.Value else nil
			local Season = item:FindFirstChild("Season")
			season = if Season then Season.Value else nil
			local TopPct = item:FindFirstChild("TopPct")
			topPct = if TopPct then TopPct.Value else nil
			local UpDot = item:FindFirstChild("UpDot")
			upDot = if UpDot then UpDot.Value else nil
			local Category = item:FindFirstChild("Category")
			category = if Category then Category.Value else 1
			local MaxPlaced = item:FindFirstChild("MaxPlaced")
			maxPlaced = if MaxPlaced then MaxPlaced.Value else nil
			if (action.use == nil or action.use == category) and (action.upDot == nil or upDot == nil or not (math.abs(action.upDot - upDot) > 0.01)) then
				local itemName, itemData
				itemName = item.Name
				itemData = {
					module = "HomeItem",
					name = itemName,
					title = itemName,
					price = price,
					level = level,
					season = season,
					topPct = topPct
				}
				isLimited = if level == nil and season == nil then not price else true
				itemData.limited = isLimited
				itemData.maxPlaced = maxPlaced
				function itemData.getInst()
					return HomeItemUIUtils.getModel(itemName)
				end
				itemData.updateCamera = HomeItemUIUtils.getUpdateCamera()
				itemData.getInstCompare = "HomeItem" .. itemName
				itemData.available = not itemData.limited
				table.insert(items, itemData)
			end
		end
		table.sort(items, function(item1, item2)
			if item1.limited == item2.limited then
				if item1.season == item2.season then
					return item1.name < item2.name
				else
					return (item1.season or (1 / 0)) > (item2.season or (1 / 0))
				end
			else
				return item2.limited
			end
		end)
		return items
	end,
	setCategory = function(state, action)
		assert(action.module ~= nil, "setCategory requires a module name")
		local moduleInstance = ReplicatedStorage.Home.HomeData:FindFirstChild(action.module)
		assert(moduleInstance, "setCategory requires a valid module name")
		local categoryModule = require(moduleInstance)
		local items = {}
		for index, itemData in categoryModule.getItems() do
			local isLimited
			if not (itemData.HiddenAll or (itemData.Hidden or itemData.VIP)) then
				local itemDataTable = {
					module = action.module,
					name = itemData.Name,
					title = itemData.Name,
					price = itemData.Price,
					level = itemData.Level,
					season = itemData.Season,
					topPct = itemData.TopPct,
					getInst = function()
						return categoryModule.getInstance(itemData)
					end,
					updateCamera = categoryModule.updateCamera,
					getInstCompare = action.module .. itemData.Name
				}
				isLimited = if itemDataTable.level == nil and itemDataTable.season == nil then not itemDataTable.price and not itemData.None else not itemData.None
				itemDataTable.limited = isLimited
				itemDataTable.available = not itemDataTable.limited
				table.insert(items, itemDataTable)
			end
		end
		table.sort(items, function(item1, item2)
			if item1.limited == item2.limited then
				if item1.season == item2.season then
					return item1.name < item2.name
				else
					return (item1.season or (1 / 0)) > (item2.season or (1 / 0))
				end
			else
				return item2.limited
			end
		end)
		return items
	end
})
