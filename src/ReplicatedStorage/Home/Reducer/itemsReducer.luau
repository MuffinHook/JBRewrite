-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HomeItemUIUtils = require(ReplicatedStorage.Home.HomeItem.HomeItemUIUtils)
local Rodux = require(ReplicatedStorage.Rodux)
local function defaultSort(p1)
	table.sort(p1, function(p1, p2)
		if p1.limited == p2.limited then
			if p1.season == p2.season then
				return p1.name < p2.name
			else
				return (p1.season or (1 / 0)) > (p2.season or (1 / 0))
			end
		else
			return p2.limited
		end
	end)
end
return Rodux.createReducer({}, {
	setFurnitureCategory = function(p1, p2)
		local t = {}
		for v9, v10 in ReplicatedStorage.Resource.HomeItem:GetChildren() do
			local v1, v2, v3, v4, v5, v6, v7, v8
			local Price = v10:FindFirstChild("Price")
			v1 = if Price then Price.Value else nil
			local Level = v10:FindFirstChild("Level")
			v2 = if Level then Level.Value else nil
			local Season = v10:FindFirstChild("Season")
			v3 = if Season then Season.Value else nil
			local TopPct = v10:FindFirstChild("TopPct")
			v4 = if TopPct then TopPct.Value else nil
			local UpDot = v10:FindFirstChild("UpDot")
			v5 = if UpDot then UpDot.Value else nil
			local Category = v10:FindFirstChild("Category")
			v6 = if Category then Category.Value else 1
			local MaxPlaced = v10:FindFirstChild("MaxPlaced")
			v7 = if MaxPlaced then MaxPlaced.Value else nil
			if (p2.use == nil or p2.use == v6) and (p2.upDot == nil or v5 == nil or not (math.abs(p2.upDot - v5) > 0.01)) then
				local v11, v12
				v11 = v10.Name
				v12 = {
					module = "HomeItem",
					name = v11,
					title = v11,
					price = v1,
					level = v2,
					season = v3,
					topPct = v4
				}
				v8 = if v2 == nil and v3 == nil then not v1 else true
				v12.limited = v8
				v12.maxPlaced = v7
				function v12.getInst()
					return HomeItemUIUtils.getModel(v11)
				end
				v12.updateCamera = HomeItemUIUtils.getUpdateCamera()
				v12.getInstCompare = "HomeItem" .. v11
				v12.available = not v12.limited
				table.insert(t, v12)
			end
		end
		table.sort(t, function(p1, p2)
			if p1.limited == p2.limited then
				if p1.season == p2.season then
					return p1.name < p2.name
				else
					return (p1.season or (1 / 0)) > (p2.season or (1 / 0))
				end
			else
				return p2.limited
			end
		end)
		return t
	end,
	setCategory = function(p1, p2)
		assert(p2.module ~= nil, "setCategory requires a module name")
		local v1 = ReplicatedStorage.Home.HomeData:FindFirstChild(p2.module)
		assert(v1, "setCategory requires a valid module name")
		local v2 = require(v1)
		local t = {}
		for v4, v5 in v2.getItems() do
			local v3
			if not (v5.HiddenAll or (v5.Hidden or v5.VIP)) then
				local t2 = {
					module = p2.module,
					name = v5.Name,
					title = v5.Name,
					price = v5.Price,
					level = v5.Level,
					season = v5.Season,
					topPct = v5.TopPct,
					getInst = function()
						return v2.getInstance(v5)
					end,
					updateCamera = v2.updateCamera,
					getInstCompare = p2.module .. v5.Name
				}
				v3 = if t2.level == nil and t2.season == nil then not t2.price and not v5.None else not v5.None
				t2.limited = v3
				t2.available = not t2.limited
				table.insert(t, t2)
			end
		end
		table.sort(t, function(p1, p2)
			if p1.limited == p2.limited then
				if p1.season == p2.season then
					return p1.name < p2.name
				else
					return (p1.season or (1 / 0)) > (p2.season or (1 / 0))
				end
			else
				return p2.limited
			end
		end)
		return t
	end
})
