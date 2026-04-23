local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local PortalBase = require(script.Parent.PortalBase)
local GarageConsts = require(script.Parent.Parent.GarageConsts)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local v1 = Roact.PureComponent:extend("PortalSpawn")
function v1.render(p1) --[[ Line: 12 | Upvalues: Players (copy), GarageConsts (copy), GamepassUtils (copy), createElement (copy), PortalBase (copy) ]]
	local t = {}
	local t2 = {}
	for i, v in ipairs(p1.props.receipt) do
		t[v.name] = true
	end
	local t3 = {}
	local Vehicles = p1.props.owned.Vehicles
	if Vehicles then
		for k, v in pairs(Vehicles) do
			if v == true then
				t3[k] = true
			end
		end
	end
	local t4 = {}
	local Vehicles_2 = p1.props.favorited.Vehicles
	if Vehicles_2 then
		for k, v in pairs(Vehicles_2) do
			if v == true then
				t4[k] = true
			end
		end
	end
	for i = 1, #p1.props.items do
		local v1, v2
		local v3 = p1.props.items[i]
		local v4 = t3[v3.name] or false
		v1 = v4 or (not v3.price or v3.price == 0)
		local premium = p1.props.premium
		if not premium then
			premium = p1.props.inPhysical
			if not premium then
				premium = v3.lite
				if not premium then
					premium = Players.LocalPlayer
					if premium then
						premium = Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) == true
					end
				end
			end
		end
		local v5 = premium
		if not v5 then
			v5 = p1.props.gamepassOwned[GamepassUtils.EnumGamepass.BOSS]
			if v5 then
				v5 = v3.name == "Wraith"
			end
		end
		if not v5 then
			v5 = p1.props.gamepassOwned[GamepassUtils.EnumGamepass.SWAT]
			if v5 then
				v5 = v3.name == "SWATVan"
			end
		end
		local t5 = {
			selected = t[v3.name],
			owned = v4,
			faved = t4[v3.name] or false
		}
		v2 = v4 or v1 and v3.available
		t5.masked = not v2
		t5.locked = not v5
		function t5.onSelect() --[[ Line: 61 | Upvalues: t5 (copy), p1 (copy), v3 (copy) ]]
			if t5.masked then
				p1.props.onAttemptPurchaseVehicle(v3, t5)
			else
				p1.props.onClickSpawnVehicle(v3)
			end
		end
		function t5.onFavorite(p12) --[[ Line: 68 | Upvalues: p1 (copy), v3 (copy) ]]
			if p1.props.attemptFavoriteItem then
				p1.props.attemptFavoriteItem("Vehicles", v3.name, p12)
			end
			p1.props.onFavoriteItem("Vehicles", v3.name, p12)
		end
		t2[i] = t5
	end
	return createElement(PortalBase, {
		title = "SPAWN",
		items = p1.props.items,
		metadata = t2,
		sortId = p1.props.sortId,
		cornerPixel = p1.props.cornerPixel,
		portalRatio = p1.props.portalRatio,
		paddingRatio = p1.props.paddingRatio,
		onSelectSort = p1.props.onSelectSort,
		sortEnabled = true,
		showFavorited = p1.props.showFavorited,
		onToggleFavorited = p1.props.onToggleFavorited,
		showAll = p1.props.showAll,
		onToggleAll = p1.props.onToggleAll,
		colsPerRow = p1.props.colsPerRow,
		rowsPerPage = p1.props.rowsPerPage
	})
end
return RoactRodux.connect(function(p1, p2) --[[ Line: 96 ]]
	return {
		receipt = p1.garageReceipt,
		inPhysical = p1.garageInPhysical,
		favorited = p1.garageFavorited,
		gamepassOwned = p1.gamepassOwned,
		premium = p1.garagePremium
	}
end, function(p1) --[[ Line: 105 ]]
	return {
		onFavoriteItem = function(p12, p2, p3) --[[ Name: onFavoriteItem | Line: 107 | Upvalues: p1 (copy) ]]
			p1({
				type = "setCategoryItemFavorited",
				category = p12,
				name = p2,
				favorited = p3
			})
		end
	}
end)(v1)